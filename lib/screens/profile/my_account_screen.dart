import 'dart:io';

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:e_commerce_app/layout/cubit/cubit.dart';
import 'package:e_commerce_app/layout/cubit/states.dart';
import 'package:e_commerce_app/shared/components/components.dart';
import 'package:e_commerce_app/shared/components/constants.dart';
import 'package:e_commerce_app/shared/size/size_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

class MyAccountScreen extends StatelessWidget {
  const MyAccountScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    var nameController = TextEditingController();
    var emailController = TextEditingController();
    var phoneController = TextEditingController();
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var imageProfile = AppCubit.get(context).imageProfile;
        var model = AppCubit.get(context).userModel;
        nameController.text = model!.data!.name!;
        emailController.text = model.data!.email!;
        phoneController.text = model.data!.phone!;
        return Scaffold(
          appBar: AppBar(
            title: Padding(
              padding: const EdgeInsets.only(left: 110),
              child: Text(
                'Profile',
                style: TextStyle(
                  color: kTextColor,
                  fontSize: 18,
                ),
              ),
            ),
          ),
          body: SingleChildScrollView(
            child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    SizedBox(
                      height: 115,
                      width: 115,
                      child: Stack(
                        fit: StackFit.expand,
                        overflow: Overflow.visible,
                        children: [
                          CircleAvatar(
                            backgroundImage: imageProfile == null
                                ? NetworkImage('${model.data!.image}')
                                : FileImage(imageProfile) as ImageProvider,
                            backgroundColor: Color(0xFFF5F6F9),
                          ),
                          Positioned(
                            right: -10,
                            bottom: 0,
                            child: SizedBox(
                              height: 46,
                              width: 46,
                              child: FlatButton(
                                padding: EdgeInsets.zero,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(50),
                                    side: BorderSide(color: Colors.white)),
                                color: Color(0xFFF5F6F9),
                                onPressed: () {
                                  AppCubit.get(context).getProfileImage();
                                },
                                child: SvgPicture.asset(
                                    'assets/icons/Camera Icon.svg'),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: getProportionateScreenHeight(30),
                    ),
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
                      labelText: "Name",
                      suffix: Icons.person_rounded,
                      keyboardType: TextInputType.text,
                      controller: nameController,
                      hintText: '',
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
                      hintText: "",
                      labelText: "Email",
                      suffix: Icons.email_outlined,
                      keyboardType: TextInputType.emailAddress,
                      controller: emailController,
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
                      hintText: "",
                      labelText: "Phone",
                      suffix: Icons.phone,
                      keyboardType: TextInputType.number,
                      controller: phoneController,
                    ),
                    SizedBox(
                      height: getProportionateScreenHeight(30),
                    ),
                    SizedBox(
                      width: double.infinity,
                      height: getProportionateScreenHeight(56),
                      child: ConditionalBuilder(
                        condition:state is! AppLoadingUpdateUserState ,
                        builder: (context) =>defaultFloatButton(
                          text: "Update",
                          function: () {
                            if (_formKey.currentState!.validate()) {
                              AppCubit.get(context).updateUserData(
                                image: model.data!.image,
                                name: nameController.text,
                                email: emailController.text,
                                phone: phoneController.text,
                              );
                            }
                          },
                        ),
                          fallback: (context) => Center(
                              child: CircularProgressIndicator(
                                valueColor: AlwaysStoppedAnimation<Color>(Color(0xFFFF7643)),
                              )),

                      ),
                    ),
                  ],
                ),
              ),

            ),

        );
      },
    );
  }
}
