import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weki/layout/cubit/cubit.dart';
import 'package:weki/layout/cubit/states.dart';
import 'package:weki/shared/components/components.dart';
import 'package:weki/shared/styles/icon_broken.dart';

class PostsScreen extends StatelessWidget {
  PostsScreen({Key? key}) : super(key: key);
  var postTextController = TextEditingController();
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = AppCubit.get(context);
        return Scaffold(
          appBar: defaultAppBar(
            context: context,
            title: "Create Post",
            actions: [
              defaultTextButton(
                onPressed: () {
                  if (formKey.currentState!.validate()) {
                    if (cubit.postImage == null) {
                      cubit.createPost(
                          postData: DateTime.now().toString(),
                          postText: postTextController.text);
                    } else {
                      cubit.uploadPost(
                          postData: DateTime.now().toString(),
                          postText: postTextController.text);
                    }
                    postTextController.clear();
                  }
                },
                text: "post",
                isUpper: true,
                style: TextStyle(fontSize: 16),
              ),
            ],
          ),
          body: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Form(
              key: formKey,
              child: Expanded(
                child: Column(
                  children: [
                    if (state is AppCreatePostLoadingState)
                      Column(
                        children: [
                          LinearProgressIndicator(),
                          SizedBox(
                            height: 10,
                          ),
                        ],
                      ),
                    Row(
                      children: [
                        CircleAvatar(
                          radius: 30,
                          backgroundImage:
                              NetworkImage("${cubit.userModel!.image}"),
                        ),
                        SizedBox(
                          width: 15,
                        ),
                        Expanded(
                          child: Text(
                            "${cubit.userModel!.name}",
                            style: Theme.of(context)
                                .textTheme
                                .bodyText1!
                                .copyWith(fontSize: 18),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Expanded(
                      child: TextFormField(
                        controller: postTextController,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "This field can't be null";
                          }
                          return null;
                        },
                        onFieldSubmitted: (value) {
                          if (formKey.currentState!.validate()) {
                            if (cubit.postImage == null) {
                              cubit.createPost(
                                  postData: DateTime.now().toString(),
                                  postText: postTextController.text);
                            } else {
                              cubit.uploadPost(
                                  postData: DateTime.now().toString(),
                                  postText: postTextController.text);
                            }
                          }
                        },
                        decoration: InputDecoration(
                          hintText: "What's on your mind?",
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    if (cubit.postImage != null)
                      Stack(
                        alignment: AlignmentDirectional.topEnd,
                        children: [
                          Container(
                            height: 140,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(4.0),
                              image: DecorationImage(
                                  image: FileImage(cubit.postImage!),
                                  fit: BoxFit.cover),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsetsDirectional.only(
                                top: 5, end: 5),
                            child: CircleAvatar(
                              radius: 16,
                              backgroundColor: Colors.blue,
                              child: IconButton(
                                iconSize: 17,
                                icon: Icon(Icons.close),
                                onPressed: () {
                                  cubit.removePostImage();
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                    SizedBox(
                      height: 30,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Row(
                        children: [
                          Padding(
                            padding:
                                const EdgeInsetsDirectional.only(start: 30),
                            child: Expanded(
                              child: InkWell(
                                onTap: () {
                                  cubit.getPostImage();
                                },
                                child: Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(IconBroken.Image,
                                          color: Colors.blue),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      Text(
                                        "add photo",
                                        style: TextStyle(
                                            fontSize: 16, color: Colors.blue),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Spacer(),
                          Expanded(
                            child: InkWell(
                              onTap: () {},
                              child: Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Text(
                                  "# tags",
                                  style: TextStyle(
                                      fontSize: 16, color: Colors.blue),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
