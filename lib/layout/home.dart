import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weki/layout/cubit/cubit.dart';
import 'package:weki/layout/cubit/states.dart';
import 'package:weki/modules/posts/posts.dart';
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
            style: Theme.of(context).textTheme.bodyText1,
          ),
          actions: [
            IconButton(
              onPressed: () {},
              icon: Icon(IconBroken.Notification),
            ),
            IconButton(
              onPressed: () {},
              icon: Icon(IconBroken.Search),
            ),
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
