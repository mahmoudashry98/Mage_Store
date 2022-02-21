import 'package:e_commerce_app/screens/settings/settings_screen.dart';
import 'package:e_commerce_app/shared/components/components.dart';
import 'package:e_commerce_app/shared/components/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';


class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Padding(
          padding: const EdgeInsets.only(left: 160),
          child: Text(
            'Profile',
            style: TextStyle(
              color: kTextColor,
              fontSize: 18,
            ),
          ),
        ),
      ),
      body:Column(
        children: [
          SizedBox(
            height: 115,
            width: 115,
            child: Stack(
              fit: StackFit.expand,
              overflow: Overflow.visible,
              children: [
                CircleAvatar(
                  backgroundImage: AssetImage('assets/images/Profile Image.png'),
                ),
                Positioned(
                  right: -10,
                  bottom: 0,
                  child: SizedBox(
                    height: 46,
                    width: 46,
                    child: FlatButton(
                      padding: EdgeInsets.zero,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50),
                        side: BorderSide(color: Colors.white)
                      ),
                      color: Color(0xFFF5F6F9),
                      onPressed: (){},
                      child: SvgPicture.asset('assets/icons/Camera Icon.svg'),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 20,),
          buildFlatBtu(
            text: "My Account",
            icon: 'assets/icons/User Icon.svg',
            press: (){},
            context: context,
          ),
          buildFlatBtu(
            text: "Notification",
            icon: 'assets/icons/Bell.svg',
            press: (){},
            context: context,
          ),
          buildFlatBtu(
            text: "Setting",
            icon: 'assets/icons/Settings.svg',
            press: (){
              navigateTo(context, SettingsScreen());
            },
            context: context,
          ),
          buildFlatBtu(
            text: "Help Center",
            icon: 'assets/icons/Question mark.svg',
            press: (){},
            context: context,
          ),
          buildFlatBtu(
            text: "LogOut",
            icon: 'assets/icons/Log out (1).svg',
            press: (){
              signOut(context);
            },
            context: context,
          ),

        ],
      ),
    );
  }

  Widget buildFlatBtu({
    required final String? text, icon,
    final VoidCallback? press,
    context,
})=>Padding(
    padding: const EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 10
    ),
    child: FlatButton(
      padding: EdgeInsets.all(20),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),),
      color: Color(0xFFF5F6F6),
      onPressed: press,
      child: Row(
        children: [
          SvgPicture.asset(
            icon,
            width: 22,
            color: kPrimaryColor,
          ),
          SizedBox(width: 20,),
          Expanded(
            child: Text(
              text!,
              style: Theme.of(context).textTheme.bodyText1,
            ),
          ),
          Icon(Icons.arrow_forward_ios)
        ],
      ),
    ),
  );
}
