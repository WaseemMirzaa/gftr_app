import 'package:flutter/material.dart';

Size screenSize(BuildContext context) {
  return MediaQuery.of(context).size;
}

double screenHeight(BuildContext context, {double dividedBy = 1.0}) {
  return screenSize(context).height / dividedBy;
}

double screenWidth(BuildContext context, {double dividedBy = 1.0}) {
  return screenSize(context).width / dividedBy;
}

Widget getCustomTextFild(
    {required String hintText,
    required TextEditingController controller,
    Widget? sufixIcon,
    Widget? pefixIcon,
    bool? numberKeybord = false,
    void Function(String)? onSubmitted,
    void Function()? onTap}) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 2),
    child: TextField(
      cursorColor: Colors.grey.shade600,
      controller: controller,
      onTap: onTap,
      onSubmitted: onSubmitted,
      maxLines: hintText == 'Price' ? 1 : null,
      // maxLength: hintText=='Price'?5: null,
      keyboardType:
          numberKeybord == true ? TextInputType.phone : TextInputType.text,
      decoration: InputDecoration(
          hintText: hintText,
          prefixIcon: pefixIcon,
          suffixIcon: sufixIcon,
          hintStyle: TextStyle(fontSize: 13, fontFamily: poppins),
          border: InputBorder.none),
    ),
  );
}

String madeOuterSans = "MADE Outer Sans";
String poppins = "Poppins";
String authorization = "";
String Selectbirtmsg = "1 Week out";
String Selecthollymsg = "1 Week out";
String text_or_msg = "";
String phoneNumberPre = "";
bool? only_or_any;
String User_id = "";
String emailPre = "";
String street = "";
String unit = "";
String contry = "";
String zipcode = "";
String state = "";
String city = "";
String birthDayPre = "";
String profileNamePre = "";
