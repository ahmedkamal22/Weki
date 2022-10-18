import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weki/layout/cubit/cubit.dart';
import 'package:weki/layout/cubit/states.dart';
import 'package:weki/modules/posts/posts.dart';
import 'package:weki/modules/search/search.dart';
import 'package:weki/shared/components/components.dart';
import 'package:weki/shared/styles/icon_broken.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(listener: (context, state) {
      if (state is AppNewPostState) {
        navigateTo(context: context, widget: PostsScreen());
      }
    }, builder: (context, state) {
      var cubit = AppCubit.get(context);
      return Scaffold(
        appBar: AppBar(
          title: Text(
            "${cubit.titels[cubit.currentIndex]}",
            style: Theme.of(context).textTheme.bodyText1!.copyWith(
                  color: AppCubit.get(context).isDark
                      ? Colors.white
                      : Colors.black,
                ),
          ),
          actions: [
            // IconButton(
            //   onPressed: () {},
            //   icon: Icon(IconBroken.Notification),
            // ),
            IconButton(
              onPressed: () {
                navigateTo(context: context, widget: SearchScreen());
              },
              icon: Icon(IconBroken.Search),
            ),
            IconButton(
              onPressed: () {
                AppCubit.get(context).changeMode();
              },
              icon: AppCubit.get(context).isDark
                  ? Icon(Icons.brightness_3)
                  : Icon(Icons.brightness_4_outlined),
            ),
            defaultTextButton(
                onPressed: () {
                  signOut(context: context);
                },
                text: "log out",
                style: TextStyle(fontSize: 20))
          ],
        ),
        body: cubit.screens[cubit.currentIndex],
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: cubit.currentIndex,
          onTap: (index) {
            cubit.changeBottomNav(index);
          },
          items: cubit.items,
        ),
      );
    });
  }
}
