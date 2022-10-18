import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weki/layout/cubit/cubit.dart';
import 'package:weki/layout/cubit/states.dart';
import 'package:weki/shared/components/components.dart';

class SearchScreen extends StatelessWidget {
  SearchScreen({Key? key}) : super(key: key);
  var searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = AppCubit.get(context);
        return Scaffold(
          appBar: defaultAppBar(context: context, title: "Search"),
          body: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                if (state is AppSearchLoadingState)
                  Column(
                    children: [
                      LinearProgressIndicator(
                        backgroundColor:
                            Theme.of(context).scaffoldBackgroundColor,
                      ),
                      SizedBox(
                        height: 20,
                      ),
                    ],
                  ),
                defaultFormField(
                  controller: searchController,
                  keyboardType: TextInputType.text,
                  label: "Search",
                  prefix: Icons.search,
                  validate: (value) {
                    if (value!.isEmpty) {
                      return "Type your desired word to be searched";
                    }
                    return null;
                  },
                  generalWidgetsColor:
                      cubit.isDark ? Colors.white : Colors.black,
                  radius: 20.0,
                  style: TextStyle(
                    color: cubit.isDark ? Colors.white : Colors.black,
                  ),
                  onChanged: (text) {
                    cubit.search();
                  },
                ),
                SizedBox(
                  height: 10,
                ),
                if (state is AppSearchSuccessState)
                  Expanded(
                    child: ListView.separated(
                      physics: BouncingScrollPhysics(),
                      itemBuilder: (context, index) =>
                          buildChatItem(context, cubit.users[index]),
                      separatorBuilder: (context, index) => lineDivider(),
                      itemCount: cubit.users.length,
                    ),
                  ),
                if (state is AppSearchFailureState)
                  Expanded(
                    child: testScreen(
                        text: "Not Found!!!!!",
                        style: Theme.of(context).textTheme.bodyText1!.copyWith(
                            color: cubit.isDark ? Colors.white : Colors.black)),
                  ),
              ],
            ),
          ),
        );
      },
    );
  }
}
