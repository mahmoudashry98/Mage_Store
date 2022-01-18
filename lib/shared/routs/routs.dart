import 'package:e_commerce_app/screens/forgot_password/forgot_password.dart';
import 'package:e_commerce_app/screens/sign_in/login_success_screen.dart';
import 'package:e_commerce_app/screens/sign_in/sign_in_screen.dart';
import 'package:e_commerce_app/screens/splash/splash_screen.dart';
import 'package:flutter/material.dart';

//  We use name route
//  All our routes will be available here
late final Map<String, WidgetBuilder> routes ={
  SplashScreen.routeName: (context) => SplashScreen(),
  SignInScreen.routeName: (context) => SignInScreen(),
  ForgotPasswordScreen.routeName: (context) => ForgotPasswordScreen(),
  LoginSuccessScreen.routeName: (context) => LoginSuccessScreen(),

};