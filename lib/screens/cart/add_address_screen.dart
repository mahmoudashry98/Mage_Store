import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:e_commerce_app/layout/cubit/cubit.dart';
import 'package:e_commerce_app/layout/cubit/states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../shared/components/components.dart';
import '../../shared/components/constants.dart';
import '../../shared/size/size_config.dart';

class AddAddressScreen extends StatelessWidget {


  var formKey = GlobalKey<FormState>();
  var cityController = TextEditingController();
  var regionController = TextEditingController();
  var detailsController = TextEditingController();
  var notesController = TextEditingController();




  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var addressModel = AppCubit.get(context).addressModel;
        cityController.text = addressModel!.data!.city!;
        regionController.text = addressModel.data!.region!;
        detailsController.text = addressModel.data!.details!;
        notesController.text = addressModel.data!.notes!;
        return ConditionalBuilder(
          condition: true,
          builder: (context) => Scaffold(
            appBar: AppBar(
              backgroundColor: kPrimaryColor,
              title: Text(
                'AddAddress',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              centerTitle: true,
            ),
            body: Padding(
              padding: const EdgeInsets.only(top: 50, left: 15, right: 15),
              child: Form(
                key: formKey,
                child: Column(
                  children: [
                    //city
                    TextFormField(
                      decoration: InputDecoration(
                        labelText: 'City',
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter your city';
                        }
                      },
                      onFieldSubmitted: (value) {
                        if (formKey.currentState!.validate()) {
                          formKey.currentState!.save();
                        }
                      },
                      controller: cityController,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    //region
                    TextFormField(
                      decoration: InputDecoration(
                        labelText: 'Region',
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter your region';
                        }
                      },
                      onFieldSubmitted: (value) {
                        if (formKey.currentState!.validate()) {
                          formKey.currentState!.save();
                        }
                      },
                      controller: regionController,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    //details
                    TextFormField(
                      decoration: InputDecoration(
                        labelText: 'details',
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter your details';
                        }
                      },
                      onFieldSubmitted: (value) {
                        if (formKey.currentState!.validate()) {
                          formKey.currentState!.save();
                        }
                      },
                      controller: detailsController,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    //notes
                    TextFormField(
                      decoration: InputDecoration(
                        labelText: 'notes',
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter your notes';
                        }
                      },
                      // onFieldSubmitted: (value) {
                      //   if (formKey.currentState!.validate()) {
                      //     formKey.currentState!.save();
                      //   }
                      // },
                      controller: notesController,
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    ConditionalBuilder(
                      condition: state is! AppLoadingUpdateUserAddressState,
                      builder: (context) =>
                          SizedBox(
                            width: 100,
                            height:
                            getProportionateScreenHeight(35),
                            child: defaultFloatButton(
                              text: "Update",
                              function: () {
                                if (formKey.currentState!
                                    .validate()) {
                                  // AppCubit.get(context).updateUserAddress(
                                  //   addressId: id,
                                  //   city: cityController.text,
                                  //   region: regionController.text,
                                  //   detail: detailsController.text,
                                  //   notes: notesController.text,
                                  // );
                                }
                              },
                            ),
                          ),
                      fallback: (context) =>
                          Center(
                              child: CircularProgressIndicator(
                                valueColor:
                                AlwaysStoppedAnimation<Color>(
                                    Color(0xFFFF7643)),
                              )),
                    ),
                  ],
                ),
              ),
            ),
          ),
          fallback: (context) => CircularProgressIndicator(),
        );
      },
    );
  }
}
