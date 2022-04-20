import 'package:e_commerce_app/models/address_model.dart';
import 'package:e_commerce_app/models/change_carts_model.dart';
import 'package:e_commerce_app/models/change_favorite_model.dart';
import 'package:e_commerce_app/models/login_model.dart';

import '../../models/get_address_model.dart';
import '../../models/update_address_model.dart';

abstract class AppStates {}

class AppInitialState extends AppStates {}

//ChangeBottomNav
class AppChangeBottomNavState extends AppStates {}

//AddStep
class AppAddStepSuccessState extends AppStates{}

//MinusStep
class AppMinusStepSuccessState extends AppStates{}

//OnStepTapped
class AppOnStepTappedSuccessState extends AppStates{}

//Radio
class AppRadioSuccessState extends AppStates{}

//GetImage
class AppGetImagePickedSuccessState extends AppStates{}
class AppGetImagePickedErrorState extends AppStates{}

//HomeData
class AppLoadingHomeDataState extends AppStates{}
class AppSuccessHomeDataState extends AppStates{
  final LoginModel loginModel;

  AppSuccessHomeDataState(this.loginModel);
}
class AppErrorHomeDataState extends AppStates{}

//ChangeFavorites
class AppChangeFavoritesState extends AppStates{}
class AppSuccessChangeFavoritesState extends AppStates{
  final ChangeFavoritesModel model;
  AppSuccessChangeFavoritesState(this.model);
}
class AppErrorChangeFavoritesState extends AppStates{}

//ChangeCarts
class AppChangeCartsState extends AppStates{}
class AppChangeCartsLoadingState extends AppStates{}
class AppSuccessChangeCartsState extends AppStates{
  final ChangeCartsModel model;
  AppSuccessChangeCartsState(this.model);
}
class AppErrorChangeCartsState extends AppStates{}

//GetFavorites
class AppLoadingGetFavoritesState extends AppStates{}
class AppSuccessGetFavoritesState extends AppStates{}
class AppErrorGetFavoritesState extends AppStates{}

//GetCarts
class AppLoadingGetCartsState extends AppStates{}
class AppSuccessGetCartsState extends AppStates{}
class AppErrorGetCartsState extends AppStates{}

//PlusQuantity
class AppUpdateCartPlusQuantity extends AppStates{}

//MinusQuantity
class AppUpdateCartMinusQuantity extends AppStates{}

//GetUserData
class AppLoadingGetUserDataState extends AppStates{}
class AppSuccessGetUserDataState extends AppStates{
  final LoginModel loginModel;
  AppSuccessGetUserDataState(this.loginModel);

}
class AppErrorGetUserDataState extends AppStates{}

//UpdateUser
class AppLoadingUpdateUserState extends AppStates{}
class AppSuccessUpdateUserState extends AppStates{
  final LoginModel loginModel;

  AppSuccessUpdateUserState(this.loginModel);
}
class AppErrorUpdateUserState extends AppStates{}


//GetUserDataAddress
class AppLoadingGetUserDataAddressState extends AppStates{}
class AppSuccessGetUserDataAddressState extends AppStates{
  final GetAddressModel getAddressModel;

  AppSuccessGetUserDataAddressState(this.getAddressModel);
}
class AppErrorGetUserDataAddressState extends AppStates{}

//UpdateUserAddress
class AppLoadingUpdateUserAddressState extends AppStates{}
class AppSuccessUpdateUserAddressState extends AppStates{
  final  UpdateAddressModel updateAddressModel;

  AppSuccessUpdateUserAddressState(this.updateAddressModel);
}
class AppErrorUpdateUserAddressState extends AppStates{}

//UpdateCartData
class AppLoadingUpdateCartDataState extends AppStates{}
class AppErrorUpdateCartDataState extends AppStates{}

//UserAddress
class AppLoadingUserAddressState extends AppStates {}
class AppSuccessUserAddressState extends AppStates {

  final AddressModel addressModel;

  AppSuccessUserAddressState(this.addressModel);
}
class AppErrorUserAddressState extends AppStates {
  final String error;
  AppErrorUserAddressState(this.error);
}

//addOrders
class AppSuccessAddOrdersState extends AppStates {}
class AppErrorAddOrdersState extends AppStates {}

