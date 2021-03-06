import 'package:e_commerce_app/layout/cubit/cubit.dart';
import 'package:e_commerce_app/layout/home_layout.dart';
import 'package:e_commerce_app/screens/sign_in/cubit/cubit.dart';
import 'package:e_commerce_app/screens/sign_in/cubit/states.dart';
import 'package:e_commerce_app/shared/components/components.dart';
import 'package:e_commerce_app/shared/components/constants.dart';
import 'package:e_commerce_app/shared/network/local/cache_helper.dart';
import 'package:e_commerce_app/shared/size/size_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginSuccessScreen extends StatelessWidget {
  static String routeName = "/login_success";

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginCubit(),
      child: BlocConsumer<LoginCubit, LoginStates>(
        listener: (context, state) {

        },
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              title: Padding(
                padding: const EdgeInsets.only(left: 120),
                child: Text(
                  'Login Success',
                  style: TextStyle(
                    color: kTextColor,
                  ),
                ),
              ),
            ),
            body: Column(
              children: [
                SizedBox(height: SizeConfig.screenHeight * 0.04,),
                Image.asset(
                  'assets/images/success.png',
                  height: SizeConfig.screenHeight * 0.4,
                ),
                SizedBox(height: SizeConfig.screenHeight * 0.08,),
                Text(
                  'Login Success',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: getProportionateScreenWidth(30.0),
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: SizeConfig.screenHeight * 0.1,
                ),
                SizedBox(
                  width: SizeConfig.screenWidth * 0.6,
                  height: getProportionateScreenHeight(56),
                  child: defaultFloatButton(
                    text: "Back to home",
                    function: () {
                      CacheHelper.getData(key: 'token');
                      Navigator.pushReplacementNamed(context, HomeLayout.routeName);
                      AppCubit.get(context).getOrders();
                    },
                  ),
                ),
                SizedBox(
                  height: SizeConfig.screenHeight * 0.1,
                ),
                SizedBox(
                  height: getProportionateScreenHeight(20),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
