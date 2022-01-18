
import 'package:e_commerce_app/shared/size/size_config.dart';
import 'package:flutter/material.dart';

import 'constants.dart';

Widget defaultTextForm({
  required String labelText,
  required String hintText,
  required IconData suffixIcon,
  TextInputType? keyboardType,
  bool? obscureText,
  FormFieldValidator<String>? validate,
  ValueChanged<String>? onSubmit,

}){
  return  TextFormField(
    onFieldSubmitted: onSubmit,
    validator: validate,
    keyboardType: TextInputType.emailAddress,
    obscureText: true,
    decoration: InputDecoration(
      suffixIcon: Icon(
        suffixIcon,
      ),
      labelText: labelText,
      hintText: hintText,
      floatingLabelBehavior: FloatingLabelBehavior.always,
      contentPadding: EdgeInsets.symmetric(
          horizontal: 42,
          vertical: 20
      ),
      enabledBorder: OutlineInputBorder(
          borderRadius:BorderRadius.circular(28),
          borderSide: BorderSide(color: kTextColor),
          gapPadding: 10
      ),
      focusedBorder: OutlineInputBorder(
          borderRadius:BorderRadius.circular(28),
          borderSide: BorderSide(color: kTextColor),
          gapPadding: 10
      ),
    ),
  );
}

Widget defaultFloatButton({
  required String text,
  context,
  required Function function,

}){
  return FlatButton(
    shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20)),
    color: kPrimaryColor,
    onPressed: (){
      function();
    },
    child: Text(
      text,
      style: TextStyle(
        fontSize: getProportionateScreenWidth(18),
        color: Colors.white,
      ),
    ),
  );
}