import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weki/layout/cubit/cubit.dart';
import 'package:weki/layout/cubit/states.dart';
import 'package:weki/models/user/user_model.dart';
import 'package:weki/shared/styles/icon_broken.dart';

class ChatDetailsScreen extends StatelessWidget {
  UserModel? userModel;

  ChatDetailsScreen(this.userModel);

  var messageController = TextEditingController();
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = AppCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            titleSpacing: 5,
            leading: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(IconBroken.Arrow___Left_2)),
            title: Row(
              children: [
                CircleAvatar(
                  radius: 20,
                  backgroundImage: NetworkImage("${userModel!.image}"),
                ),
                SizedBox(
                  width: 15,
                ),
                Text(
                  "${userModel!.name}",
                  style: Theme.of(context).textTheme.bodyText1,
                ),
              ],
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Form(
              key: formKey,
              child: Column(
                children: [
                  messageReceived(context),
                  messageSent(context),
                  Spacer(),
                  Container(
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    decoration: BoxDecoration(
                        border: Border.all(width: 1, color: Colors.grey[300]!),
                        borderRadius: BorderRadius.circular(20)),
                    padding: EdgeInsetsDirectional.only(start: 10),
                    child: Row(
                      children: [
                        Expanded(
                            child: TextFormField(
                          controller: messageController,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: "Write your message here...",
                          ),
                          autocorrect: true,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "This field can't be null";
                            }
                            return null;
                          },
                        )),
                        IconButton(
                          onPressed: () {
                            if (formKey.currentState!.validate()) {
                              cubit.sendMessage(
                                  receiverId: userModel!.uId,
                                  messageText: messageController.text,
                                  messageDate: DateTime.now().toString());
                              messageController.clear();
                            }
                          },
                          icon: Icon(
                            IconBroken.Send,
                            color: Colors.blue,
                          ),
                        ),
                        // MaterialButton(
                        //   height: 50,
                        //   minWidth: 1,
                        //   color: Colors.blue,
                        //   onPressed: () {
                        //
                        //   },
                        //   child: Icon(
                        //     IconBroken.Send,
                        //     size: 16,
                        //     color: Colors.white,
                        //   ),
                        // )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget messageReceived(context) => Align(
        alignment: AlignmentDirectional.centerStart,
        child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadiusDirectional.only(
                  bottomEnd: Radius.circular(10),
                  bottomStart: Radius.circular(10),
                  topEnd: Radius.circular(10)),
              color: Colors.grey[600],
            ),
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
            child: Text(
              "hello world",
              style: Theme.of(context)
                  .textTheme
                  .bodyText1!
                  .copyWith(fontSize: 16, color: Colors.white),
            )),
      );

  Widget messageSent(context) => Align(
        alignment: AlignmentDirectional.centerEnd,
        child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadiusDirectional.only(
                  bottomStart: Radius.circular(10),
                  topEnd: Radius.circular(10),
                  topStart: Radius.circular(10)),
              color: Colors.green[500],
            ),
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
            child: Text(
              "hello world",
              style: Theme.of(context)
                  .textTheme
                  .bodyText1!
                  .copyWith(fontSize: 16, color: Colors.white),
            )),
      );
}
