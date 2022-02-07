import 'package:e_commerce_app/layout/cubit/cubit.dart';
import 'package:e_commerce_app/layout/cubit/states.dart';
import 'package:e_commerce_app/models/home_model.dart';
import 'package:e_commerce_app/shared/components/components.dart';
import 'package:e_commerce_app/shared/components/constants.dart';
import 'package:e_commerce_app/shared/size/size_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

class ProductItemScreen extends StatefulWidget {
  final ProductModel model;
  final index;

  const ProductItemScreen({Key? key, required this.model, this.index})
      : super(key: key);

  @override
  _ProductItemScreenState createState() => _ProductItemScreenState();
}

class _ProductItemScreenState extends State<ProductItemScreen> {
  int selectedImage = 0;
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            actions: [
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Container(
                  height: 30,
                  width: 60,
                  decoration: BoxDecoration(
                      color: kSecondaryColor.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(10)),
                  child: Row(
                    children: [
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        '4.3',
                        style: TextStyle(color: Colors.black, fontSize: 18),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      SvgPicture.asset('assets/icons/Star Icon.svg'),
                    ],
                  ),
                ),
              ),
            ],
          ),
          body: Column(
            children: [
              SizedBox(
                width: getProportionateScreenWidth(238),
                child: AspectRatio(
                  aspectRatio: 1,
                  child:
                      Image.network('${widget.model.images![selectedImage]}'),
                ),
              ),
              Center(
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ...List.generate(
                        widget.model.images!.length,
                        (index) => buildPreviewProduct(
                          index,
                          //context,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: getProportionateScreenWidth(20)),
                padding: EdgeInsets.only(top: getProportionateScreenWidth(20)),
                width: double.infinity,
                height: 300,
                decoration: BoxDecoration(
                  color: kSecondaryColor.withOpacity(0.1),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(40),
                    topRight: Radius.circular(40),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: getProportionateScreenWidth(20)),
                      child: Text(
                        "${widget.model.name!}",
                        style: Theme.of(context).textTheme.headline6,
                        maxLines: 1,
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: Container(
                        padding:
                            EdgeInsets.all(getProportionateScreenWidth(15)),
                        width: getProportionateScreenWidth(64),
                        decoration: BoxDecoration(
                            color: Color(0xFFFFE6E6),
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(20),
                              bottomLeft: Radius.circular(20),
                            )),
                        child: SvgPicture.asset(
                          'assets/icons/Heart Icon.svg',
                          color: Color(0xFFFF4848),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                        left: getProportionateScreenWidth(20),
                        right: getProportionateScreenWidth(64),
                      ),
                      child: Text(
                        "${widget.model.description!}",
                        overflow: TextOverflow.ellipsis,
                        maxLines: 10,
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                        left: getProportionateScreenWidth(20),
                        right: getProportionateScreenWidth(64),
                      ),
                      child: Text.rich(
                        TextSpan(
                          style: TextStyle(
                            fontSize: getProportionateScreenWidth(12),
                            color: Colors.black,
                          ),
                          children: [
                            TextSpan(
                              text: 'Price: ${widget.model.price!}  ',
                              style: TextStyle(
                                fontSize: getProportionateScreenWidth(18),
                                fontWeight: FontWeight.bold,
                                color: kPrimaryColor,
                              ),
                            ),
                            TextSpan(text: 'EGP'),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                width: getProportionateScreenWidth(200),
                height: getProportionateScreenHeight(46),
                child: defaultFloatButton(
                  text: "Add to Chart",
                  function: () {},
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  GestureDetector buildPreviewProduct(
    int index,
  ) {
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedImage = index;
        });
      },
      child: Container(
        margin: EdgeInsets.only(right: getProportionateScreenWidth(15)),
        padding: EdgeInsets.all(getProportionateScreenHeight(3)),
        height: getProportionateScreenWidth(48),
        width: getProportionateScreenWidth(48),
        decoration: BoxDecoration(
          color: Color(0xFFF5F6F9),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: selectedImage == index ? kPrimaryColor : Colors.transparent,
          ),
        ),
        child: Image.network('${widget.model.images![index]}'),
      ),
    );
  }
}
