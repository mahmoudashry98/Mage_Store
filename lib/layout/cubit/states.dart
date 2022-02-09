import 'package:e_commerce_app/models/change_favorite_model.dart';

abstract class AppStates {}

class AppInitialState extends AppStates {}

//ChangeBottomNav
class AppChangeBottomNavState extends AppStates {}

//HomeData
class AppLoadingHomeDataState extends AppStates{}
class AppSuccessHomeDataState extends AppStates{}
class AppErrorHomeDataState extends AppStates{}

//ChangeFavorites
class AppChangeFavoritesState extends AppStates{}
class AppSuccessChangeFavoritesState extends AppStates{
  final ChangeFavoritesModel model;
  AppSuccessChangeFavoritesState(this.model);
}
class AppErrorChangeFavoritesState extends AppStates{}

//GetFavorites
class AppLoadingGetFavoritesState extends AppStates{}
class AppSuccessGetFavoritesState extends AppStates{}
class AppErrorGetFavoritesState extends AppStates{}