import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:e_commerce_app/layout/home_layout.dart';
import 'package:e_commerce_app/screens/forgot_password/forgot_password_screen.dart';
import 'package:e_commerce_app/screens/sign_up/sign_up_screen.dart';
import 'package:e_commerce_app/shared/components/components.dart';
import 'package:e_commerce_app/shared/components/constants.dart';
import 'package:e_commerce_app/shared/network/local/cache_helper.dart';
import 'package:e_commerce_app/shared/size/size_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'cubit/cubit.dart';
import 'cubit/states.dart';

class SignInScreen extends StatelessWidget {
  static String routeName = "/sign_in";
  const SignInScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final _formKey = GlobalKey<FormState>();
    var emailController = TextEditingController();
    var passwordController = TextEditingController();
    return BlocProvider(
      create: (context) => LoginCubit(),
      child: BlocConsumer<LoginCubit, LoginStates>(
        listener: (context, state) {
          if (state is LoginSuccessState) {
            if (state.loginModel.status!) {
              print(state.loginModel.message!);
              print(state.loginModel.data!.token);
              CacheHelper.saveData(key: 'token', value: state.loginModel.data!.token).then((value) {
                Navigator.pushReplacementNamed(context, HomeLayout.routeName);
              });
              showToast(
                text: state.loginModel.message!,
                state: ToastStates.SUCCESS,
              );
            } else if(!state.loginModel.status!){
              print(state.loginModel.message);
              showToast(
                text: state.loginModel.message!,
                state: ToastStates.ERROR,
              );
            }
          }
        },
        builder: (context, state) {
          SizeConfig().init(context);
          return Scaffold(
            appBar: AppBar(
              title: Padding(
                padding: const EdgeInsets.only(left: 160),
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
                          height: SizeConfig.screenHeight * 0.04,
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

                                onSubmit: (value) {
                                  if (_formKey.currentState!.validate()) {
                                    _formKey.currentState!.save();
                                  }
                                },
                                hintText: "Enter your email",
                                labelText: "Email",
                                suffix: Icons.email_outlined,
                                keyboardType: TextInputType.emailAddress,
                                controller: emailController,
                              ),
                              SizedBox(
                                height: getProportionateScreenHeight(20),
                              ),
                              defaultTextForm(
                                onSubmit: (value) {
                                  if (_formKey.currentState!.validate()) {
                                    LoginCubit.get(context).userLogin(
                                      email: emailController.text,
                                      password: passwordController.text,
                                    );
                                  }
                                },
                                isPassword: LoginCubit.get(context).isPassword,
                                suffixPressed: () {
                                  LoginCubit.get(context)
                                      .changePasswordVisibility();
                                },
                                validate: (String? value) {
                                  if (value!.isEmpty) {
                                    return 'password is too short';
                                  }
                                },
                                hintText: "Enter Password",
                                labelText: "Password",
                                suffix: LoginCubit.get(context).suffix,
                                keyboardType: TextInputType.visiblePassword,
                                controller: passwordController,
                              ),
                              SizedBox(
                                height: SizeConfig.screenHeight * 0.08,
                              ),
                              Row(
                                children: [
                                  Checkbox(
                                    activeColor: kPrimaryColor,
                                    value: LoginCubit.get(context).value,
                                    onChanged: (bool? value) {
                                      LoginCubit.get(context).checkbox(value);
                                      print(value);
                                    },
                                  ),
                                  Text('Remember me'),
                                  Spacer(),
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.pushNamed(context,
                                          ForgotPasswordScreen.routeName);
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
                              ConditionalBuilder(
                                condition: state is! LoginLoadingState,
                                builder: (context) => SizedBox(
                                  width: double.infinity,
                                  height: getProportionateScreenHeight(56),
                                  child: defaultFloatButton(
                                    text: "Continue",
                                    function: () {
                                      if (_formKey.currentState!.validate()) {
                                        LoginCubit.get(context).userLogin(
                                          email: emailController.text,
                                          password: passwordController.text,
                                        );
                                      }
                                      //Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>HomeLayout() ));
                                    },
                                  ),
                                ),
                                fallback: (context) => Center(
                                    child: CircularProgressIndicator(
                                  valueColor: AlwaysStoppedAnimation<Color>(
                                      Color(0xFFFF7643)),
                                )),
                              ),
                              SizedBox(
                                height: SizeConfig.screenHeight * 0.08,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    margin: EdgeInsets.symmetric(
                                        horizontal:
                                            getProportionateScreenWidth(10)),
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
                                        horizontal:
                                            getProportionateScreenWidth(10)),
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
                                        horizontal:
                                            getProportionateScreenWidth(10)),
                                    padding: EdgeInsets.all(
                                        getProportionateScreenHeight(12)),
                                    height: getProportionateScreenHeight(40),
                                    width: getProportionateScreenWidth(40),
                                    decoration: BoxDecoration(
                                      color: Color(0xFFF5F6F9),
                                      shape: BoxShape.circle,
                                    ),
                                    child: SvgPicture.asset(
                                        'assets/icons/twitter.svg'),
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
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.pushNamed(
                                          context, SignUpScreen.routeName);
                                    },
                                    child: Text(
                                      "Sign Up",
                                      style: TextStyle(
                                        fontSize:
                                            getProportionateScreenWidth(16),
                                        color: kPrimaryColor,
                                      ),
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
        },
      ),
    );
  }
}
