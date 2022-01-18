import 'package:e_commerce_app/layout/cubit/states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class AppCubit extends Cubit<AppStates> {
  AppCubit() : super(AppInitialState());

  static AppCubit get(context) => BlocProvider.of(context);


  int currentPage = 0;
  List<Map<String, String>> splashData = [
    {
      "text": "Welcome to MEGA STORE, Let's shop",
      "image": "assets/images/splash_1.png",
    },
    {
      "text": "We help people contact with store \naround Egypt ",
      "image": "assets/images/splash_2.png",
    },
    {
      "text": "We show the easy way to shop. \nJust stay at home with us",
      "image": "assets/images/splash_3.png",
    },
  ];
}
