import 'package:e_commerce_app/layout/cubit/cubit.dart';
import 'package:e_commerce_app/layout/cubit/states.dart';
import 'package:e_commerce_app/models/product_model.dart';
import 'package:e_commerce_app/shared/components/components.dart';
import 'package:e_commerce_app/shared/components/constants.dart';
import 'package:e_commerce_app/shared/size/size_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ProductScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, states) {},
      builder: (context, states) {
        List<Map<String, dynamic>> categories = [
          {"icon": "assets/icons/Flash Icon.svg", "text": "Flash\nDeal"},
          {"icon": "assets/icons/Bill Icon.svg", "text": "Bill"},
          {"icon": "assets/icons/Game Icon.svg", "text": "Game"},
          {"icon": "assets/icons/Gift Icon.svg", "text": "Daily\nGift"},
          {"icon": "assets/icons/Discover.svg", "text": "More"},
        ];
        return SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: getProportionateScreenWidth(20),
                    vertical: getProportionateScreenWidth(20),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                          width: SizeConfig.screenWidth * 0.6,
                          height: 50,
                          decoration: BoxDecoration(
                            color: kSecondaryColor.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: TextField(
                            onChanged: (value) {
                              ///////////////////search product
                            },
                            decoration: InputDecoration(
                                enabledBorder: InputBorder.none,
                                focusedBorder: InputBorder.none,
                                hintText: 'Search Product',
                                prefixIcon: Icon(Icons.search),
                                contentPadding: EdgeInsets.symmetric(
                                  horizontal: getProportionateScreenWidth(20),
                                  vertical: getProportionateScreenHeight(20),
                                )),
                          )),
                      buildIconBtnWithCounter(
                        numItems: 0,
                        svgScr: 'assets/icons/Cart Icon.svg',
                      ),
                      buildIconBtnWithCounter(
                        numItems: 3,
                        svgScr: 'assets/icons/Bell.svg',
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: getProportionateScreenWidth(10),
                ),
                Container(
                  margin: EdgeInsets.symmetric(
                    horizontal: getProportionateScreenWidth(20),
                  ),
                  padding: EdgeInsets.symmetric(
                    horizontal: getProportionateScreenWidth(20),
                    vertical: getProportionateScreenWidth(15),
                  ),
                  width: double.infinity,
                  height: 90,
                  decoration: BoxDecoration(
                      color: Color(0xFF4A3298),
                      borderRadius: BorderRadius.circular(20)),
                  child: Text.rich(TextSpan(
                    text: "A Summer Surprise\n",
                    style: TextStyle(
                      color: Colors.white,
                    ),
                    children: [
                      TextSpan(
                          text: "CashBack 20%",
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          )),
                    ],
                  )),
                ),
                SizedBox(
                  height: getProportionateScreenWidth(30),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: getProportionateScreenWidth(20),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ...List.generate(
                          categories.length,
                          (index) => buildCategoriesItems(
                                icon: categories[index]["icon"],
                                text: categories[index]["text"],
                                press: () {},
                              )),
                    ],
                  ),
                ),
                SizedBox(
                  height: getProportionateScreenWidth(30),
                ),
                Column(
                  children: [
                    buildSectionTitle(
                      text: "Special for you",
                      press: () {},
                    ),
                    SizedBox(
                      height: getProportionateScreenWidth(20),
                    ),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          buildSpecialOfferCard(
                            category: 'Smartphone',
                            image: 'assets/images/banner 2.png',
                            numOfBrands: 18,
                            press: () {},
                          ),
                          buildSpecialOfferCard(
                            category: 'Smartphone',
                            image: 'assets/images/banner 3.png',
                            numOfBrands: 24,
                            press: () {},
                          ),
                          SizedBox(
                            width: getProportionateScreenWidth(20),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: getProportionateScreenWidth(20),
                    ),
                  ],
                ),
                Column(
                  children: [
                    buildSectionTitle(
                      text: "Popular Product",
                      press: () {},
                    ),
                    SizedBox(
                      height: getProportionateScreenWidth(20),
                    ),
                    Container(
                      width: double.infinity,
                      height: getProportionateScreenWidth(190),
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) => buildProductCard(),
                        itemCount: 10,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  width: getProportionateScreenWidth(20),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget buildSectionTitle({
    required final String text,
    required final GestureTapCallback press,
  }) =>
      Padding(
        padding: EdgeInsets.symmetric(
          horizontal: getProportionateScreenWidth(20),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              text,
              style: TextStyle(
                  fontSize: getProportionateScreenWidth(18),
                  color: Colors.black),
            ),
            GestureDetector(
              onTap: press,
              child: Text(
                'See more',
              ),
            ),
          ],
        ),
      );

  Widget buildCategoriesItems({
    required final String icon,
    required final String text,
    required final GestureTapCallback press,
  }) =>
      GestureDetector(
        onTap: press,
        child: SizedBox(
          width: getProportionateScreenWidth(55),
          child: Column(
            children: [
              AspectRatio(
                aspectRatio: 1,
                child: Container(
                  padding: EdgeInsets.all(
                    getProportionateScreenWidth(15),
                  ),
                  decoration: BoxDecoration(
                    color: Color(0xFFFFECDF),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: SvgPicture.asset(icon),
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              Text(
                text,
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      );

  Widget buildSpecialOfferCard({
    required final String category,
    required final String image,
    required final int numOfBrands,
    required final GestureTapCallback press,
  }) =>
      Padding(
        padding: EdgeInsets.only(
          left: getProportionateScreenWidth(20),
        ),
        child: SizedBox(
          height: getProportionateScreenWidth(100),
          width: getProportionateScreenWidth(242),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20.0),
            child: Stack(
              children: [
                Image.asset(
                  image,
                  fit: BoxFit.cover,
                ),
                Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Color(0xFF343434).withOpacity(0.4),
                        Color(0xFF343434).withOpacity(0.15),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: getProportionateScreenWidth(15),
                    vertical: getProportionateScreenWidth(10),
                  ),
                  child: Text.rich(
                    TextSpan(
                        style: TextStyle(
                          color: Colors.white,
                        ),
                        children: [
                          TextSpan(
                              text: '$category\n',
                              style: TextStyle(
                                fontSize: getProportionateScreenWidth(18),
                                fontWeight: FontWeight.bold,
                              )),
                          TextSpan(text: '$numOfBrands Brands'),
                        ]),
                  ),
                )
              ],
            ),
          ),
        ),
      );

  Widget buildProductCard() => Padding(
        padding: EdgeInsets.only(left: getProportionateScreenWidth(20)),
        child: Container(
          width: getProportionateScreenWidth(140),
          child: Column(
            children: [
              AspectRatio(
                aspectRatio: 1.02,
                child: Container(
                  padding: EdgeInsets.all(
                    getProportionateScreenWidth(20),
                  ),
                  decoration: BoxDecoration(
                    color: kSecondaryColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  child: Image.asset('assets/images/ps4_white_1.png'),
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              Text(
                "Wireless Controller for PS4",
                style: TextStyle(
                  color: Colors.black,
                ),
                maxLines: 2,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "\$64.99",
                    style: TextStyle(
                      fontSize: getProportionateScreenWidth(18),
                      fontWeight: FontWeight.w600,
                      color: kPrimaryColor,
                    ),
                  ),
                  InkWell(
                    borderRadius: BorderRadius.circular(30),
                    onTap: () {},
                    child: Container(
                      width: getProportionateScreenWidth(28),
                      height: getProportionateScreenWidth(28),
                      decoration: BoxDecoration(
                          color: kSecondaryColor.withOpacity(0.1),
                          shape: BoxShape.circle),
                      child: Icon(
                        Icons.favorite,
                        size: 15,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      );
}