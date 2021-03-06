import 'package:e_commerce_app/shared/components/constants.dart';
import 'package:flutter/material.dart';

class ElectronicsScreen extends StatelessWidget {
  const ElectronicsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(
        title: Padding(
          padding: const EdgeInsets.only(left: 95),
          child: Text(
            'Electronics',
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
              buildElectronicsItems(
                image: 'https://student.valuxapps.com/storage/uploads/products/1615440322npwmU.71DVgBTdyLL._SL1500_.jpg',
                name: 'Apple iPhone 12 Pro Max',
                price: 25000,
                oldPrice: 25000,
                discount: 0,
              ),
              buildElectronicsItems(
                image: 'https://student.valuxapps.com/storage/uploads/products/1615442168bVx52.item_XXL_36581132_143760083.jpeg',
                name: 'Apple MacBook Pro',
                price:  44500,
                oldPrice:  44500,
                discount: 0,
              ),
              buildElectronicsItems(
                image: 'https://student.valuxapps.com/storage/uploads/products/1615440689wYMHV.item_XXL_36330138_142814934.jpeg',
                name: 'JBL Xtreme 2 Portable Waterproof Bluetooth Speaker',
                price: 5599,
                oldPrice: 10230,
                discount: 1,
              ),
              buildElectronicsItems(
                image: 'https://student.valuxapps.com/storage/uploads/products/1615441020ydvqD.item_XXL_51889566_32a329591e022.jpeg',
                name: 'Samsung 65 Inch Smart TV 4K Ultra HD Curved',
                price: 11499,
                oldPrice: 12499,
                discount: 1,
              ),
              buildElectronicsItems(
                image: 'https://student.valuxapps.com/storage/uploads/products/1615450256e0bZk.item_XXL_7582156_7501823.jpeg',
                name: 'Nikon FX-format D750',
                price: 32860,
                oldPrice: 35000,
                discount: 1,
              ),
              buildElectronicsItems(
                image: 'https://student.valuxapps.com/storage/uploads/products/1615451352LMOAF.item_XXL_23705724_34135503.jpeg',
                name: 'Kingston A400 Internal SSD 2.5\" 240GB SATA 3',
                price: 530,
                oldPrice: 530,
                discount: 0,
              ),
              buildElectronicsItems(
                image: 'https://student.valuxapps.com/storage/uploads/products/1638734961565J3.11.jpg',
                name: 'Xiaomi Redmi 10 Dual SIM Mobile',
                price: 3075.2,
                oldPrice: 3075.2,
                discount: 0,
              ),
              buildElectronicsItems(
                image: 'https://student.valuxapps.com/storage/uploads/products/16387377980g2kx.11.jpg',
                name: 'Sony Pulse 3D Wireless Gaming Headset for PlayStation 5',
                price: 1596.9,
                oldPrice: 2659.05,
                discount: 1,
              ),
              buildElectronicsItems(
                image: 'https://student.valuxapps.com/storage/uploads/products/1638737964KFEyZ.21.jpg',
                name: 'Sony WI-C200 Wireless Headphones - Black',
                price: 499,
                oldPrice: 999,
                discount: 1,
              ),
              buildElectronicsItems(
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

  Widget buildElectronicsItems({
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
