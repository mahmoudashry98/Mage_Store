import 'package:e_commerce_app/shared/components/components.dart';
import 'package:e_commerce_app/shared/components/constants.dart';
import 'package:e_commerce_app/shared/size/size_config.dart';
import 'package:flutter/material.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        child: SizedBox(
          width: getProportionateScreenWidth(200),
          height: getProportionateScreenHeight(46),
          child: defaultFloatButton(
            text: "Log out",
            function: () {
              signOut(context);
            },
          ),
        ),
      ),
    );
  }
}
