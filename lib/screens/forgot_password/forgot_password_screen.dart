import 'package:e_commerce_app/shared/components/components.dart';
import 'package:e_commerce_app/shared/components/constants.dart';
import 'package:e_commerce_app/shared/size/size_config.dart';
import 'package:flutter/material.dart';

class ForgotPasswordScreen extends StatelessWidget {
  static String routeName = "/forgot_password";

  @override
  Widget build(BuildContext context) {
    var forgotPasswordController = TextEditingController();
    final _formKey = GlobalKey<FormState>();
    return Scaffold(
      appBar: AppBar(
        title: Padding(
          padding: const EdgeInsets.only(left: 70),
          child: Text(
            'Forgot Password',
            style: TextStyle(
              color: kTextColor,
              fontSize: 18,
            ),
          ),
        ),
      ),
      body: SafeArea(
        child: SizedBox(
          width: double.infinity,
          child: Padding(
            padding: EdgeInsets.symmetric(
                horizontal: getProportionateScreenWidth(20)),
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
                child: Column(
                    children: [
                  SizedBox(
                    height: SizeConfig.screenHeight * 0.04,
                  ),
                  Text(
                    'Forgot Password',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: getProportionateScreenWidth(28),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    'Please enter your email and we will send \nyou a link to return to your account',
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(
                    height: SizeConfig.screenHeight *0.1 ,
                  ),
                  SizedBox(
                    height: getProportionateScreenHeight(30.0),
                  ),
                  Form(
                    key: _formKey,
                    child: Column(children: [
                      defaultTextForm(
                        validate: (String? value) {
                          if (value!.isEmpty) {
                            return 'please enter your email address';
                          }
                        },

                        //هعملها و انا بعمل cubit ////////////////////////////

                        onSubmit: (value){
                          if(_formKey.currentState!.validate()){
                            _formKey.currentState!.save();
                          }
                        },
                        hintText: "Enter your email",
                        labelText: "Email",
                        suffix: Icons.email_outlined,
                        keyboardType: TextInputType.emailAddress,
                        controller: forgotPasswordController,
                      ),
                      SizedBox(
                        height: SizeConfig.screenHeight *0.1 ,
                      ),
                      SizedBox(
                        width: double.infinity,
                        height: getProportionateScreenHeight(56),
                        child: defaultFloatButton(
                          text: "Continue",
                          function: () {},
                        ),
                      ),
                      SizedBox(
                        height: SizeConfig.screenHeight *0.1 ,
                      ),
                      SizedBox(
                        height: getProportionateScreenHeight(20),
                      ),
                    ]),
                  ),

                ]),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
