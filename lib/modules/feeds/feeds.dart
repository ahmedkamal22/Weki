import 'package:flutter/material.dart';
import 'package:weki/shared/styles/colors.dart';
import 'package:weki/shared/styles/icon_broken.dart';

class FeedsScreen extends StatelessWidget {
  const FeedsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
                      "https://img.freepik.com/free-photo/young-business-woman-working-laptop-office_1303-22815.jpg?w=740&t=st=1661974951~exp=1661975551~hmac=ceb3f30e835a8c359daa5b08ab1ad2bfb61c476a0a5801ee7ff26b0c42cd87c7"),
                  width: double.infinity,
                  height: 220,
                  fit: BoxFit.cover,
                ),
                Padding(
                  padding:
                      const EdgeInsetsDirectional.only(bottom: 10, end: 10),
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
              itemBuilder: (context, index) => buildPostsItem(context),
              separatorBuilder: (context, index) => SizedBox(
                    height: 10,
                  ),
              itemCount: 10),
        ],
      ),
    );
  }

  Widget buildPostsItem(context) => Card(
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
                    backgroundImage: NetworkImage(
                        "https://img.freepik.com/free-photo/young-woman-student-with-laptop-office_1303-20533.jpg?w=740&t=st=1661975505~exp=1661976105~hmac=8b1aa4b8402d7b3229fdd07fb9b2b3182d1bbc93b87e0d51a2046ce6c5ce418c"),
                  ),
                  SizedBox(
                    width: 15,
                  ),
                  Column(
                    children: [
                      Row(
                        children: [
                          Text(
                            "Ahmed Kamal",
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
                        "January 21,2022 at 11:00 pm",
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
                "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book.",
                style: Theme.of(context)
                    .textTheme
                    .bodyText1!
                    .copyWith(fontSize: 17, height: 1.1),
              ),
            ),
            Container(
              width: double.infinity,
              padding: EdgeInsetsDirectional.only(top: 10, bottom: 15),
              child: Wrap(
                children: [
                  Container(
                    height: 20,
                    child: MaterialButton(
                      minWidth: 1,
                      padding: EdgeInsets.all(0),
                      onPressed: () {},
                      child: Text(
                        "#Softwore",
                        style: TextStyle(
                          color: defaultColor,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Container(
                    height: 20,
                    child: MaterialButton(
                      padding: EdgeInsets.all(0),
                      minWidth: 1,
                      onPressed: () {},
                      child: Text(
                        "#Softwore_Development_Flutter",
                        style: TextStyle(
                          color: defaultColor,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              width: double.infinity,
              height: 170,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8.0),
                image: DecorationImage(
                  image: NetworkImage(
                      "https://img.freepik.com/free-photo/young-business-woman-working-laptop-office_1303-22815.jpg?w=740&t=st=1661974951~exp=1661975551~hmac=ceb3f30e835a8c359daa5b08ab1ad2bfb61c476a0a5801ee7ff26b0c42cd87c7"),
                  fit: BoxFit.cover,
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
                        Text("120")
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: InkWell(
                    onTap: () {},
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
                        Text("120 comments")
                      ],
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
              child: Row(
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 20,
                        backgroundImage: NetworkImage(
                            "https://img.freepik.com/free-photo/young-woman-student-with-laptop-office_1303-20533.jpg?w=740&t=st=1661975505~exp=1661976105~hmac=8b1aa4b8402d7b3229fdd07fb9b2b3182d1bbc93b87e0d51a2046ce6c5ce418c"),
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
          ],
        ),
      );
}
