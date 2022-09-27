import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weki/layout/cubit/cubit.dart';
import 'package:weki/layout/cubit/states.dart';
import 'package:weki/layout/home.dart';
import 'package:weki/modules/boarding/boarding.dart';
import 'package:weki/modules/login/login.dart';
import 'package:weki/shared/components/constants.dart';
import 'package:weki/shared/network/local/cache_helper.dart';
import 'package:weki/shared/styles/themes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  // DioHelper.getInit();
  await CacheHelper.init();
  await Firebase.initializeApp();
  var boarding = CacheHelper.getData(key: "boarding");
  uId = CacheHelper.getData(key: "uId");
  var isDark = CacheHelper.getData(key: "isDark");
  Widget widget;
  if (boarding != null) {
    if (uId != null) {
      widget = HomeScreen();
    } else {
      widget = LoginScreen();
    }
  } else {
    widget = BoardingScreen();
  }
  runApp(MyApp(
    startWidget: widget,
    isDark: isDark,
  ));
}

class MyApp extends StatelessWidget {
  @required
  Widget? startWidget;
  @required
  bool? isDark;

  MyApp({this.startWidget, this.isDark});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AppCubit()
        ..changeMode(fromShared: isDark)
        ..getUserData()
        ..getPosts()
        ..getAllUsers(),
      child: BlocConsumer<AppCubit, AppStates>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit = AppCubit.get(context);
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: lightTheme,
            darkTheme: darkTheme,
            themeMode: cubit.isDark ? ThemeMode.dark : ThemeMode.light,
            home: startWidget,
          );
        },
      ),
    );
  }
}

