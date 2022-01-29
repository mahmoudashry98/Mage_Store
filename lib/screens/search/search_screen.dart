import 'package:e_commerce_app/shared/components/constants.dart';
import 'package:e_commerce_app/shared/size/size_config.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'cubit/cubit.dart';
import 'cubit/states.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({Key? key}) : super(key: key);
  static String routeName = "/search";
  @override
  Widget build(BuildContext context) {
    var searchController = TextEditingController();
    return BlocProvider(
      create: (context) => SearchCubit(),
      child: BlocConsumer<SearchCubit, SearchStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(),
            body: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: Container(
                    width: double.infinity,
                    height: 50,
                    decoration: BoxDecoration(
                      color: kSecondaryColor.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: TextField(
                      controller: searchController,
                      onSubmitted: (String text) {
                        SearchCubit.get(context).search(text);
                      },
                      decoration: InputDecoration(
                        enabledBorder: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        hintText: 'Search Product',
                        prefixIcon: Icon(Icons.search),
                        contentPadding: EdgeInsets.symmetric(
                          horizontal: getProportionateScreenWidth(20),
                          vertical: getProportionateScreenHeight(20),
                        ),
                      ),
                    ),
                  ),
                ),
                if (state is SearchLoadingState)
                  LinearProgressIndicator(
                    backgroundColor: Colors.white,
                    valueColor:
                        AlwaysStoppedAnimation<Color>(Color(0xFFFF7643)),
                  ),
                if (state is SearchSuccessState)
                  Expanded(
                    child: ListView.separated(
                      itemBuilder: (context, index) => buildListProduct(
                        SearchCubit.get(context).model!.data!.data![index],
                        context,
                      ),
                      separatorBuilder: (context, index) => SizedBox(
                        width: 5.0,
                      ),
                      itemCount:
                          SearchCubit.get(context).model!.data!.data!.length,
                    ),
                  )
              ],
            ),
          );
        },
      ),
    );
  }

  Widget buildListProduct(
    model,
    context,
  ) =>
      Padding(
        padding: const EdgeInsets.all(20.0),
        child: Card(
          clipBehavior: Clip.antiAliasWithSaveLayer,
          elevation: 5,
          color: Colors.white,
          child: Container(
            padding: const EdgeInsets.all(8.0),
            height: 120.0,
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(50)),
            child: Row(
              children: [
                Stack(
                  children: [
                    Image(
                      image: NetworkImage(model.image),
                      height: 100,
                      width: 100,
                    ),
                  ],
                ),
                SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        model.name,
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 14.0,
                          height: 1.3,
                        ),
                      ),
                      Spacer(),
                      Row(
                        children: [
                          Text.rich(
                            TextSpan(
                              style: TextStyle(
                                fontSize: getProportionateScreenWidth(12),
                                color: Colors.black,
                              ),
                              children: [
                                TextSpan(
                                  text: '${model.price}  ',
                                  style: TextStyle(
                                    fontSize: getProportionateScreenWidth(18),
                                    color: kPrimaryColor,
                                  ),
                                ),
                                TextSpan(text: 'EGP'),
                              ],
                            ),
                          ),
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
