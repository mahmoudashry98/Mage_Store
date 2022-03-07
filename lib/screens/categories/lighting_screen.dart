import 'package:e_commerce_app/shared/components/constants.dart';
import 'package:flutter/material.dart';

class LightingScreen extends StatelessWidget {
  const LightingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Padding(
          padding: const EdgeInsets.only(left: 95),
          child: Text(
            'Lighting',
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
              buildLightingItems(
                image:
                    'https://student.valuxapps.com/storage/uploads/products/1638738391RrZ5V.21.jpg',
                name: 'Xiaomi Mi Motion Activated Night Light 2 - White',
                price: 400,
                oldPrice: 400,
                discount: 0,
              ),
              buildLightingItems(
                image:
                    'https://student.valuxapps.com/storage/uploads/products/1638738160hkG50.1.jpg',
                name:
                    "M-33 Live Stream 360 Degree Rotated LED Ring Light 33 cm With Mobile Phone Holder And 2.1 Meter Stand - Black & White",
                price: 160.6,
                oldPrice: 160.6,
                discount: 0,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildLightingItems({
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
