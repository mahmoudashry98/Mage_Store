import 'package:e_commerce_app/shared/components/constants.dart';
import 'package:flutter/material.dart';

class SportsScreen extends StatelessWidget {
  const SportsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(
        title: Padding(
          padding: const EdgeInsets.only(left: 95),
          child: Text(
            'Sports',
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
              buildSportsItems(
                image: 'https://student.valuxapps.com/storage/uploads/products/161545152160GOl.item_XXL_39275650_152762070.jpeg',
                name: 'Stark Iron Kettlebell, 24 KG',
                price: 1083,
                oldPrice: 1083,
                discount: 0,
              ),
              buildSportsItems(
                image: 'https://student.valuxapps.com/storage/uploads/products/1638737571de5EF.21.jpg',
                name: "Nike Men's NSW Tee Icon Futura",
                price: 1085,
                oldPrice: 1085,
                discount: 0,
              ),
              buildSportsItems(
                image: 'https://student.valuxapps.com/storage/uploads/products/1638737146iLO2c.11.jpg',
                name: "Nike Flex Essential Mesh Training Shoes For Women - White",
                price: 1606.5,
                oldPrice: 1606.5,
                discount: 0,
              ),
              buildSportsItems(
                image: 'https://student.valuxapps.com/storage/uploads/products/16387377980g2kx.11.jpg',
                name: 'Sony Pulse 3D Wireless Gaming Headset for PlayStation 5',
                price: 1596.9,
                oldPrice: 2659.05,
                discount: 1,
              ),
              buildSportsItems(
                image: 'https://student.valuxapps.com/storage/uploads/products/1638737964KFEyZ.21.jpg',
                name: 'Sony WI-C200 Wireless Headphones - Black',
                price: 499,
                oldPrice: 999,
                discount: 1,
              ),
              buildSportsItems(
                image: 'https://student.valuxapps.com/storage/uploads/products/1638735246ToPmP.21.jpg',
                name: 'Xiaomi Mi Smart Band 5 - Black',
                price: 444,
                oldPrice: 656,
                discount: 1,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildSportsItems({
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
