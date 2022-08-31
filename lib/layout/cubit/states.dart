abstract class AppStates {}

class AppInitialState extends AppStates {}

class AppGetDataLoadingState extends AppStates {}

class AppGetDataSuccessState extends AppStates {}

class AppGetDataFailureState extends AppStates {
  String error;

  AppGetDataFailureState(this.error);
}

class AppChangeModeState extends AppStates {}

class AppChangeBottomNavState extends AppStates {}

class AppNewPostState extends AppStates {}
