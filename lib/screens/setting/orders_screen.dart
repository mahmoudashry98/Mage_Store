import 'package:e_commerce_app/shared/components/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../layout/cubit/cubit.dart';
import '../../layout/cubit/states.dart';
import '../../models/order_model.dart';

class OrdersScreen extends StatelessWidget {
  const OrdersScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              leading: Icon(
                Icons.shopping_cart_sharp,
                color: kPrimaryColor,
              ),
              title: Text("My Orders"),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text(
                    "Back",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: kPrimaryColor,
                    ),
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
              ],
              elevation: 2,
            ),
            body: Padding(
              padding: const EdgeInsets.all(20.0),
              child: ListView.separated(
                  itemBuilder: (context, index) => itemOrders(
                      AppCubit.get(context).getOrdersModel!, index, context),
                  separatorBuilder: (context, index) => SizedBox(
                        height: 10,
                      ),
                  itemCount:
                      AppCubit.get(context).getOrdersModel!.data!.data!.length),
            ),
          );
        });
  }

  Widget itemOrders(GetOrdersModel model, index, context) {
    return Card(
      clipBehavior: Clip.antiAliasWithSaveLayer,
      elevation: 10,
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  ' ID    :    ${model.data!.data![index].id}',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: textStyle,
                ),
                Spacer(),
                if (model.data!.data![index].status == "New")
                  Container(
                    height: 30,
                    width: 90,
                    decoration: BoxDecoration(
                      color: kPrimaryColor,
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    child: MaterialButton(
                        onPressed: () {
                          AppCubit.get(context).cancelOrder(
                              orderId: model.data!.data![index].id!);
                        },
                        child: Text(
                          "Cancel",
                          style: TextStyle(color: Colors.white, fontSize: 15),
                        )),
                  )
              ],
            ),
            Text(
              ' Total  :   ${model.data!.data![index].total}',
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: textStyle,
            ),
            const SizedBox(height: 10),
            Text(
              ' Date   :  ${model.data!.data![index].date}',
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: textStyle,
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              children: [
                Text("Status  : ", style: textStyle),
                Text(
                  " ${model.data!.data![index].status}",
                  style: textStyle.copyWith(
                      color: model.data!.data![index].status! == "New"
                          ? Colors.green
                          : Colors.red),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
