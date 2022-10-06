import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:weki/layout/cubit/states.dart';
import 'package:weki/models/comment/comment.dart';
import 'package:weki/models/message/message_model.dart';
import 'package:weki/models/post/post.dart';
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
    if (index == 1) getAllUsers();
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

  File? postImage;

  Future<void> getPostImage() async {
    final pickedFile = await picker.getImage(
      source: ImageSource.gallery,
    );

    if (pickedFile != null) {
      postImage = File(pickedFile.path);
      emit(AppGetPostImagePickedSuccessState());
    } else {
      print('No image selected.');
      emit(AppGetPostImagePickedFailureState());
    }
  }

  uploadPost({
    required postData,
    required postText,
  }) {
    emit(AppCreatePostLoadingState());
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child("posts/${Uri.file(postImage!.path).pathSegments.last}")
        .putFile(postImage!)
        .then((value) {
      value.ref.getDownloadURL().then((imageLink) {
        createPost(
            postData: postData, postText: postText, postImage: imageLink);
        print(imageLink);
      }).catchError((error) {
        emit(AppCreatePostFailureState());
      });
    }).catchError((error) {
      emit(AppCreatePostFailureState());
    });
  }

  createPost({required postData, required postText, String? postImage}) {
    PostsModel model = PostsModel(
      name: userModel!.name,
      image: userModel!.image,
      postDate: postData,
      postImage: postImage ?? "Without post image..",
      postText: postText,
      uId: userModel!.uId,
    );
    FirebaseFirestore.instance
        .collection("posts")
        .add(model.toMap()!)
        .then((value) {
      emit(AppCreatePostSuccessState());
    }).catchError((error) {
      emit(AppCreatePostFailureState());
    });
  }

  removePostImage() {
    postImage = null;
    emit(AppRemovePostImageState());
  }

  List<PostsModel> posts = [];
  List<String> postId = [];

  // List<int> postLikes = [];
  Map<String, int> postLikes = {};
  Map<String, int> commentNum = {};

  getPosts() {
    emit(AppGetPostsLoadingState());
    FirebaseFirestore.instance
        .collection("posts")
        .orderBy("postDate")
        .snapshots()
        .listen((value) {
      posts = [];
      for (var comment in value.docs) {
        comment.reference.collection("comments").snapshots().listen((value) {
          comments = [];
          commentNum.addAll({comment.id: value.docs.length});
          emit(AppGetPostsSuccessState());
        });
      }
      for (var like in value.docs) {
        like.reference.collection("likes").snapshots().listen((value) {
          postLikes.addAll({like.id: value.docs.length});
          postId.add(like.id);
          posts.add(PostsModel.fromJson(like.data()));
          emit(AppGetPostsSuccessState());
        });
      }
    });
  }

  likePost(postId) {
    FirebaseFirestore.instance
        .collection("posts")
        .doc(postId)
        .collection("likes")
        // .doc(userModel!.uId)
        .add({"liked": true}).then((value) {
      emit(AppLikePostSuccessState());
    }).catchError((error) {
      emit(AppLikePostFailureState());
    });
  }

  commentPost(
      {required String commentId,
      required String commentText,
      required String commentDate}) {
    CommentModel model = CommentModel(
        uId: userModel!.uId,
        image: userModel!.image,
        name: userModel!.name,
        commentText: commentText,
        commentDate: commentDate);
    FirebaseFirestore.instance
        .collection("posts")
        .doc(commentId)
        .collection("comments")
        .add(model.toMap()!)
        .then((value) {
      emit(AppCommentPostSuccessState());
    }).catchError((error) {
      emit(AppCommentPostFailureState());
    });
  }

  List<CommentModel> comments = [];

  getCommentPosts({required String postId}) {
    FirebaseFirestore.instance
        .collection("posts")
        .doc(postId)
        .collection("comments")
        .orderBy("commentDate")
        .snapshots()
        .listen((event) {
      comments = [];
      event.docs.forEach((element) {
        comments.add(CommentModel.fromJson(element.data()));
      });
      emit(AppGetCommentPostsSuccessState());
    });
  }

  List<UserModel> users = [];

  getAllUsers() {
    if (users.isEmpty)
      FirebaseFirestore.instance.collection("users").get().then((value) {
        value.docs.forEach((element) {
          if (element.data()["uId"] != userModel!.uId)
            users.add(UserModel.fromJson(element.data()));
        });
        emit(AppGetUsersSuccessState());
      }).catchError((error) {
        emit(AppGetUsersFailureState());
      });
  }

  sendMessage({
    required String? receiverId,
    required String? messageText,
    required String? messageDate,
  }) {
    MessageModel model = MessageModel(
        receiverId: receiverId,
        messageText: messageText,
        messageDate: messageDate,
        senderId: userModel!.uId);
    //my message
    FirebaseFirestore.instance
        .collection("users")
        .doc(userModel!.uId)
        .collection("chats")
        .doc(receiverId)
        .collection("messages")
        .add(model.toMap())
        .then((value) {
      emit(AppSendMessageSuccessState());
    }).catchError((error) {
      emit(AppSendMessageFailureState());
    });

    //receiver message
    FirebaseFirestore.instance
        .collection("users")
        .doc(receiverId)
        .collection("chats")
        .doc(userModel!.uId)
        .collection("messages")
        .add(model.toMap())
        .then((value) {
      emit(AppSendMessageSuccessState());
    }).catchError((error) {
      emit(AppSendMessageFailureState());
    });
  }

  List<MessageModel> messages = [];

  getMessages({
    required String? receiverId,
  }) {
    FirebaseFirestore.instance
        .collection("users")
        .doc(userModel!.uId)
        .collection("chats")
        .doc(receiverId)
        .collection("messages")
        .orderBy("messageDate")
        .snapshots()
        .listen((event) {
      messages = [];
      event.docs.forEach((element) {
        messages.add(MessageModel.fromJson(element.data()));
      });
      emit(AppGetMessagesSuccessState());
    });
  }
}
