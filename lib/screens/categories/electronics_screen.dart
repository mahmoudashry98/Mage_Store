import 'package:e_commerce_app/layout/cubit/cubit.dart';
import 'package:e_commerce_app/models/change_favorite_model.dart';
import 'package:e_commerce_app/models/home_model.dart';
import 'package:e_commerce_app/shared/components/constants.dart';
import 'package:flutter/material.dart';


class ElectronicsScreen extends StatelessWidget {
  const ElectronicsScreen({Key? key}) : super(key: key);

  final int index = 52;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Padding(
          padding: const EdgeInsets.only(left: 90),
          child: Text(
            'Electronics',
            style: TextStyle(
              color: kTextColor,
              fontSize: 20,
            ),
          ),
        ),
      ),
      body: Column(
        children: [
          buildGridProduct(
            AppCubit.get(context).homeModel!.data!.products[index],
            context,
          )
        ],
      ),
    );
  }


  Widget buildGridProduct(ProductModel model, context) => Container(
    color: Colors.white,
    child: Column(
      children: [
        Text('${model.id}'),
        Text('data'),
      ],
    )
  );
}
