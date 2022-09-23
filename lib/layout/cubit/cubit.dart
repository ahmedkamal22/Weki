import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:weki/layout/cubit/states.dart';
import 'package:weki/models/user/user_model.dart';
import 'package:weki/modules/chats/chats.dart';
import 'package:weki/modules/feeds/feeds.dart';
import 'package:weki/modules/posts/posts.dart';
import 'package:weki/modules/settings/settings.dart';
import 'package:weki/modules/users/users.dart';
import 'package:weki/shared/components/constants.dart';
import 'package:weki/shared/network/local/cache_helper.dart';
import 'package:weki/shared/styles/icon_broken.dart';

class AppCubit extends Cubit<AppStates> {
  AppCubit() : super(AppInitialState());

  static AppCubit get(context) => BlocProvider.of(context);

  bool isDark = true;

  changeMode({bool? fromShared}) {
    if (fromShared != null) {
      isDark = fromShared;
      emit(AppChangeModeState());
    } else {
      isDark = !isDark;
      CacheHelper.saveData(key: "isDark", value: isDark).then((value) {
        emit(AppChangeModeState());
      });
    }
  }

  UserModel? userModel;

  getUserData() {
    emit(AppGetDataLoadingState());
    FirebaseFirestore.instance.collection("users").doc(uId).get().then((value) {
      userModel = UserModel.fromJson(value.data()!);
      emit(AppGetDataSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(AppGetDataFailureState(error.toString()));
    });
  }

  int currentIndex = 0;

  changeBottomNav(int index) {
    if (index == 2) {
      emit(AppNewPostState());
    } else {
      currentIndex = index;
      emit(AppChangeBottomNavState());
    }
  }

  List<Widget> screens = [
    FeedsScreen(),
    ChatsScreen(),
    PostsScreen(),
    UsersScreen(),
    SettingsScreen(),
  ];
  List<String> titels = [
    "Home",
    "Chats",
    "Posts",
    "Users",
    "Settings",
  ];

  List<BottomNavigationBarItem> items = [
    BottomNavigationBarItem(
      icon: Icon(IconBroken.Home),
      label: "Home",
    ),
    BottomNavigationBarItem(
      icon: Icon(IconBroken.Chat),
      label: "Chats",
    ),
    BottomNavigationBarItem(
      icon: Icon(IconBroken.Paper_Upload),
      label: "Post",
    ),
    BottomNavigationBarItem(
      icon: Icon(IconBroken.Location),
      label: "Users",
    ),
    BottomNavigationBarItem(
      icon: Icon(IconBroken.Setting),
      label: "Settings",
    ),
  ];

  File? profileImage;
  var picker = ImagePicker();

  Future<void> getProfileImage() async {
    final pickedFile = await picker.getImage(
      source: ImageSource.gallery,
    );

    if (pickedFile != null) {
      profileImage = File(pickedFile.path);
      print(pickedFile.path);
      emit(AppGetProfileImagePickedSuccessState());
    } else {
      print('No image selected.');
      emit(AppGetProfileImagePickedFailureState());
    }
  }

  File? coverImage;

  Future<void> getCoverImage() async {
    final pickedFile = await picker.getImage(
      source: ImageSource.gallery,
    );
    if (pickedFile != null) {
      coverImage = File(pickedFile.path);
      emit(AppGetCoverImagePickedSuccessState());
    } else {
      print('No image selected.');
      emit(AppGetCoverImagePickedFailureState());
    }
  }

  uploadProfileImage({
    required String name,
    required String bio,
    required String email,
    required String phone,
  }) {
    emit(AppUpdateImageLoadingState());
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child("users/${Uri.file(profileImage!.path).pathSegments.last}")
        .putFile(profileImage!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        print(value);
        updateData(
          name: name,
          bio: bio,
          email: email,
          phone: phone,
          image: value,
        );
      }).catchError((error) {
        print(error.toString());
        emit(AppUploadProfileImageFailureState());
      });
    }).catchError((error) {
      emit(AppUploadProfileImageFailureState());
    });
  }

  uploadCoverImage({
    required String name,
    required String bio,
    required String email,
    required String phone,
  }) {
    emit(AppUpdateCoverLoadingState());
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child("users/${Uri.file(coverImage!.path).pathSegments.last}")
        .putFile(coverImage!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        print(value);
        updateData(
            name: name, bio: bio, email: email, phone: phone, cover: value);
      }).catchError((error) {
        emit(AppUploadCoverImageFailureState());
      });
    }).catchError((error) {
      emit(AppUploadCoverImageFailureState());
    });
  }

  updateData({
    required String name,
    required String bio,
    required String email,
    required String phone,
    String? image,
    String? cover,
  }) {
    emit(AppUpdateDataLoadingState());
    UserModel model = UserModel(
      image: image ?? userModel!.image,
      bio: bio,
      cover: cover ?? userModel!.cover,
      email: email,
      name: name,
      phone: phone,
      uId: userModel!.uId,
      isEmailVerified: false,
    );
    FirebaseFirestore.instance
        .collection("users")
        .doc(userModel!.uId)
        .update(model.toMap())
        .then((value) {
      getUserData();
    }).catchError((error) {
      emit(AppUpdateDataErrorState());
    });
  }
}
