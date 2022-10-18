import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weki/layout/cubit/cubit.dart';
import 'package:weki/layout/cubit/states.dart';
import 'package:weki/modules/profile/edit_profile.dart';
import 'package:weki/shared/components/components.dart';
import 'package:weki/shared/styles/icon_broken.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var model = AppCubit.get(context).userModel;
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Container(
                height: 220,
                child: Stack(
                  alignment: AlignmentDirectional.bottomCenter,
                  children: [
                    Align(
                      child: Container(
                        width: double.infinity,
                        height: 160,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                              image: NetworkImage("${model!.cover}"),
                              fit: BoxFit.cover,
                            ),
                            borderRadius: BorderRadiusDirectional.only(
                              topStart: Radius.circular(8),
                              topEnd: Radius.circular(8),
                            )),
                      ),
                      alignment: AlignmentDirectional.topCenter,
                    ),
                    CircleAvatar(
                      radius: 75,
                      backgroundColor:
                          Theme.of(context).scaffoldBackgroundColor,
                      child: CircleAvatar(
                        radius: 72,
                        backgroundImage: NetworkImage("${model.image}"),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsetsDirectional.only(
                  top: 15,
                ),
                child: Text(
                  "${model.name}",
                  style: Theme.of(context).textTheme.bodyText1!.copyWith(
                        color: AppCubit.get(context).isDark
                            ? Colors.white
                            : Colors.black,
                      ),
                ),
              ),
              Padding(
                padding: const EdgeInsetsDirectional.only(top: 10, bottom: 30),
                child: Text(
                  "${model.bio}",
                  style: Theme.of(context).textTheme.caption!.copyWith(
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                        color: AppCubit.get(context).isDark
                            ? Colors.grey[300]
                            : Colors.black.withOpacity(.8),
                      ),
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: Column(
                      children: [
                        Text(
                          "0",
                          style:
                              Theme.of(context).textTheme.bodyText1!.copyWith(
                                    color: AppCubit.get(context).isDark
                                        ? Colors.grey[300]
                                        : Colors.black,
                                  ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text("Posts",
                            style: Theme.of(context)
                                .textTheme
                                .bodyText1!
                                .copyWith(
                                    color: AppCubit.get(context).isDark
                                        ? Colors.white
                                        : Colors.black,
                                    fontSize: 16)),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Column(
                      children: [
                        Text(
                          "0",
                          style:
                              Theme.of(context).textTheme.bodyText1!.copyWith(
                                    color: AppCubit.get(context).isDark
                                        ? Colors.grey[300]
                                        : Colors.black,
                                  ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text("Fiends",
                            style: Theme.of(context)
                                .textTheme
                                .bodyText1!
                                .copyWith(
                                    color: AppCubit.get(context).isDark
                                        ? Colors.white
                                        : Colors.black,
                                    fontSize: 16)),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Column(
                      children: [
                        Text(
                          "0",
                          style:
                              Theme.of(context).textTheme.bodyText1!.copyWith(
                                    color: AppCubit.get(context).isDark
                                        ? Colors.grey[300]
                                        : Colors.black,
                                  ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text("Likes",
                            style: Theme.of(context)
                                .textTheme
                                .bodyText1!
                                .copyWith(
                                    color: AppCubit.get(context).isDark
                                        ? Colors.white
                                        : Colors.black,
                                    fontSize: 16)),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Column(
                      children: [
                        Text(
                          "0",
                          style:
                              Theme.of(context).textTheme.bodyText1!.copyWith(
                                    color: AppCubit.get(context).isDark
                                        ? Colors.grey[300]
                                        : Colors.black,
                                  ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text("Followers",
                            style: Theme.of(context)
                                .textTheme
                                .bodyText1!
                                .copyWith(
                                    color: AppCubit.get(context).isDark
                                        ? Colors.white
                                        : Colors.black,
                                    fontSize: 16)),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                        onPressed: () {
                          navigateTo(context: context, widget: EditProfile());
                        },
                        child: Text("Edit Profile")),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  OutlinedButton(
                    onPressed: () {
                      navigateTo(context: context, widget: EditProfile());
                    },
                    child: Icon(
                      IconBroken.Edit,
                      size: 16,
                      color: Colors.blue,
                    ),
                  )
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
