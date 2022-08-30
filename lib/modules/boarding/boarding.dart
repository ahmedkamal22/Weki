import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:weki/models/boarding/boarding.dart';
import 'package:weki/modules/home/cubit/cubit.dart';
import 'package:weki/modules/login/login.dart';
import 'package:weki/shared/components/components.dart';
import 'package:weki/shared/network/local/cache_helper.dart';
import 'package:weki/shared/styles/colors.dart';

class BoardingScreen extends StatefulWidget {
  BoardingScreen({Key? key}) : super(key: key);

  @override
  State<BoardingScreen> createState() => _BoardingScreenState();
}

class _BoardingScreenState extends State<BoardingScreen> {
  var pageController = PageController();

  List<BoardingModel> boarding = [
    BoardingModel(
      image:
          "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSuiFv-jcFkoGuddnGuXAr_-8YVOrUliXyWsG65b_VNWQ&s",
      title: "Title 1",
    ),
    BoardingModel(
      image:
          "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSuiFv-jcFkoGuddnGuXAr_-8YVOrUliXyWsG65b_VNWQ&s",
      title: "Title 2",
    ),
    BoardingModel(
      image:
          "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSuiFv-jcFkoGuddnGuXAr_-8YVOrUliXyWsG65b_VNWQ&s",
      title: "Title 3",
    ),
  ];
  bool isLast = false;

  submit() {
    CacheHelper.saveData(key: "boarding", value: true).then((value) {
      if (value) {
        navigateAndFinish(context: context, widget: LoginScreen());
      }
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          defaultTextButton(
            onPressed: () {
              submit();
            },
            text: "skip",
            isUpper: true,
            style: Theme.of(context)
                .textTheme
                .bodyText1!
                .copyWith(color: defaultColor, fontSize: 17),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                physics: BouncingScrollPhysics(),
                controller: pageController,
                onPageChanged: (index) {
                  if (index == boarding.length - 1) {
                    setState(() {
                      isLast = true;
                    });
                  } else {
                    setState(() {
                      isLast = false;
                    });
                  }
                },
                itemBuilder: (context, index) =>
                    buildBoardingItem(context, boarding[index]),
                itemCount: boarding.length,
              ),
            ),
            SizedBox(
              height: 50,
            ),
            Row(
              children: [
                SmoothPageIndicator(
                  controller: pageController,
                  count: boarding.length,
                  effect: SlideEffect(
                      spacing: 8.0,
                      radius: 8.0,
                      dotWidth: 40.0,
                      dotHeight: 16.0,
                      paintStyle: PaintingStyle.stroke,
                      strokeWidth: 1.5,
                      dotColor: Colors.grey,
                      activeDotColor: defaultColor),
                ),
                Spacer(),
                FloatingActionButton(
                  onPressed: () {
                    if (isLast == true) {
                      submit();
                    } else {
                      pageController.nextPage(
                          duration: Duration(milliseconds: 700),
                          curve: Curves.fastLinearToSlowEaseIn);
                    }
                  },
                  child: Icon(Icons.arrow_forward_ios_outlined),
                  mini: true,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget buildBoardingItem(context, BoardingModel model) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Image(
              image: NetworkImage("${model.image}"),
              width: double.infinity,
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Text(
            "${model.title}",
            style: Theme.of(context).textTheme.bodyText1!.copyWith(
                  color: AppCubit.get(context).isDark
                      ? Colors.white
                      : Colors.black,
                ),
          ),
        ],
      );
}
