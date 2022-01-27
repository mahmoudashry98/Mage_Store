import 'package:e_commerce_app/screens/on_boarding/boarding_screen.dart';
import 'package:e_commerce_app/screens/sign_in/sign_in_screen.dart';
import 'package:e_commerce_app/shared/components/constants.dart';
import 'package:e_commerce_app/shared/network/local/cache_helper.dart';
import 'package:e_commerce_app/shared/size/size_config.dart';
import 'package:e_commerce_app/shared/styles/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'layout/cubit/cubit.dart';
import 'layout/cubit/states.dart';
import 'layout/home_layout.dart';
import 'shared/bloc_observer.dart';
import 'shared/network/remote/dio_helper.dart';
import 'shared/routes/routes.dart';

void main(context) async {
  // بيتأكد ان كل حاجه هنا في الميثود خلصت و بعدين يتفح الابلكيشن
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  DioHelper.init();
  await CacheHelper.init();
  bool? onBoarding = CacheHelper.getData(key: 'onBoarding');
  token = CacheHelper.getData(key: 'token');
  Widget? widget;
  if (onBoarding != null) {
    if (token != null)
      widget = HomeLayout();
    else
      widget = SignInScreen();
  } else {
    widget = OnBoardingScreen();
  }
  runApp(MyApp(
    startWidget: widget,
  ));
}

class MyApp extends StatelessWidget {
  final Widget? startWidget;
  MyApp({
    this.startWidget,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => AppCubit()..getHomeData(),
      child: BlocConsumer<AppCubit, AppStates>(
        listener: (context, state) {},
        builder: (context, state) {
          //bool ?onBoarding = CacheHelper.getData(key: 'onBoarding');
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: themeDate(),
            home: startWidget,
            // initialRoute: onBoarding! ? SignInScreen.routeName : OnBoardingScreen.routeName,
            routes: routes,
          );
        },
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}
