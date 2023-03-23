import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../../shared/components/components.dart';
import '../../../shared/network/local/cache_helper.dart';
import '../../../shared/styles/colors.dart';
import '../login/shop_login_screen.dart';

class BordingModel
{
  final String image;
  final String title;
  final String body;

  BordingModel({
    required this.image,
    required this.title,
    required this.body,
});
}

class OnBoardingScreen extends StatefulWidget
{

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen>
{
  var boardController = PageController();

  List<BordingModel> boarding =
  [
    BordingModel(
      image: 'assets/images/OnBoarding1.jpg',
      title: 'On Board 1 Title',
      body: 'On Board 1 Body',
    ),
    BordingModel(
      image: 'assets/images/OnBoarding2.jpg',
      title: 'On Board 2 Title',
      body: 'On Board 2 Body',
    ),
    BordingModel(
      image: 'assets/images/OnBoarding3.jpg',
      title: 'On Board 3 Title',
      body: 'On Board 3 Body',
    ),
  ];

  bool isLast = false;

  void submit()
  {
    CacheHelper.saveData(
      key: "onBoarding",
      value: true,
    ).then((value)
    {
      if(value) {
        navigateAndFinish(
          context,
          ShopLoginScreen(),
        );
      }
    });

  }

  @override
  Widget build(BuildContext context)
  {
    return Scaffold(
      appBar: AppBar(
        actions: [
          defaultTextButton(
            function: submit,
          text: 'Skip',
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                physics: BouncingScrollPhysics(),
                controller: boardController,
                onPageChanged: (int index)
                {
                  if(index == boarding.length-1)
                  {
                    setState(() {
                      isLast = true;
                    });
                    // print('last');
                  }else
                    {
                      setState(() {
                        isLast = false;
                      });
                      // print('not last');
                    }
                },
                itemBuilder: (context , index) => buildBoardingItem(boarding[index]),
                itemCount: boarding.length,
              ),
            ),
            SizedBox(
              height: 40.0,
            ),
            Row(
              children: [
                SmoothPageIndicator(
                    controller: boardController,
                    effect: ExpandingDotsEffect(
                      dotColor: Colors.grey,
                      activeDotColor: defaultColor,
                      dotHeight: 10,
                      expansionFactor: 4,
                      dotWidth: 10,
                      spacing: 5.0,
                    ),
                    count: boarding.length,
                ),
                Spacer(),
                FloatingActionButton(
                  onPressed: ()
                  {

                    if(isLast)
                    {
                      submit();
                    } else
                      {
                        boardController.nextPage(
                          duration: Duration(
                            milliseconds: 750,
                          ),
                          curve: Curves.fastLinearToSlowEaseIn,);
                      }
                  },
                  child: Icon(
                    Icons.arrow_forward_ios,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget  buildBoardingItem(BordingModel model) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Expanded(
        child: Image(
          image: AssetImage('${model.image}'),
        ),
      ),
      // SizedBox(
      //   height: 30.0,
      // ),
      Text(
        '${model.title}',
        style: TextStyle(
          fontSize: 24.0,
          fontWeight: FontWeight.bold,
        ),
      ),
      SizedBox(
        height: 15.0,
      ),
      Text(
        '${model.body}',
        style: TextStyle(
          fontSize: 14.0,
          fontWeight: FontWeight.bold,
        ),
      ),
      SizedBox(
        height: 30.0,
      ),
    ],
  );
}
