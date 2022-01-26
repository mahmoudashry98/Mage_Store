import 'package:e_commerce_app/layout/home_layout.dart';
import 'package:e_commerce_app/layout/home_layout.dart';
import 'package:e_commerce_app/layout/home_layout.dart';
import 'package:e_commerce_app/screens/forgot_password/forgot_password_screen.dart';
import 'package:e_commerce_app/screens/on_boarding/boarding_screen.dart';
import 'package:e_commerce_app/screens/sign_in/login_success_screen.dart';
import 'package:e_commerce_app/screens/sign_in/sign_in_screen.dart';
import 'package:e_commerce_app/screens/sign_up/sign_up_screen.dart';
import 'package:flutter/material.dart';

//  We use name route
//  All our routes will be available here
late final Map<String, WidgetBuilder> routes ={
  HomeLayout.routeName: (context) => HomeLayout(),
  OnBoardingScreen.routeName: (context) => OnBoardingScreen(),
  SignInScreen.routeName: (context) => SignInScreen(),
  ForgotPasswordScreen.routeName: (context) => ForgotPasswordScreen(),
  LoginSuccessScreen.routeName: (context) => LoginSuccessScreen(),
  SignUpScreen.routeName: (context) => SignUpScreen(),

};