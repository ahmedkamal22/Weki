import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weki/layout/cubit/cubit.dart';
import 'package:weki/layout/cubit/states.dart';
import 'package:weki/models/user/user_model.dart';
import 'package:weki/modules/chats/chat_details.dart';
import 'package:weki/shared/components/components.dart';

class ChatsScreen extends StatelessWidget {
  const ChatsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = AppCubit.get(context);
        return ConditionalBuilder(
          condition: cubit.users.isNotEmpty,
          builder: (context) => ListView.separated(
              itemBuilder: (context, index) =>
                  buildChatItem(context, cubit.users[index]),
              separatorBuilder: (context, index) => lineDivider(),
              itemCount: cubit.users.length),
          fallback: (context) => Center(child: CircularProgressIndicator()),
        );
      },
    );
  }

  Widget buildChatItem(context, UserModel user) => InkWell(
        onTap: () {
          navigateTo(context: context, widget: ChatDetailsScreen(user));
        },
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Row(
            children: [
              CircleAvatar(
                radius: 25,
                backgroundImage: NetworkImage("${user.image}"),
              ),
              SizedBox(
                width: 15,
              ),
              Text(
                "${user.name}",
                style: Theme.of(context).textTheme.bodyText1,
              ),
            ],
          ),
        ),
      );
}
