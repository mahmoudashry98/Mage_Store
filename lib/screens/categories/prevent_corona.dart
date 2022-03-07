import 'package:e_commerce_app/shared/components/constants.dart';
import 'package:flutter/material.dart';

class PreventCoronaScreen extends StatelessWidget {
  const PreventCoronaScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Padding(
          padding: const EdgeInsets.only(left: 85),
          child: Text(
            'PreventCorona',
            style: TextStyle(
              color: kTextColor,
              fontSize: 18,
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          color: Colors.grey[300],
          child: GridView.count(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            crossAxisCount: 2,
            mainAxisSpacing: 1.0,
            crossAxisSpacing: 1.0,
            childAspectRatio: 1 / 1.4,
            children: [
              buildPreventCoronaItems(
                image:
                'https://student.valuxapps.com/storage/uploads/products/1638734223uyATp.1.jpg',
                name: 'Face Protection Mask, 50 Count - Light Blue with Elastic and Braces',
                price: 45,
                oldPrice: 45,
                discount: 0,
              ),
              buildPreventCoronaItems(
                image:
                'https://student.valuxapps.com/storage/uploads/products/1638734575kfKn8.21.jpg',
                name:
                "Evony Surgical Mask with Soft Elastic Ears, 50 Pieces",
                price:  50.25,
                oldPrice: 70,
                discount: 1,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildPreventCoronaItems({
    required final String image,
    required final String name,
    required final double price,
    required final double oldPrice,
    required final int discount,
  }) =>
      Container(
        color: Colors.white,
        child: Column(
          children: [
            Stack(
              alignment: AlignmentDirectional.bottomStart,
              children: [
                Image(
                  image: NetworkImage(
                    image,
                  ),
                  width: 200,
                  height: 200,
                ),
                if (discount != 0)
                  Container(
                    color: Colors.red,
                    padding: EdgeInsets.symmetric(
                      horizontal: 5.0,
                    ),
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
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    // model.name!,
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
                        '${price.round()}',
                        // '${model.price.round()}',
                        style: TextStyle(
                          fontSize: 12.0,
                          color: kPrimaryColor,
                        ),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      if (discount != 0)
                        Text(
                          '${oldPrice.round()}',
                          // '${model.oldPrice.round()}',
                          style: TextStyle(
                            fontSize: 10.0,
                            color: Colors.grey,
                            decoration: TextDecoration.lineThrough,
                          ),
                        ),
                      // Expanded(
                      //   child: IconButton(
                      //       icon: ShopCubit.get(context).favorites[model.id]!
                      //           ? Icon(
                      //         Icons.favorite,
                      //         size: 17.0,
                      //         color: Colors.red,
                      //       )
                      //           : Icon(
                      //         Icons.favorite_border,
                      //         size: 17.0,
                      //         // color: Colors.white,
                      //       ),
                      //       onPressed: () {
                      //         ShopCubit.get(context).changeFavorites(model.id!);
                      //         print(model.id);
                      //       }),
                      // )
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      );
}
