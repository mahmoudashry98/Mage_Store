class HomeModel {
  bool? status;
  HomeDataModel? data;
  HomeModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = HomeDataModel.fromJson(json['data']);
  }
}

class HomeDataModel {
  List<ProductModel> products = [];
  HomeDataModel.fromJson(Map<String, dynamic> json) {
    json['products'].forEach((element) {
      products.add(ProductModel.fromJson(element));
    });
  }
}

class ProductModel {
  int? id;
  dynamic price;
  dynamic oldPrice;
  dynamic discount;
  String? image;
  List<String>? images;
  String? name;
  bool? inFavorites;
  bool? inCart;
  String? description;

  ProductModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    price = json['price'];
    oldPrice = json['old_price'];
    discount = json['discount'];
    image = json['image'];
    images = json['images'].cast<String>();
    name = json['name'];
    inFavorites = json['in_favorites'];
    inCart = json['in_cart'];
    description = json['description'];
  }
}
