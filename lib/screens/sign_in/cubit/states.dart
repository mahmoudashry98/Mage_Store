import 'package:e_commerce_app/models/login_model.dart';

abstract class LoginStates {}

class LoginInitialState extends LoginStates {}

//Login
class LoginLoadingState extends LoginStates {}
class LoginSuccessState extends LoginStates {

 final LoginModel loginModel;

 LoginSuccessState(this.loginModel);
}
class LoginErrorState extends LoginStates {
  final String error;

  LoginErrorState(this.error);
}

//ChangePasswordVisibility
class ChangePasswordVisibilityState extends LoginStates {}

//checkBox
class AppCheckBoxState extends LoginStates {}