import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weki/layout/cubit/cubit.dart';
import 'package:weki/layout/cubit/states.dart';
import 'package:weki/models/post/post.dart';
import 'package:weki/shared/styles/colors.dart';
import 'package:weki/shared/styles/icon_broken.dart';

class FeedsScreen extends StatelessWidget {
  const FeedsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = AppCubit.get(context);
        return ConditionalBuilder(
          condition: cubit.posts.isNotEmpty,
          builder: (context) {
            return SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Column(
                children: [
                  Card(
                    elevation: 5.0,
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    margin: EdgeInsetsDirectional.all(8),
                    child: Stack(
                      alignment: AlignmentDirectional.bottomEnd,
                      children: [
                        Image(
                          image: NetworkImage(
                              "https://img.freepik.com/free-photo/excited-happy-young-pretty-woman_171337-2005.jpg?w=740&t=st=1662053221~exp=1662053821~hmac=eae04ec0ca79550c2980c3ae952c870ceeb9b976040865bceb19c68638af4a29"),
                          width: double.infinity,
                          height: 220,
                          fit: BoxFit.cover,
                        ),
                        Padding(
                          padding: const EdgeInsetsDirectional.only(
                              bottom: 10, end: 10),
                          child: Text(
                            "Comminicate with friends",
                            style: Theme.of(context)
                                .textTheme
                                .bodyText1!
                                .copyWith(color: Colors.white, fontSize: 15),
                          ),
                        ),
                      ],
                    ),
                  ),
                  ListView.separated(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) =>
                          buildPostsItem(context, cubit.posts[index]),
                      separatorBuilder: (context, index) => SizedBox(
                            height: 10,
                          ),
                      itemCount: cubit.posts.length),
                ],
              ),
            );
          },
          fallback: (context) => Center(child: CircularProgressIndicator()),
        );
      },
    );
  }

  Widget buildPostsItem(context, PostsModel model) => Card(
        elevation: 5.0,
        clipBehavior: Clip.antiAliasWithSaveLayer,
        margin: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 30,
                    backgroundImage: NetworkImage("${model.image}"),
                  ),
                  SizedBox(
                    width: 15,
                  ),
                  Column(
                    children: [
                      Row(
                        children: [
                          Text(
                            "${model.name}",
                            style: Theme.of(context).textTheme.bodyText1,
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Icon(
                            Icons.check_circle,
                            color: defaultColor,
                            size: 22,
                          ),
                        ],
                      ),
                      Text(
                        "${model.postDate}",
                        style: Theme.of(context)
                            .textTheme
                            .caption!
                            .copyWith(height: 2.2),
                      ),
                    ],
                  ),
                  Spacer(),
                  IconButton(
                    onPressed: () {},
                    icon: Icon(Icons.more_horiz),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Container(
                width: double.infinity,
                height: 1,
                color: Colors.grey[300],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "${model.postText}",
                style: Theme.of(context)
                    .textTheme
                    .bodyText1!
                    .copyWith(fontSize: 17, height: 1.1),
              ),
            ),
            // Container(
            //   width: double.infinity,
            //   padding: EdgeInsetsDirectional.only(top: 10, bottom: 15),
            //   child: Wrap(
            //     children: [
            //       Container(
            //         height: 20,
            //         child: MaterialButton(
            //           minWidth: 1,
            //           padding: EdgeInsets.all(0),
            //           onPressed: () {},
            //           child: Text(
            //             "#Softwore",
            //             style: TextStyle(
            //               color: defaultColor,
            //             ),
            //           ),
            //         ),
            //       ),
            //       SizedBox(
            //         width: 5,
            //       ),
            //       Container(
            //         height: 20,
            //         child: MaterialButton(
            //           padding: EdgeInsets.all(0),
            //           minWidth: 1,
            //           onPressed: () {},
            //           child: Text(
            //             "#Softwore_Development_Flutter",
            //             style: TextStyle(
            //               color: defaultColor,
            //             ),
            //           ),
            //         ),
            //       ),
            //     ],
            //   ),
            // ),
            if (model.postImage != "Without post image..")
              Padding(
                padding:
                    const EdgeInsetsDirectional.only(top: 10, start: 2, end: 2),
                child: Container(
                  width: double.infinity,
                  height: 170,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.0),
                    image: DecorationImage(
                      image: NetworkImage("${model.postImage}"),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            SizedBox(
              height: 10,
            ),
            Row(
              children: [
                Expanded(
                  child: InkWell(
                    onTap: () {},
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Row(
                        children: [
                          Icon(
                            IconBroken.Heart,
                            color: Colors.red,
                            size: 20,
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Text("0")
                        ],
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: InkWell(
                    onTap: () {},
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Icon(
                            IconBroken.Chat,
                            color: Colors.amber,
                            size: 20,
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Text("0 comments")
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsetsDirectional.only(top: 10),
              child: Container(
                width: double.infinity,
                height: 1,
                color: Colors.grey[300],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: InkWell(
                onTap: () {},
                child: Row(
                  children: [
                    Row(
                      children: [
                        CircleAvatar(
                          radius: 20,
                          backgroundImage: NetworkImage(
                              "${AppCubit.get(context).userModel!.image}"),
                        ),
                        SizedBox(
                          width: 15,
                        ),
                        Text(
                          "Write a comment....",
                          style: Theme.of(context)
                              .textTheme
                              .caption!
                              .copyWith(fontSize: 14),
                        ),
                      ],
                    ),
                    Spacer(),
                    InkWell(
                      onTap: () {},
                      child: Row(
                        children: [
                          Icon(
                            IconBroken.Heart,
                            size: 18,
                            color: Colors.red,
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Text("Like"),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      );
}
