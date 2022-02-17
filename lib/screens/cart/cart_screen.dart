import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:e_commerce_app/layout/cubit/cubit.dart';
import 'package:e_commerce_app/layout/cubit/states.dart';
import 'package:e_commerce_app/models/cart_product_model.dart';
import 'package:e_commerce_app/shared/components/components.dart';
import 'package:e_commerce_app/shared/components/constants.dart';
import 'package:e_commerce_app/shared/size/size_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({Key? key}) : super(key: key);
  static String routeName = "/cart";

  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
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
                  Text(''
                      // '${demoCart.length} items',
                      //  style: Theme.of(context).textTheme.caption,
                      )
                ],
              ),
            ),
          ),
          body: ConditionalBuilder(
            condition: state is! AppLoadingGetCartsState,
            builder: (context) => ListView.builder(
              itemBuilder: (context, index) => buildCart(
                AppCubit.get(context).cartsModel!.data!.cartItems![index],
              ),
              itemCount:
                  AppCubit.get(context).cartsModel!.data!.cartItems!.length,
            ),
            fallback: (context) => Center(
                child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Color(0xFFFF7643)),
            )),
          ),
          bottomNavigationBar: Container(
            //height: 174,
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
                          child: SvgPicture.asset('assets/icons/receipt.svg'),
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
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text.rich(
                          TextSpan(text: "Total:\n", children: [
                            TextSpan(
                                text: "335.5 ",
                                style: TextStyle(
                                    fontSize: 16, color: Colors.black)),
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
                            function: () {},
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget buildCart(CartItems model) => Padding(
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
                              "${model.product!.image}",
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
                                "${model.product!.name}",
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
                                          "${model.product!.price.toString()} ",
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
                                          onPressed: () {},
                                        ),
                                        Text(
                                          '1',
                                          style: TextStyle(
                                              fontSize: 20,
                                              color: Colors.black),
                                        ),
                                        IconButton(
                                          padding: EdgeInsets.only(bottom: 20),
                                          icon: Icon(
                                            Icons.minimize,
                                          ),
                                          onPressed: () {},
                                        ),
                                      ],
                                    ),
                                  ),
                                  Spacer(),
                                  InkWell(
                                    borderRadius: BorderRadius.circular(55.0),
                                    onTap: () {
                                      AppCubit.get(context)
                                          .changeCarts(model.product!.id!);
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
