import 'package:e_commerce_app/screens/sign_in/sign_in_screen.dart';
import 'package:e_commerce_app/shared/components/components.dart';
import 'package:e_commerce_app/shared/components/constants.dart';
import 'package:e_commerce_app/shared/network/local/cache_helper.dart';
import 'package:e_commerce_app/shared/size/size_config.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class BoardingModel {
  final String title;
  final String image;

  BoardingModel({
    required this.title,
    required this.image,
  });
}

// ignore: must_be_immutable
class OnBoardingScreen extends StatefulWidget {
  static String routeName = "/boarding";
  @override
  _OnBoardingScreenState createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  List<BoardingModel> boarding = [
    BoardingModel(
      title: "Welcome to MEGA STORE, Let's shop",
      image: "assets/images/splash_1.png",
    ),
    BoardingModel(
      title: "We help people contact with store \naround Egypt",
      image: "assets/images/splash_2.png",
    ),
    BoardingModel(
      title: "We show the easy way to shop. \nJust stay at home with us",
      image: "assets/images/splash_3.png",
    ),
  ];
  var currentPage = 0;
  bool isLast = false;
  void submit() {
    CacheHelper.saveData(
      key: 'onBoarding',
      value: true,
    ).then((value) {
      if (value) {
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => SignInScreen()));
      }
    });
  }
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    var boardingController = PageController();
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: SizedBox(
          width: double.infinity,
          child: Column(
            children: [
              Expanded(
                flex: 3,
                child: PageView.builder(
                  controller: boardingController,
                  onPageChanged: (int index) {
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
                  itemCount: boarding.length,
                  itemBuilder: (context, index) => buildOnBoarding(
                    boarding[index],
                  ),
                ),
              ),
              Expanded(
                flex: 2,
                child: Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: getProportionateScreenWidth(20)),
                  child: Column(
                    children: [
                      Spacer(),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SmoothPageIndicator(
                              controller: boardingController,
                              count: boarding.length,
                              effect: ExpandingDotsEffect(
                                dotColor: Colors.grey,
                                activeDotColor: kPrimaryColor,
                                dotHeight: 6,
                                expansionFactor: 4,
                                dotWidth: 10,
                                spacing: 5.0,
                              ),
                            ),
                          ]),
                      Spacer(
                        flex: 3,
                      ),
                      SizedBox(
                          width: double.infinity,
                          height: getProportionateScreenHeight(56),
                          child: defaultFloatButton(
                            text: "Continue",
                            function: () {
                              submit();
                            },
                            // context: context,
                          )),
                      Spacer(),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Widget buildOnBoarding(BoardingModel model) => Column(
  children: [
    Spacer(),
    Text(
      'MEGA STORE',
      style: TextStyle(
        fontSize: getProportionateScreenWidth(36),
        color: kPrimaryColor,
        fontWeight: FontWeight.bold,
      ),
    ),
    Text(
      '${model.title}',
      textAlign: TextAlign.center,
    ),
    Spacer(),
    Image(
      image: AssetImage('${model.image}'),
      height: getProportionateScreenHeight(265),
      width: getProportionateScreenWidth(235),
    ),
  ],
);