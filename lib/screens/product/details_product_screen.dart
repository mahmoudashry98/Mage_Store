import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
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
      listener: (context, state) {
        if (state is AppSuccessChangeCartsState) {
          if (state.model.status!) {
            print(state.model.message);
            showToast(
              text: state.model.message!,
              state: ToastStates.SUCCESS,
            );
          } else if (!state.model.status!) {
            print(state.model.message);
            showToast(
              text: state.model.message!,
              state: ToastStates.ERROR,
            );
          }
        }
      },
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
                width: getProportionateScreenWidth(220),
                child: AspectRatio(
                  aspectRatio: 1,
                  child:
                      Image.network('${widget.model.images![selectedImage]}'),
                ),
              ),
              const SizedBox(
                height: 5,
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
                        padding: EdgeInsets.all(getProportionateScreenWidth(5)),
                        width: getProportionateScreenWidth(64),
                        decoration: BoxDecoration(
                            color: Color(0xFFFFE6E6),
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(20),
                              bottomLeft: Radius.circular(20),
                            )),
                        child: IconButton(
                          onPressed: () {
                            AppCubit.get(context)
                                .changeFavorites(widget.model.id!);
                          },
                          icon: Icon(
                            Icons.favorite,
                            size: 25,
                            color: AppCubit.get(context)
                                    .favorites[widget.model.id]!
                                ? kPrimaryColor
                                : Colors.grey,
                          ),
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
                      child: Expanded(
                        child: Row(
                          children: [
                            Text.rich(
                              TextSpan(
                                style: TextStyle(
                                  fontSize: getProportionateScreenWidth(12),
                                  color: Colors.black,
                                ),
                                children: [
                                  TextSpan(
                                    text:
                                        'Price: ${widget.model.price.round()} ',
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
                            SizedBox(
                              width: 5.0,
                            ),
                            if (widget.model.discount != 0)
                              Text(
                                '${widget.model.oldPrice.round()}',
                                style: TextStyle(
                                  fontSize: 14.0,
                                  color: Colors.grey,
                                  decoration: TextDecoration.lineThrough,
                                ),
                              ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              ConditionalBuilder(
                condition: state is! AppChangeCartsLoadingState,
                builder: (context) => SizedBox(
                  width: getProportionateScreenWidth(200),
                  height: getProportionateScreenHeight(46),
                  child: defaultFloatButton(
                    text: "Add to Chart",
                    function: () {
                      AppCubit.get(context).changeCarts(widget.model.id!);
                    },
                  ),
                ),
                fallback: (context) => Center(
                    child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Color(0xFFFF7643)),
                )),
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
