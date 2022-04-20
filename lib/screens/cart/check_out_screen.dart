import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:e_commerce_app/layout/cubit/cubit.dart';
import 'package:e_commerce_app/layout/cubit/states.dart';
import 'package:e_commerce_app/shared/components/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../models/cart_product_model.dart';
import '../../shared/components/components.dart';
import '../../shared/size/size_config.dart';

class CheckOutScreen extends StatelessWidget {
  final int? id;
  const CheckOutScreen({Key? key, this.id}) : super(key: key);

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
          print(state.addressModel.data);
        }
      },
      builder: (context, state) {
        var model = AppCubit
            .get(context)
            .userModel;
        var index = 0;
        var addressModel =
        AppCubit
            .get(context)
            .getAddressModel!
            .data!
            .data![index];
        int currentValue = AppCubit
            .get(context)
            .currentValue;
        int newIndex = AppCubit
            .get(context)
            .newIndex;
        cityController.text = addressModel.city!;
        regionController.text = addressModel.region!;
        streetController.text = addressModel.details!;
        notesController.text = addressModel.notes!;
        return Scaffold(
            appBar: AppBar(
              backgroundColor: kPrimaryColor,
              title: Text(
                'CheckOut',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              centerTitle: true,
            ),
            body: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(height: 5,),
                  if (state is AppLoadingUpdateUserAddressState)
                    LinearProgressIndicator(
                      backgroundColor: Colors.white,
                      color: kPrimaryColor,
                    ),
                  Theme(
                    data: ThemeData(
                      colorScheme: ColorScheme.light(primary: kPrimaryColor),
                    ),
                    child: Stepper(
                      steps: [
                        Step(
                          title: Text(
                            'Delivery',
                            style: TextStyle(
                              fontSize: 14,
                            ),
                          ),
                          content: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Standard Delivery',
                                style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black),
                              ),
                              Row(
                                children: [
                                  Text(
                                    'Order will be delivered between 3-5 business\ndays',
                                  ),
                                  Spacer(),
                                  Radio(
                                    value: 1,
                                    groupValue: currentValue,
                                    onChanged: (value) {
                                      AppCubit.get(context).radio(value);
                                    },
                                    activeColor: kPrimaryColor,
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 15,
                              ),
                              Text(
                                'Next Day Delivery',
                                style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black),
                              ),
                              Row(
                                children: [
                                  Text(
                                    'place your order before 6pm and your items will\nbe delivered the next day',
                                  ),
                                  Spacer(),
                                  Radio(
                                    value: 2,
                                    groupValue: currentValue,
                                    onChanged: (value) {
                                      AppCubit.get(context).radio(value);
                                    },
                                    activeColor: kPrimaryColor,
                                  ),
                                  SizedBox(
                                    height: 15,
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 15,
                              ),
                              Text(
                                'Nominated Delivery',
                                style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black),
                              ),
                              Row(
                                children: [
                                  Text(
                                    'Pick a particular data from the calender and order\nwill be delivered on selected date',
                                  ),
                                  Spacer(),
                                  Radio(
                                    value: 3,
                                    groupValue: currentValue,
                                    onChanged: (value) {
                                      AppCubit.get(context).radio(value);
                                    },
                                    activeColor: kPrimaryColor,
                                  ),
                                  SizedBox(
                                    height: 15,
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                        Step(
                          title: Text(
                            'Address',
                            style: TextStyle(
                              fontSize: 14,
                            ),
                          ),
                          content: Padding(
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
                                        return 'Please enter your city';
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
                                    height: 10,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 220, top: 10),
                                    child: ConditionalBuilder(
                                      condition:
                                      state is! AppLoadingUpdateUserAddressState,
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
                                                    AppCubit.get(context)
                                                        .updateAddress(
                                                      addressId: addressModel.id,
                                                      city: cityController.text,
                                                      region: regionController.text,
                                                      details: streetController.text,
                                                      notes: notesController.text,
                                                    );
                                                  }
                                                }),
                                          ),
                                      fallback: (context) =>
                                          Center(
                                              child: CircularProgressIndicator(
                                                valueColor:
                                                AlwaysStoppedAnimation<Color>(
                                                    Color(0xFFFF7643)),
                                              )),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Step(
                          title: Text(
                            'Summary',
                            style: TextStyle(
                              fontSize: 14,
                            ),
                          ),
                          content: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Shipping address',
                                style: TextStyle(
                                    fontSize: 18,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w500),
                              ),
                              Container(
                                height: 70,
                                width: double.infinity,
                                child: Card(
                                  color: Colors.white,
                                  elevation: 5,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            Text(
                                              '${model!.data!.name}',
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontWeight:
                                                      FontWeight.bold),
                                            ),
                                            Spacer(),
                                            Icon(
                                              Icons.arrow_back_ios,
                                              size: 20,
                                            ),
                                          ],
                                        ),
                                        Text.rich(
                                          TextSpan(
                                            children: [
                                              TextSpan(
                                                  text:
                                                      '${addressModel.city},',
                                                  style: TextStyle(
                                                    fontSize: 16,
                                                  )),
                                              TextSpan(
                                                  text:
                                                      '${addressModel.region},',
                                                  style: TextStyle(
                                                    fontSize: 16,
                                                  )),
                                              TextSpan(
                                                  text:
                                                      '${addressModel.details},',
                                                  style: TextStyle(
                                                    fontSize: 16,
                                                  )),
                                              TextSpan(
                                                text:
                                                    '${addressModel.notes},',
                                                style: TextStyle(
                                                  fontSize: 16,
                                                ),
                                              ),
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Container(
                                height: 250,
                                width: double.infinity,
                                child: ListView.builder(
                                  itemBuilder: (context, index) => buildCart(
                                    AppCubit.get(context)
                                        .cartsModel!
                                        .data!
                                        .cartItems![index],
                                    context,
                                    index,
                                    AppCubit.get(context).cartsModel!,
                                  ),
                                  itemCount: AppCubit.get(context)
                                      .cartsModel!
                                      .data!
                                      .cartItems!
                                      .length,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                      onStepTapped: (int index) {
                        AppCubit.get(context).onStepTapped(index);
                      },
                      currentStep: AppCubit
                          .get(context)
                          .newIndex,
                      onStepContinue: () {
                        AppCubit.get(context).onStepContinue();
                        if (newIndex == 1) {
                          if (formKey.currentState!.validate()) {
                            formKey.currentState!.save();
                          }
                        }
                      },
                      onStepCancel: () {
                        AppCubit.get(context).onStepCancel();
                      },
                    ),
                  ),
                  //Text('${addressModel.id}'),
                  defaultFloatButton(
                    text: "Done Order",
                    function: () {},
                  ),
                ],
              ),
            ));
      },
    );
  }

  Widget buildCart(CartItems cartItems, context, index, CartsModel model) =>
      Padding(
        padding: EdgeInsets.symmetric(
          vertical: 10,
        ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                ),
                height: 150,
                child: Card(
                  elevation: 2,
                  child: Row(
                    children: [
                      SizedBox(
                        width: getProportionateScreenWidth(95),
                        child: AspectRatio(
                          aspectRatio: 0.99,
                          child: Container(
                            child: Image.network(
                              "${cartItems.product!.image}",
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "${cartItems.product!.name}",
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                    fontSize: 16.0, color: Colors.black),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              Text.rich(
                                TextSpan(
                                  style: TextStyle(
                                    fontSize: getProportionateScreenWidth(12),
                                    color: Colors.black,
                                  ),
                                  children: [
                                    TextSpan(
                                      text:
                                      "${cartItems.product!.price.toString()} ",
                                      style: TextStyle(
                                        fontSize:
                                        getProportionateScreenWidth(18),
                                        fontWeight: FontWeight.bold,
                                        color: kPrimaryColor,
                                      ),
                                    ),
                                    TextSpan(
                                        text: 'EGP ',
                                        style: TextStyle(color: Colors.black)),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Expanded(
                                child: Row(
                                  children: [
                                    Container(
                                      width: 140,
                                      height: 40,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color:
                                        Color(0xFFDADADA).withOpacity(0.5),
                                      ),
                                      child: Row(
                                        mainAxisAlignment:
                                        MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            'Quantity: ${model.data!
                                                .cartItems![index].quantity
                                                .toString()}',
                                            style: TextStyle(
                                                fontSize: 20,
                                                color: Colors.black),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      );
}
