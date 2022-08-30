import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weki/layout/cubit/cubit.dart';
import 'package:weki/layout/cubit/states.dart';
import 'package:weki/shared/components/components.dart';
import 'package:weki/shared/styles/colors.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit = AppCubit.get(context);
          return Scaffold(
            appBar: AppBar(
              title: Text(
                "Weki",
                style: Theme.of(context).textTheme.bodyText1!.copyWith(
                    color: cubit.isDark ? Colors.grey[200] : Colors.black),
              ),
              actions: [
                IconButton(
                    onPressed: () {
                      cubit.changeMode();
                    },
                    icon: Icon(
                      cubit.isDark
                          ? Icons.brightness_4_outlined
                          : Icons.brightness_4,
                    )),
                defaultTextButton(
                  onPressed: () {
                    signOut(context: context);
                  },
                  text: "log out",
                  isUpper: true,
                )
              ],
            ),
            body: Padding(
              padding: const EdgeInsets.all(20.0),
              child: ConditionalBuilder(
                condition: cubit.userModel != null,
                builder: (context) => Column(
                  children: [
                    if (!FirebaseAuth.instance.currentUser!.emailVerified)
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20.0),
                          color: Colors.amberAccent,
                        ),
                        child: Row(
                          children: [
                            Icon(Icons.info_outline),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              "Please Verify your email address",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText1!
                                  .copyWith(
                                      color: cubit.isDark
                                          ? Colors.grey[200]
                                          : Colors.black,
                                      fontSize: 16),
                            ),
                            Spacer(),
                            defaultTextButton(
                              onPressed: () {
                                FirebaseAuth.instance.currentUser!
                                    .sendEmailVerification()
                                    .then((value) {
                                  showToast(
                                      msg: "Check your mail",
                                      state: ToastStates.Success);
                                });
                              },
                              text: "Verify",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText1!
                                  .copyWith(color: defaultColor, fontSize: 16),
                            )
                          ],
                        ),
                      ),
                  ],
                ),
                fallback: (context) =>
                    Center(child: CircularProgressIndicator()),
              ),
            ),
          );
        });
  }
}
