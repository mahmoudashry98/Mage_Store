import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:e_commerce_app/layout/cubit/cubit.dart';
import 'package:e_commerce_app/layout/cubit/states.dart';
import 'package:e_commerce_app/models/favorite_model.dart';
import 'package:e_commerce_app/screens/product/details_product_screen.dart';
import 'package:e_commerce_app/shared/components/components.dart';
import 'package:e_commerce_app/shared/components/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: Padding(
              padding: const EdgeInsets.only(left: 140),
              child: Text(
                'Favorites List',
                style: TextStyle(
                  color: kTextColor,
                  fontSize: 20,
                ),
              ),
            ),
          ),
          body: ConditionalBuilder(
            condition: state is! AppLoadingGetFavoritesState,
            builder: (context) => ListView.builder(
              itemBuilder: (context, index) => buildFavItem(
                AppCubit.get(context).favoritesModel!.data!.data![index],
                context,
                index,
              ),
              itemCount: AppCubit.get(context).favoritesModel!.data!.data!.length,
            ),
            fallback: (context) => Center(
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Color(0xFFFF7643)),
                )),
          ),
        );
      },
    );
  }


  Widget buildFavItem(
      FavoritesData model,
      context,
      index,
      ) =>
      InkWell(
        onTap: () {
          navigateTo(
              context,
              ProductItemScreen(
                index: index,
                model: AppCubit.get(context).homeModel!.data!.products[index],
              ));
        },
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Container(
            height: 120.0,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  alignment: AlignmentDirectional.bottomStart,
                  children: [
                    Image(
                      image: NetworkImage(
                        model.product!.image
                      ),
                      height: 120.0,
                      width: 120.0,
                    ),
                    if (model.product!.discount != 0 && true)
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 5.0),
                        color: Colors.red,
                        child: Text(
                          'DISCOUNT',
                          style: TextStyle(
                            fontSize: 8.0,
                            color: Colors.white,
                          ),
                        ),
                      ),
                  ],
                ),
                SizedBox(
                  width: 20.0,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        model.product!.name,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 14.0,
                          height: 1.3,
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Text(
                        model.product!.description,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 14.0,
                          height: 1.3,
                        ),
                      ),
                      Row(
                        children: [
                          Text(
                            model.product!.price.toString(),
                            style: TextStyle(
                              fontSize: 12.0,
                              color: kPrimaryColor,
                            ),
                          ),
                          SizedBox(
                            width: 5.0,
                          ),
                          if (model.product!.discount != 0 && true)
                            Text(
                              model.product!.oldPrice.toString(),
                              style: TextStyle(
                                fontSize: 10.0,
                                color: Colors.grey,
                                decoration: TextDecoration.lineThrough,
                              ),
                            ),
                          Spacer(),
                          IconButton(
                            onPressed: () {
                              AppCubit.get(context)
                                  .changeFavorites(model.product!.id);
                            },
                            icon: CircleAvatar(
                              radius: 15.0,
                              backgroundColor: AppCubit.get(context).favorites[model.product!.id]!
                                  ? kPrimaryColor
                                  : Colors.grey,
                              child: Icon(
                                Icons.favorite_border,
                                color: Colors.white,
                                size: 14.0,
                              ),
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      );
}
