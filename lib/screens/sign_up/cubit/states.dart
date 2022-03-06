import 'package:e_commerce_app/models/login_model.dart';

abstract class RegisterStates {}

class RegisterInitialState extends RegisterStates {}

//Register
class RegisterLoadingState extends RegisterStates {}
class RegisterSuccessState extends RegisterStates {

  final LoginModel loginModel;

  RegisterSuccessState(this.loginModel);
}
class RegisterErrorState extends RegisterStates {
  final String error;
  final LoginModel loginModel;
  RegisterErrorState(this.error,this.loginModel);
}

//ChangePasswordVisibility
class ChangePasswordVisibilityState extends RegisterStates {}


