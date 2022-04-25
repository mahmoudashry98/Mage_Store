import 'package:e_commerce_app/layout/cubit/cubit.dart';
import 'package:e_commerce_app/screens/sign_in/sign_in_screen.dart';
import 'package:e_commerce_app/shared/components/components.dart';
import 'package:e_commerce_app/shared/network/local/cache_helper.dart';
import 'package:e_commerce_app/shared/size/size_config.dart';
import 'package:flutter/material.dart';

const kPrimaryColor = Color(0xFFFF7643);
const kPrimaryLightColor = Color(0xFFFFECDF);
const kPrimaryGradientColor = LinearGradient(
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
  colors: [Color(0xFFFFA53E), Color(0xFFFF7643)],
);
const kSecondaryColor = Color(0xFF979797);
const kTextColor = Color(0xFF757575);

const kAnimationDuration = Duration(milliseconds: 200);

final headingStyle = TextStyle(
  fontSize: getProportionateScreenWidth(28),
  fontWeight: FontWeight.bold,
  color: Colors.black,
  height: 1.5,
);

String ?token = '';

void printFullText(String text) {
  final pattern = RegExp('.{1,800}'); // 800 is the size of each chunk
  pattern.allMatches(text).forEach((match) => print(match.group(0)));
}

void signOut(context) {
  CacheHelper.removeData(key: 'token');
  print(token);
  // token = null;
  var model = AppCubit.get(context).userModel;

  model!.data!.name='';
  model.data!.email='';
  model.data!.phone='';
  navigateAndFinish(context, SignInScreen(),);
  AppCubit
      .get(context)
      .currentIndex = 0;
}

const kTileHeight = 50.0;
const inProgressColor = Colors.black87;
const todoColor = Color(0xffd1d2d7);

enum Pages {
  DeliveryTime,
  AddAddress,
  Summary,
}

const TextStyle textStyle =
TextStyle(fontSize: 17, fontWeight: FontWeight.w500);


// var index = 0;
// var addressModel = AppCubit.get(context).getAddressModel!.data!.data![index];
