import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weki/modules/home/cubit/cubit.dart';
import 'package:weki/modules/home/home.dart';
import 'package:weki/modules/login/cubit/cubit.dart';
import 'package:weki/modules/login/cubit/states.dart';
import 'package:weki/modules/register/register.dart';
import 'package:weki/shared/components/components.dart';
import 'package:weki/shared/network/local/cache_helper.dart';
import 'package:weki/shared/styles/colors.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({Key? key}) : super(key: key);
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginCubit(),
      child: BlocConsumer<LoginCubit, LoginStates>(
        listener: (context, state) {
          if (state is LoginSuccessState) {
            CacheHelper.saveData(key: "token", value: true).then((value) {
              navigateAndFinish(context: context, widget: HomeScreen());
            });
          }
        },
        builder: (context, state) {
          var cubit = LoginCubit.get(context);
          Color cubitColor = AppCubit.get(context).isDark
              ? Colors.white.withOpacity(.9)
              : Colors.black.withOpacity(.6);
          return Scaffold(
            appBar: AppBar(),
            body: Form(
              key: formKey,
              child: Center(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Login",
                          style: Theme.of(context)
                              .textTheme
                              .bodyText1!
                              .copyWith(fontSize: 25, color: cubitColor),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Text(
                          "Login now to communicate with your friends",
                          style: Theme.of(context)
                              .textTheme
                              .bodyText1!
                              .copyWith(
                                  color: Colors.grey,
                                  fontWeight: FontWeight.normal,
                                  fontSize: 16),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        defaultFormField(
                          controller: emailController,
                          keyboardType: TextInputType.emailAddress,
                          label: "Email Address",
                          prefix: Icons.email,
                          validate: (value) {
                            if (value!.isEmpty) {
                              return "Email Address mustn't be empty";
                            }
                            return null;
                          },
                          generalWidgetsColor: cubitColor,
                          style: Theme.of(context)
                              .textTheme
                              .bodyText1!
                              .copyWith(
                                  color: cubitColor,
                                  fontWeight: FontWeight.normal),
                          radius: 20.0,
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        defaultFormField(
                          controller: passwordController,
                          keyboardType: TextInputType.visiblePassword,
                          label: "Password",
                          prefix: Icons.lock,
                          validate: (value) {
                            if (value!.isEmpty) {
                              return "Password mustn't be empty";
                            }
                            return null;
                          },
                          generalWidgetsColor: cubitColor,
                          style: Theme.of(context)
                              .textTheme
                              .bodyText1!
                              .copyWith(
                                  color: cubitColor,
                                  fontWeight: FontWeight.normal),
                          radius: 20.0,
                          isPassword: cubit.isPassword,
                          suffix: cubit.suffix,
                          suffixPressed: () {
                            cubit.changePasswordVisibility();
                          },
                        ),
                        SizedBox(
                          height: 25,
                        ),
                        ConditionalBuilder(
                          condition: state is! LoginLoadingState,
                          builder: (context) => defaultButton(
                            onPressed: () {
                              if (formKey.currentState!.validate()) {
                                cubit.userLogin(
                                    email: emailController.text,
                                    password: passwordController.text);
                              }
                            },
                            text: "login",
                            radius: 20.0,
                            isUpper: true,
                          ),
                          fallback: (context) =>
                              Center(child: CircularProgressIndicator()),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Don't have an account?",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText1!
                                  .copyWith(fontSize: 16, color: cubitColor),
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            defaultTextButton(
                              onPressed: () {
                                navigateTo(
                                    context: context, widget: RegisterScreen());
                              },
                              text: "register",
                              isUpper: true,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText1!
                                  .copyWith(color: defaultColor, fontSize: 16),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
