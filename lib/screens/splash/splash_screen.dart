import 'package:e_commerce_app/layout/cubit/cubit.dart';
import 'package:e_commerce_app/screens/sign_in/sign_in_screen.dart';
import 'package:e_commerce_app/shared/components/components.dart';
import 'package:e_commerce_app/shared/components/constants.dart';
import 'package:e_commerce_app/shared/size/size_config.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

// ignore: must_be_immutable
class SplashScreen extends StatefulWidget {
  static String routeName = "/splash";
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  var currentPage = 0;
  bool isLast = false;
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    var boardingController = PageController();
    var splashData = AppCubit.get(context).splashData;

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
                    if (index == splashData.length - 1) {
                      setState(() {
                        isLast = true;
                      });
                    } else {
                      setState(() {
                        isLast = false;
                      });
                    }
                  },
                  itemCount: splashData.length,
                  itemBuilder: (context, index) => SplashContent(
                    image: splashData[index]["image"]!,
                    text: splashData[index]["text"]!,
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
                              count: splashData.length,
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
                      Spacer(flex: 3,),
                      SizedBox(
                        width: double.infinity,
                        height: getProportionateScreenHeight(56),
                        child:defaultFloatButton(
                          text: "Continue",
                          function:(){
                            Navigator.pushNamed(context, SignInScreen.routeName);
                          } ,
                          context: context,
                        )
                      ),
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

class SplashContent extends StatelessWidget {
  const SplashContent({
    Key? key,
    required this.text,
    required this.image,
  }) : super(key: key);
  final String text, image;

  @override
  Widget build(BuildContext context) {
    return Column(
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
          text,
          textAlign: TextAlign.center,
        ),
        Spacer(),
        Image.asset(
          image,
          height: getProportionateScreenHeight(265),
          width: getProportionateScreenWidth(235),
        ),
      ],
    );
  }
}
