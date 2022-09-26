import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weki/layout/cubit/cubit.dart';
import 'package:weki/layout/cubit/states.dart';
import 'package:weki/models/comment/comment.dart';
import 'package:weki/shared/components/components.dart';
import 'package:weki/shared/styles/icon_broken.dart';

class CommentScreen extends StatelessWidget {
  String? commentId;

  CommentScreen(this.commentId);

  var commentController = TextEditingController();
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      AppCubit.get(context).getCommentPosts(postId: commentId!);
      return BlocConsumer<AppCubit, AppStates>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit = AppCubit.get(context);
          return Scaffold(
            appBar: defaultAppBar(context: context, title: "Comments"),
            body: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Form(
                key: formKey,
                child: Column(
                  children: [
                    Expanded(
                      child: ConditionalBuilder(
                        condition: cubit.comments.isNotEmpty,
                        builder: (context) => ListView.separated(
                            physics: BouncingScrollPhysics(),
                            shrinkWrap: true,
                            itemBuilder: (context, index) => buildCommentItem(
                                context, cubit.comments[index]),
                            separatorBuilder: (context, index) => SizedBox(
                                  height: 15,
                                ),
                            itemCount: cubit.comments.length),
                        fallback: (context) => testScreen(
                            text: "There isn't any comment yet...",
                            style: Theme.of(context).textTheme.bodyText1),
                      ),
                    ),
                    writeComment(context),
                  ],
                ),
              ),
            ),
          );
        },
      );
    });
  }

  Widget buildCommentItem(context, CommentModel model) => Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            radius: 25,
            backgroundImage: NetworkImage("${model.image}"),
          ),
          SizedBox(
            width: 10,
          ),
          Expanded(
            child: Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(15)),
              child: Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${model.name}",
                      style: Theme.of(context).textTheme.bodyText1,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      "${model.commentText}",
                      // maxLines: 9,
                      // overflow: TextOverflow.ellipsis,
                      style: Theme.of(context)
                          .textTheme
                          .bodyText1!
                          .copyWith(fontSize: 18, height: 1.0),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      );

  Widget writeComment(context) => Row(
        children: [
          Expanded(
            child: defaultFormField(
                controller: commentController,
                keyboardType: TextInputType.text,
                hint: "Write a comment...",
                prefix: IconBroken.Document,
                validate: (value) {
                  if (value!.isEmpty) {
                    return "This field can't be null";
                  }
                  return null;
                },
                generalWidgetsColor: Colors.black.withOpacity(.6),
                style: TextStyle(color: Colors.black.withOpacity(.6)),
                radius: 20),
          ),
          IconButton(
              highlightColor: Theme.of(context).scaffoldBackgroundColor,
              onPressed: () {
                if (formKey.currentState!.validate()) {
                  AppCubit.get(context).commentPost(
                      commentId: commentId!,
                      commentText: commentController.text,
                      commentDate: DateTime.now().toString());
                  commentController.clear();
                }
              },
              icon: Icon(
                IconBroken.Send,
                color: Colors.blue,
              )),
        ],
      );
}
