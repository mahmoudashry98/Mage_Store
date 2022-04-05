import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:e_commerce_app/layout/cubit/cubit.dart';
import 'package:e_commerce_app/layout/cubit/states.dart';
import 'package:e_commerce_app/models/cart_product_model.dart';
import 'package:e_commerce_app/screens/cart/check_out/check_out_screen.dart';
import 'package:e_commerce_app/shared/components/components.dart';
import 'package:e_commerce_app/shared/components/constants.dart';
import 'package:e_commerce_app/shared/size/size_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CartScreen extends StatelessWidget {
  static String routeName = "/cart";

  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var model = AppCubit.get(context).cartsModel!.data!;
        return Scaffold(
          appBar: AppBar(
            title: Padding(
              padding: const EdgeInsets.only(left: 95),
              child: Column(
                children: [
                  Text(
                    'Your Cart',
                    style: TextStyle(
                      color: Colors.black,
                    ),
                  ),
                  Text(
                    ''
                    '${model.cartItems!.length} items',
                    style: Theme.of(context).textTheme.caption,
                  )
                ],
              ),
            ),
          ),
          body: ConditionalBuilder(
            condition: state is! AppLoadingGetCartsState,
            builder: (context) =>
                AppCubit.get(context).cartsModel!.data!.cartItems!.length == 0
                    ? Center(
                        child: SvgPicture.asset(
                          'assets/images/empty_cart.svg',
                          width: 200,
                          height: 200,
                        ),
                      )
                    : ListView.builder(
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
            fallback: (context) => Center(
                child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Color(0xFFFF7643)),
            )),
          ),
          bottomNavigationBar: ConditionalBuilder(
            condition:
                AppCubit.get(context).cartsModel!.data!.cartItems!.length != 0,
            builder: (context) =>
                AppCubit.get(context).cartsModel!.data!.cartItems!.length == 0
                    ? Container(
                        color: Colors.white,
                      )
                    : Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(30),
                            topRight: Radius.circular(30),
                          ),
                          boxShadow: ([
                            BoxShadow(
                              offset: Offset(
                                0,
                                -15,
                              ),
                              blurRadius: 20,
                              color: Color(0xFFDADADA).withOpacity(0.5),
                            ),
                          ]),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(20),
                          child: SafeArea(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Row(
                                  children: [
                                    Container(
                                      padding: EdgeInsets.all(10),
                                      height: getProportionateScreenWidth(40),
                                      width: getProportionateScreenWidth(40),
                                      decoration: BoxDecoration(
                                        color: Color(0xFFF5F6F9),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: SvgPicture.asset(
                                          'assets/icons/receipt.svg'),
                                    ),
                                    Spacer(),
                                    Text(
                                      'Add voucher code',
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    Icon(
                                      Icons.arrow_forward_ios,
                                      size: 18,
                                      color: kTextColor,
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: getProportionateScreenWidth(20),
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text.rich(
                                      TextSpan(text: "Total:\n", children: [
                                        TextSpan(
                                            text: "${model.total} ",
                                            style: TextStyle(
                                                fontSize: 20,
                                                color: Colors.black)),
                                        TextSpan(
                                          text: 'EGP ',
                                          style: TextStyle(color: kTextColor),
                                        )
                                      ]),
                                    ),
                                    SizedBox(
                                      width: getProportionateScreenWidth(200),
                                      height: getProportionateScreenHeight(46),
                                      child: defaultFloatButton(
                                        text: "Check Out",
                                        function: () {
                                          navigateTo(context, CheckOutScreen());
                                        },
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
            fallback: (context) => CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
            ),
          ),
        );
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
                              Row(
                                children: [
                                  Container(
                                    width: 140,
                                    height: 40,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: Color(0xFFDADADA).withOpacity(0.5),
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        IconButton(
                                          icon: Icon(Icons.add),
                                          onPressed: () {
                                            AppCubit.get(context)
                                                .plusQuantity(index, model);
                                            AppCubit.get(context)
                                                .updateCartData(
                                              id: model
                                                  .data!.cartItems![index].id
                                                  .toString(),
                                              quantity: model.data!.cartItems![index].quantity
                                            );
                                          },
                                        ),
                                        Text(
                                          '${model.data!.cartItems![index].quantity.toString()}',
                                          style: TextStyle(
                                              fontSize: 20,
                                              color: Colors.black),
                                        ),
                                        IconButton(
                                          padding: EdgeInsets.only(bottom: 20),
                                          icon: Icon(
                                            Icons.minimize,
                                          ),
                                          onPressed: () {
                                            AppCubit.get(context)
                                                .minusQuantity(index, model);
                                            AppCubit.get(context)
                                                .updateCartData(
                                                id: model
                                                    .data!.cartItems![index].id
                                                    .toString(),
                                                quantity: model.data!.cartItems![index].quantity
                                            );
                                          },
                                        ),
                                      ],
                                    ),
                                  ),
                                  Spacer(),
                                  InkWell(
                                    borderRadius: BorderRadius.circular(55.0),
                                    onTap: () {
                                      AppCubit.get(context)
                                          .changeCarts(cartItems.product!.id!);
                                    },
                                    child: SvgPicture.asset(
                                      'assets/icons/Trash.svg',
                                    ),
                                  ),
                                ],
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
