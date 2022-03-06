import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:e_commerce_app/layout/cubit/cubit.dart';
import 'package:e_commerce_app/layout/home_layout.dart';
import 'package:e_commerce_app/screens/sign_in/login_success_screen.dart';
import 'package:e_commerce_app/screens/sign_up/cubit/cubit.dart';
import 'package:e_commerce_app/shared/components/components.dart';
import 'package:e_commerce_app/shared/components/constants.dart';
import 'package:e_commerce_app/shared/network/local/cache_helper.dart';
import 'package:e_commerce_app/shared/size/size_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

import 'cubit/states.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({Key? key}) : super(key: key);
  static String routeName = "/sign_up";

  @override
  Widget build(BuildContext context) {
    var nameController = TextEditingController();
    var emailController = TextEditingController();
    var passwordController = TextEditingController();
    var phoneController = TextEditingController();
    final _formKey = GlobalKey<FormState>();
    return BlocProvider(
      create: (context) => RegisterCubit(),
      child: BlocConsumer<RegisterCubit, RegisterStates>(
        listener: (context, state) {
          if (state is RegisterSuccessState) {
            if (state.loginModel.status!) {
              print(state.loginModel.message!);
              print(state.loginModel.data!.token);
              showToast(
                text: state.loginModel.message!,
                state: ToastStates.SUCCESS,
              );
              CacheHelper.saveData(
                      key: 'token', value: state.loginModel.data!.token)
                  .then((value) {
                Navigator.pushReplacementNamed(context, HomeLayout.routeName);
              });
            } else {

            }
          }else if(state is RegisterErrorState){
            print(state.loginModel.message);
            showToast(
              text: state.loginModel.message!,
              state: ToastStates.ERROR,
            );
          }
        },
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              title: Padding(
                padding: const EdgeInsets.only(left: 105),
                child: Text(
                  'Sign Up',
                  style: TextStyle(
                    color: kTextColor,
                    fontSize: 18,
                  ),
                ),
              ),
            ),
            body: SizedBox(
              width: double.infinity,
              child: SingleChildScrollView(
                  child: Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: getProportionateScreenWidth(20)),
                child: Column(
                  children: [
                    SizedBox(
                      height: SizeConfig.screenHeight * 0.04,
                    ),
                    Text(
                      'Register Account',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: getProportionateScreenWidth(28),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      'Complete your details or continue \nwith social media',
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
                                return 'please enter your Name';
                              }
                            },
                            onSubmit: (value) {
                              if (_formKey.currentState!.validate()) {
                                _formKey.currentState!.save();
                              }
                            },
                            hintText: "Enter your name",
                            labelText: "Name",
                            suffix: Icons.person_rounded,
                            keyboardType: TextInputType.text,
                            controller: nameController,
                          ),
                          SizedBox(
                            height: getProportionateScreenHeight(30),
                          ),
                          defaultTextForm(
                            validate: (String? value) {
                              if (value!.isEmpty) {
                                return 'please enter your Email';
                              }
                            },
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
                            height: getProportionateScreenHeight(30),
                          ),
                          defaultTextForm(
                            onSubmit: (value) {
                              if (_formKey.currentState!.validate()) {
                                RegisterCubit.get(context).userRegister(
                                  email: emailController.text,
                                  password: passwordController.text,
                                  name: nameController.text,
                                  phone: phoneController.text,
                                );
                              }
                            },
                            isPassword: RegisterCubit.get(context).isPassword,
                            suffixPressed: () {
                              RegisterCubit.get(context)
                                  .changePasswordVisibility();
                            },
                            validate: (String? value) {
                              if (value!.isEmpty) {
                                return 'password is too short';
                              }
                            },
                            hintText: "Enter Password",
                            labelText: "Password",
                            suffix: RegisterCubit.get(context).suffix,
                            keyboardType: TextInputType.visiblePassword,
                            controller: passwordController,
                          ),
                          SizedBox(
                            height: getProportionateScreenHeight(30),
                          ),
                          defaultTextForm(
                            validate: (String? value) {
                              if (value!.isEmpty) {
                                return 'please enter your Phone';
                              }
                            },
                            onSubmit: (value) {
                              if (_formKey.currentState!.validate()) {
                                _formKey.currentState!.save();
                              }
                            },
                            hintText: "Enter your phone",
                            labelText: "Phone",
                            suffix: Icons.phone,
                            keyboardType: TextInputType.number,
                            controller: phoneController,
                          ),
                          SizedBox(
                            height: getProportionateScreenHeight(30),
                          ),
                          ConditionalBuilder(
                            condition: state is! RegisterLoadingState,
                            builder: (context) => SizedBox(
                              width: double.infinity,
                              height: getProportionateScreenHeight(56),
                              child: defaultFloatButton(
                                text: "Continue",
                                function: () {
                                  if (_formKey.currentState!.validate()) {
                                    RegisterCubit.get(context).userRegister(
                                        name: nameController.text,
                                        email: emailController.text,
                                        password: passwordController.text,
                                        phone: phoneController.text);
                                    AppCubit.get(context).currentIndex = 0;
                                  }
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
                          Text(
                            'By continuing your confirm that you agree \nwith our Term and Condition',
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              )),
            ),
          );
        },
      ),
    );
  }
}
