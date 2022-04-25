import 'dart:io';

import 'package:e_commerce_app/layout/cubit/states.dart';
import 'package:e_commerce_app/models/address_model.dart';
import 'package:e_commerce_app/models/cart_product_model.dart';
import 'package:e_commerce_app/models/change_carts_model.dart';
import 'package:e_commerce_app/models/change_favorite_model.dart';
import 'package:e_commerce_app/models/favorite_model.dart';
import 'package:e_commerce_app/models/home_model.dart';
import 'package:e_commerce_app/models/login_model.dart';
import 'package:e_commerce_app/screens/favorites/favorites_screen.dart';
import 'package:e_commerce_app/screens/product/products_screen.dart';
import 'package:e_commerce_app/shared/components/constants.dart';
import 'package:e_commerce_app/shared/network/end_points.dart';
import 'package:e_commerce_app/shared/network/remote/dio_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

import '../../models/get_address_model.dart';
import '../../models/order_model.dart';
import '../../models/update_address_model.dart';
import '../../screens/setting/settings_screen.dart';
import '../../shared/network/local/cache_helper.dart';

class AppCubit extends Cubit<AppStates> {
  AppCubit() : super(AppInitialState());

  static AppCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;

  int newIndex = 0;

  List<Widget> bottomScreens = [
    ProductScreen(),
    FavoritesScreen(),
    ProfileScreen(),
  ];

  void onStepTapped(int index) {
    newIndex = index;
    emit(AppOnStepTappedSuccessState());
  }

  //OnStepContinue
  void onStepContinue() {
    if (newIndex != 2) {
      newIndex += 1;
      emit(AppAddStepSuccessState());
      print('add');
    }
  }

  //OnStepCancel
  void onStepCancel() {
    if (newIndex != 0) {
      newIndex -= 1;
      emit(AppMinusStepSuccessState());
      print('Minus');
    }
  }

  //Radio
  int currentValue = 1;

  void radio(var value) {
    currentValue = value;
    emit(AppRadioSuccessState());
    print('Select Done');
  }

  //BottomNav
  void changeBottomNav(int index) {
    if (index == 1) getFavorites();
    if (index == 2) getUserData();
    currentIndex = index;
    emit(AppChangeBottomNavState());
  }

  //GetImagePicker
  File? imageProfile;
  var picker = ImagePicker();

  Future<void> getProfileImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      imageProfile = File(pickedFile.path);
      emit(AppGetImagePickedSuccessState());
    } else {
      print('No image selected.');
      emit(AppGetImagePickedErrorState());
    }
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
      emit(AppSuccessHomeDataState(userModel!));
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
      //print(value.data);
      if (!changeFavoritesModel!.status!) {
        favorites[productId] = !favorites[productId]!;
      } else {
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
      // printFullText(value.data.toString());

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
      if (!changeCartsModel!.status!) {
        carts[productId] = !carts[productId]!;
      } else {
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
      emit(AppSuccessGetCartsState());
    }).catchError((error) {
      print(error.toString());
      emit(AppErrorGetCartsState());
    });
  }

  void updateCartData({
    required String id,
    int? quantity,
  }) {
    emit(AppLoadingUpdateCartDataState());
    DioHelper.putData(
      url: "${"carts/" + id}",
      data: {
        'quantity': quantity,
      },
      token: token,
    ).then((value) {
      getCarts();
    }).catchError((error) {
      print(error.toString());
      emit(AppErrorUpdateCartDataState());
    });
  }

  //PlusQuantityItem
  void plusQuantity(int index, model) {
    model.data!.cartItems![index].quantity++;
    emit(AppUpdateCartPlusQuantity());
  }

  //MinusQuantityItem
  void minusQuantity(int index, model) {
    model.data!.cartItems![index].quantity--;
    emit(AppUpdateCartMinusQuantity());
  }

  //GetUserData
  LoginModel? userModel;

  void getUserData() {
    emit(AppLoadingGetUserDataState());
    DioHelper.getData(
      url: PROFILE,
      token: token,
    ).then((value) {
      userModel = LoginModel.fromJson(value.data);
      emit(AppSuccessGetUserDataState(userModel!));
    }).catchError((error) {
      print(error.toString());
      emit(AppErrorGetUserDataState());
    });
  }
  AddressModel? addressModel;
  GetAddressModel? getAddressModel;
  void getUserAddress() {
    emit(AppLoadingGetUserDataAddressState());
    DioHelper.getData(
      url: ADDRESS,
      token: token,
    ).then((value) {
      getAddressModel = GetAddressModel.fromJson(value.data);
      emit(AppSuccessGetUserDataAddressState(getAddressModel!));
    }).catchError((error) {
      print(error.toString());
      emit(AppErrorGetUserDataAddressState());
    });
  }

  //UpdateUserData
  void updateUserData({
    required String? name,
    required String? email,
    required String? phone,
    //required Image? image,
  }) {
    emit(AppLoadingUpdateUserState());
    DioHelper.putData(
      url: UPDATE_PROFILE,
      token: token,
      data: {
        'name': name,
        'email': email,
        'phone': phone,
        // 'image': 'https://www.business2community.com/wp-content/uploads/2017/08/blank-profile-picture-973460_640.png',
      },
    ).then((value) {
      userModel = LoginModel.fromJson(value.data);
      // printFullText(userModel!.data!.name!);

      emit(AppSuccessUpdateUserState(userModel!));
    }).catchError((error) {
      print(error.toString());
      emit(AppErrorUpdateUserState());
    });
  }

  //AddAddressUser

  void addAddress({
    String name = 'Work',
    required String? city,
    required String? region,
    required String? details,
    required String? notes,
    String latitude = '30.0616863',
    String longitude = '31.3260088',
  }) {
    emit(AppLoadingUserAddressState());

    DioHelper.postData(
      url: ADDRESS,
      token: CacheHelper.getData(key: "token"),
      data: {
        'name': name,
        'city': city,
        'region': region,
        'details': details,
        'notes': notes,
        'latitude': latitude,
        'longitude': longitude,
      },
    ).then((value) {
      print(value.data);
      addressModel = AddressModel.fromJson(value.data);
      if(addressModel!.status!) getUserAddress();
      emit(AppSuccessUserAddressState(addressModel!));
    }).catchError((error) {
      print(error.toString());
      emit(AppErrorUserAddressState(error.toString()));
    });
  }
  //UpdateUserAddress
  UpdateAddressModel? updateAddressModel;
  void updateAddress({
    required addressId,
    String name = 'work',
    required String city,
    required String region,
    required String details,
    required String notes,
    double latitude = 30.0616863,
    double longitude = 31.3260088,
  }) {
    emit(AppLoadingUpdateUserAddressState());
    DioHelper.putData(
      url: 'addresses/$addressId',
      data: {
        'name': name,
        'city': city,
        'region': region,
        'details': details,
        'notes': notes,
        'latitude': latitude,
        'longitude': longitude,
      },
      token: token,
    ).then((value) {
      updateAddressModel = UpdateAddressModel.fromJson(value.data);
      if (updateAddressModel!.status!) getUserAddress();
      emit(AppSuccessUpdateUserAddressState(updateAddressModel!));
    }).catchError((error) {
      emit(AppErrorUpdateUserAddressState());
      print(error.toString());
    });
  }

  void addOrders({
    required addressId,
  }) {
    emit(AppLoadingAddOrdersState());
    DioHelper.postData(
      url: ORDERS,
      data: {
        'address_id': addressId,
        'payment_method': 1,
        'use_points': false,
      },
      token: token,
    ).then((value) {
      addressModel = AddressModel.fromJson(value.data);
      emit(AppSuccessAddOrdersState());
    }).catchError((error) {
      print(error.toString());
      emit(AppErrorAddOrdersState());
    });
  }

  GetOrdersModel? getOrdersModel;
  void getOrders() {
    DioHelper.getData(
      url: ORDERS,
      token: CacheHelper.getData(key: "token"),
    ).then((
        value,
        ) {
      getOrdersModel = GetOrdersModel.fromJson(value.data);
      print('ddd${getOrdersModel!.message}');
      emit(AppSuccessAddOrdersState());
    }).catchError((error) {
      print(error.toString());
      emit(AppErrorAddOrdersState());
    });
  }

  CancelOrderModel? cancelOrderModel;
  void cancelOrder({required int orderId}) {
    emit(AppLoadingCancelOrdersState());
    DioHelper.getData(
      url: "$ORDERS $orderId cancel ",
      token: CacheHelper.getData(key: "token"),
    ).then((
        value,
        ) {
      cancelOrderModel = CancelOrderModel.fromJson(value.data);
      emit(AppSuccessCancelOrdersState());
      getOrders();
    }).catchError((error) {
      print(error.toString());
      emit(AppErrorCancelOrdersState());
    });
  }
}
