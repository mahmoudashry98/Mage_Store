import 'package:e_commerce_app/layout/cubit/states.dart';
import 'package:e_commerce_app/models/cart_product_model.dart';
import 'package:e_commerce_app/models/change_carts_model.dart';
import 'package:e_commerce_app/models/change_favorite_model.dart';
import 'package:e_commerce_app/models/favorite_model.dart';
import 'package:e_commerce_app/models/home_model.dart';
import 'package:e_commerce_app/screens/categories/categories_screen.dart';
import 'package:e_commerce_app/screens/favorites/favorites_screen.dart';
import 'package:e_commerce_app/screens/product/products_screen.dart';
import 'package:e_commerce_app/screens/profile/profile_screen.dart';
import 'package:e_commerce_app/screens/settings/settings_screen.dart';
import 'package:e_commerce_app/shared/components/constants.dart';
import 'package:e_commerce_app/shared/network/end_points.dart';
import 'package:e_commerce_app/shared/network/remote/dio_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppCubit extends Cubit<AppStates> {
  AppCubit() : super(AppInitialState());
  static AppCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;

  List<Widget> bottomScreens = [
    ProductScreen(),
    FavoritesScreen(),
    ProfileScreen(),
  ];

  void changeBottomNav(int index) {
    // if (index==3) getUserData();
    //
    if (index==1) getFavorites();
    currentIndex = index;
    emit(AppChangeBottomNavState());
  }

  //Get HomeData
  HomeModel? homeModel;
  void getHomeData() {
    emit(AppLoadingHomeDataState());
    DioHelper.getData(
      url: HOME,
      token: token,
    ).then((value) {
      homeModel = HomeModel.fromJson(value.data);
      homeModel!.data!.products.forEach((element) {
        favorites.addAll({
          element.id!: element.inFavorites!,
        });
      });
      homeModel!.data!.products.forEach((element) {
        carts.addAll({
          element.id!: element.inCart!,
        });
      });
      print(favorites.toString());
      //printFullText(homeModel!.data!.products[2].image!);
      print(homeModel!.status);
      emit(AppSuccessHomeDataState());
    }).catchError((error) {
      print(error.toString());
      emit(AppErrorHomeDataState());
    });
  }

  //Get FavoritesData
  ChangeFavoritesModel? changeFavoritesModel;
  void changeFavorites(int productId) {
    favorites[productId] = !favorites[productId]!;
    emit(AppChangeFavoritesState());

    DioHelper.postData(
      url: FAVORITES,
      data: {
        'product_id': productId,
      },
      token: token,
    ).then((value) {
      changeFavoritesModel = ChangeFavoritesModel.fromJson(value.data);
      print(value.data);
      if (!changeFavoritesModel!.status!) {
        favorites[productId] = !favorites[productId]!;

      }else{
        getFavorites();
      }
      emit(AppSuccessChangeFavoritesState(changeFavoritesModel!));
    }).catchError((error) {
      favorites[productId] = !favorites[productId]!;

      emit(AppErrorChangeFavoritesState());
    });
  }
  FavoritesModel? favoritesModel;
  Map<int, bool> favorites = {};
  void getFavorites() {
    emit(AppLoadingGetFavoritesState());
    DioHelper.getData(
      url: FAVORITES,
      token: token,
    ).then((value) {
      favoritesModel = FavoritesModel.fromJson(value.data);
      printFullText(value.data.toString());

      emit(AppSuccessGetFavoritesState());
    }).catchError((error) {
      print(error.toString());
      emit(AppErrorGetFavoritesState());
    });
  }

  //GetCartsDate
  ChangeCartsModel? changeCartsModel;
  void changeCarts(int productId) {
    emit(AppChangeCartsLoadingState());
    DioHelper.postData(
      url: CARTS,
      data: {
        'product_id': productId,
      },
      token: token,
    ).then((value) {
      changeCartsModel = ChangeCartsModel.fromJson(value.data);
      print(value.data);
      if (!changeCartsModel!.status!) {
        carts[productId] = !carts[productId]!;

      }else{
        getCarts();
      }
      emit(AppSuccessChangeCartsState(changeCartsModel!));
    }).catchError((error) {
      carts[productId] = !carts[productId]!;
      emit(AppErrorChangeCartsState());
    });
  }
  CartsModel? cartsModel;
  Map<int, bool> carts = {};
  void getCarts() {
    emit(AppLoadingGetCartsState());
    DioHelper.getData(
      url: CARTS,
      token: token,
    ).then((value) {
      cartsModel = CartsModel.fromJson(value.data);
      printFullText(value.data.toString());
      print(value.data);
      print(',,,,,,,,,,,,,,,,,,,,,,,,,');
      print(carts.length);
      emit(AppSuccessGetCartsState());
    }).catchError((error) {
      print(error.toString());
      emit(AppErrorGetCartsState());
    });
  }

  // ShopLoginModel userModel;
  // void getUserData() {
  //   emit(ShopLoadingUserDataState());
  //
  //   DioHelper.getData(
  //     url: PROFILE,
  //     token: token,
  //   ).then((value) {
  //     userModel = ShopLoginModel.fromJson(value.data);
  //     printFullText(userModel.data.name);
  //
  //     emit(ShopSuccessUserDataState(userModel));
  //   }).catchError((error) {
  //     print(error.toString());
  //     emit(ShopErrorUserDataState());
  //   });
  // }

  // void updateUserData({
  //   String name,
  //   String email,
  //   String phone,
  // }) {
  //   emit(ShopLoadingUpdateUserState());
  //
  //   DioHelper.putData(url: UPDATE_PROFILE, token: token, data: {
  //     'name': name,
  //     'email': email,
  //     'phone': phone,
  //   }).then((value) {
  //     userModel = ShopLoginModel.fromJson(value.data);
  //     printFullText(userModel.data.name);
  //
  //     emit(ShopSuccessUpdateUserState(userModel));
  //   }).catchError((error) {
  //     print(error.toString());
  //     emit(ShopErrorUpdateUserState());
  //   });
  // }
}
