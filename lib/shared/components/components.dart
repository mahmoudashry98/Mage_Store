
import 'package:e_commerce_app/shared/size/size_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'constants.dart';

Widget defaultTextForm({
  required String labelText,
  required String hintText,
  TextInputType? keyboardType,
  FormFieldValidator<String>? validate,
  ValueChanged<String>? onSubmit,
  required TextEditingController controller,
  bool isPassword = false,
  IconData? suffix,
  VoidCallback? suffixPressed,

}){
  return  TextFormField(
    controller: controller,
    onFieldSubmitted: onSubmit,
    validator: validate,
    keyboardType: keyboardType,
    obscureText: isPassword,
    decoration: InputDecoration(
      suffixIcon: suffix != null
      ? IconButton(
      onPressed: suffixPressed,
      icon: Icon(
        suffix,
      ),
    )
        : null,
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


void showToast({
  required String text,
  required ToastStates state,
}) =>
    Fluttertoast.showToast(
      msg: text,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 5,
      backgroundColor: chooseToastColor(state),
      textColor: Colors.white,
      fontSize: 16.0,
    );

// enum
enum ToastStates { SUCCESS, ERROR, WARNING }

Color chooseToastColor(ToastStates state) {
  Color color;

  switch (state) {
    case ToastStates.SUCCESS:
      color = Colors.green;
      break;
    case ToastStates.ERROR:
      color = Colors.red;
      break;
    case ToastStates.WARNING:
      color = Colors.amber;
      break;
  }

  return color;
}

Widget buildIconBtnWithCounter ({
  required final String svgScr,
  required final int numItems,
})=> InkWell(
  onTap: () {},
  borderRadius: BorderRadius.circular(50),
  child: Stack(
    overflow: Overflow.visible,
    children: [
      Container(
        padding: EdgeInsets.all(
            getProportionateScreenWidth(12)),
        height: getProportionateScreenWidth(46),
        width: getProportionateScreenWidth(46),
        decoration: BoxDecoration(
            color: kSecondaryColor.withOpacity(0.1),
            shape: BoxShape.circle),
        child:
        SvgPicture.asset('$svgScr'),
      ),
      if(numItems != 0)
      Positioned(
        top: 0,
        right: 0,
        child: Container(
          height: getProportionateScreenWidth(16),
          width: getProportionateScreenWidth(16),
          decoration: BoxDecoration(
              color: Color(0xFFFF4848),
              shape: BoxShape.circle,
              border: Border.all(
                width: 1.5,
                color: Colors.white,
              )),
          child: Center(
            child: Text(
              '$numItems',
              style: TextStyle(
                  fontSize:
                  getProportionateScreenWidth(10),
                  height: 1,
                  color: Colors.white,
                  fontWeight: FontWeight.w600),
            ),
          ),
        ),
      ),
    ],
  ),
);
