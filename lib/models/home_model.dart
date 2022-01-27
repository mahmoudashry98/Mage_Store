class HomeModel
{
  bool? status;
  HomeDataModel ?data;

  HomeModel.fromJson(Map<String, dynamic> json)
  {
    status = json['status'];
    data = HomeDataModel.fromJson(json['data']);
  }
}


class HomeDataModel
{
  List<ProductModel> products = [];

  HomeDataModel.fromJson(Map<String, dynamic> json)
  {

    json['products'].forEach((element)
    {
      products.add(ProductModel.fromJson(element));
    });
  }
}

class ProductModel {
  int? id;
  dynamic? price;
  String? image;
  String? name;
  bool? inFavorites;
  bool? inCart;
  ProductModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    price = json['price'];
    image = json['image'];
    name = json['name'];
    inFavorites = json['in_favorites'];
    inCart = json['in_cart'];
  }
}
