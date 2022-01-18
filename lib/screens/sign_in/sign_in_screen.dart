import 'package:e_commerce_app/screens/forgot_password/forgot_password.dart';
import 'package:e_commerce_app/shared/components/components.dart';
import 'package:e_commerce_app/shared/components/constants.dart';
import 'package:e_commerce_app/shared/size/size_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'login_success_screen.dart';

class SignInScreen extends StatelessWidget {
  static String routeName = "/sign_in";
  const SignInScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    return Scaffold(
      appBar: AppBar(
        title: Padding(
          padding: const EdgeInsets.only(left: 105),
          child: Text(
            'Sign In',
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
              child: Column(
                children: [
                  SizedBox(
                    height: SizeConfig.screenHeight *0.04,

                  ),
                  Text(
                    'Welcome Back',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: getProportionateScreenWidth(28),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    'Sign in with your email and password  \n or continue with social media',
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(
                    height: SizeConfig.screenHeight * 0.08,
                  ),
                  Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        defaultTextForm(
                          validate: (String? value) {
                            if (value!.isEmpty) {
                              return 'please enter your email address';
                            }
                          },

                          //هعملها و انا بعمل cubit ////////////////////////////

                          // onSubmit: (value){
                          //   if(_formKey.currentState!.validate()){
                          //     _formKey.currentState!.save();
                          //   }
                          // },
                          hintText: "Enter your email",
                          labelText: "Email",
                          suffixIcon: Icons.email_outlined,
                          keyboardType: TextInputType.emailAddress,
                        ),
                        SizedBox(
                          height: getProportionateScreenHeight(20),
                        ),
                        defaultTextForm(
                            onSubmit: (value) {
                              if (_formKey.currentState!.validate()) {
                                //هعملها و انا بعمل cubit ////////////////////////////

                                // SocialLoginCubit.get(context).userLogin(
                                //   email: emailController.text,
                                //   password: passwordController.text,
                                // );
                              }
                            },
                            validate: (String? value) {
                              if (value!.isEmpty) {
                                return 'password is too short';
                              }
                            },
                            hintText: "Enter Password",
                            labelText: "Password",
                            suffixIcon: Icons.lock_outline_rounded,
                            keyboardType: TextInputType.text,
                            obscureText: true),
                        SizedBox(
                          height: SizeConfig.screenHeight *0.08,

                        ),
                        Row(
                          children: [
                            Checkbox(
                              activeColor: kPrimaryColor,
                              //هعملها و انا بعمل cubit ////////////////////////////
                              value: false,
                              onChanged: (value) {},
                            ),
                            Text('Remember me'),
                            Spacer(),
                            GestureDetector(
                              onTap: (){
                                Navigator.pushNamed(context, ForgotPasswordScreen.routeName);
                              },
                              child: Text(
                                'Forgot Password',
                                style: TextStyle(
                                    decoration: TextDecoration.underline),
                              ),
                            )
                          ],
                        ),
                        SizedBox(
                          height: getProportionateScreenHeight(20),
                        ),
                        SizedBox(
                          width: double.infinity,
                          height: getProportionateScreenHeight(56),
                          child: defaultFloatButton(
                            text: "Continue",
                            function: () {
                              Navigator.pushNamed(context, LoginSuccessScreen.routeName);
                            },
                          ),
                        ),
                        SizedBox(
                          height: SizeConfig.screenHeight * 0.08,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              margin: EdgeInsets.symmetric(
                                  horizontal: getProportionateScreenWidth(10)),
                              padding: EdgeInsets.all(
                                  getProportionateScreenHeight(12)),
                              height: getProportionateScreenHeight(40),
                              width: getProportionateScreenWidth(40),
                              decoration: BoxDecoration(
                                color: Color(0xFFF5F6F9),
                                shape: BoxShape.circle,
                              ),
                              child: SvgPicture.asset(
                                  'assets/icons/facebook-2.svg'),
                            ),
                            Container(
                              margin: EdgeInsets.symmetric(
                                  horizontal: getProportionateScreenWidth(10)),
                              padding: EdgeInsets.all(
                                  getProportionateScreenHeight(12)),
                              height: getProportionateScreenHeight(40),
                              width: getProportionateScreenWidth(40),
                              decoration: BoxDecoration(
                                color: Color(0xFFF5F6F9),
                                shape: BoxShape.circle,
                              ),
                              child: SvgPicture.asset(
                                  'assets/icons/google-icon.svg'),
                            ),
                            Container(
                              margin: EdgeInsets.symmetric(
                                  horizontal: getProportionateScreenWidth(10)),
                              padding: EdgeInsets.all(
                                  getProportionateScreenHeight(12)),
                              height: getProportionateScreenHeight(40),
                              width: getProportionateScreenWidth(40),
                              decoration: BoxDecoration(
                                color: Color(0xFFF5F6F9),
                                shape: BoxShape.circle,
                              ),
                              child:
                                  SvgPicture.asset('assets/icons/twitter.svg'),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: getProportionateScreenHeight(20),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Don't have an account?",
                              style: TextStyle(
                                fontSize: getProportionateScreenWidth(16),
                              ),
                            ),
                            Text(
                              "Sign Up",
                              style: TextStyle(
                                fontSize: getProportionateScreenWidth(16),
                                color: kPrimaryColor,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
