import 'package:e_commerce_app/screens/splash/splash_screen.dart';
import 'package:e_commerce_app/shared/routs/routs.dart';
import 'package:e_commerce_app/shared/styles/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'layout/cubit/cubit.dart';
import 'layout/cubit/states.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => AppCubit(),
      child: BlocConsumer<AppCubit, AppStates>(
        listener: (context, state) { },
        builder: (context, state) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme:themeDate(),
            // home: SplashScreen(),
            initialRoute: SplashScreen.routeName,
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
