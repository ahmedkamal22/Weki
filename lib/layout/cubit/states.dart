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

class AppGetProfileImagePickedSuccessState extends AppStates {}

class AppGetProfileImagePickedFailureState extends AppStates {}

class AppGetCoverImagePickedSuccessState extends AppStates {}

class AppGetCoverImagePickedFailureState extends AppStates {}

class AppUploadProfileImageSuccessState extends AppStates {}

class AppUploadProfileImageFailureState extends AppStates {}

class AppUploadCoverImageSuccessState extends AppStates {}

class AppUploadCoverImageFailureState extends AppStates {}

class AppUpdateDataLoadingState extends AppStates {}

class AppUpdateDataErrorState extends AppStates {}

class AppUpdateImageLoadingState extends AppStates {}

class AppUpdateCoverLoadingState extends AppStates {}

class AppGetPostImagePickedSuccessState extends AppStates {}

class AppGetPostImagePickedFailureState extends AppStates {}

class AppCreatePostLoadingState extends AppStates {}

class AppCreatePostSuccessState extends AppStates {}

class AppCreatePostFailureState extends AppStates {}

class AppRemovePostImageState extends AppStates {}