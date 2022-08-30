import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weki/modules/home/cubit/cubit.dart';
import 'package:weki/modules/home/cubit/states.dart';
import 'package:weki/shared/components/components.dart';

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
          );
        });
  }
}
