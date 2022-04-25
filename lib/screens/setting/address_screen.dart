import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:e_commerce_app/layout/cubit/cubit.dart';
import 'package:e_commerce_app/layout/cubit/states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../shared/components/components.dart';
import '../../shared/components/constants.dart';
import '../../shared/network/local/cache_helper.dart';
import '../../shared/size/size_config.dart';

class AddressScreen extends StatelessWidget {
  const AddressScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var formKey = GlobalKey<FormState>();
    var cityController = TextEditingController();
    var regionController = TextEditingController();
    var streetController = TextEditingController();
    var notesController = TextEditingController();
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {
        if (state is AppSuccessUserAddressState) {
          if (state.addressModel.status!) {
            print(state.addressModel.message!);
            print(state.addressModel.data!);
            CacheHelper.saveData(
              key: 'token',
              value: state.addressModel.data!,
            );
          }
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: Text(
              'Profile',
              style: TextStyle(
                color: kTextColor,
                fontSize: 18,
              ),
            ),
            centerTitle: true,
          ),
          body: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              // mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                    height: 300,
                    width: double.infinity,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                      image: AssetImage('assets/images/addressHome.png'),
                    ))),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Form(
                    key: formKey,
                    child: Column(
                      children: [
                        //city
                        TextFormField(
                          controller: cityController,
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
                        //Street
                        TextFormField(
                          decoration: InputDecoration(
                            labelText: 'street',
                            border: OutlineInputBorder(),
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please enter your street';
                            }
                          },
                          onFieldSubmitted: (value) {
                            if (formKey.currentState!.validate()) {
                              formKey.currentState!.save();
                            }
                          },
                          controller: streetController,
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
                          height: 20,
                        ),
                        ConditionalBuilder(
                          condition: state is! AppLoadingUserAddressState,
                          builder: (context) => SizedBox(
                            width: 100,
                            height: getProportionateScreenHeight(35),
                            child: defaultFloatButton(
                                text: "Save",
                                function: () {
                                  if (formKey.currentState!.validate()) {
                                    AppCubit.get(context).addAddress(
                                      city: cityController.text.toString(),
                                      region: regionController.text.toString(),
                                      details: streetController.text.toString(),
                                      notes: notesController.text.toString(),
                                    );
                                  }
                                }),
                          ),
                          fallback: (context) => Center(
                              child: CircularProgressIndicator(
                            valueColor: AlwaysStoppedAnimation<Color>(
                                Color(0xFFFF7643)),
                          )),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
