// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:gftr/Helper/appConfig.dart';
import 'package:gftr/Helper/colorConstants.dart';
import 'package:gftr/Helper/imageConstants.dart';

class NewPasswordAuthTextField extends StatefulWidget {
  BuildContext context;
  TextEditingController controller;
  String hintText;
  String iconPath;
  NewPasswordAuthTextField(
      {Key? key,
      required this.context,
      required this.controller,
      required this.hintText,
      required this.iconPath})
      : super(key: key);
  @override
  State<NewPasswordAuthTextField> createState() =>
      _NewPasswordAuthTextFieldState();
}

class _NewPasswordAuthTextFieldState extends State<NewPasswordAuthTextField> {
  bool hidePassword = true;
  bool hideConfirmPassword = true;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
          left: screenWidth(context, dividedBy: 45),
          right: screenWidth(context, dividedBy: 40)),
      height: screenHeight(context, dividedBy: 18),
      width: screenWidth(context, dividedBy: 1.3),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
                offset: const Offset(1.0, 1.0),
                spreadRadius: 1,
                color: Colors.grey.shade300,
                blurRadius: 3)
          ]),
      child: TextField(
        controller: widget.controller,
        obscureText: ((widget.hintText == "Password" && hidePassword) ||
                (widget.hintText == "Confirm Password" && hideConfirmPassword))
            ? true
            : false,
        decoration: InputDecoration(
            border: InputBorder.none,
            hintText: widget.hintText,
            prefixIcon: Container(
              // width: screenHeight(context, dividedBy: 25),
              // height: screenHeight(context, dividedBy: 25),
              // color: Colors.teal,
              padding: EdgeInsets.all(screenHeight(context, dividedBy: 70)),
              child: Image.asset(ImageConstants.password),
            ),
            suffixIcon: IconButton(
                icon: (widget.hintText == "Confirm Password")
                    ? hideConfirmPassword
                        ? Container(
                            height: screenHeight(context, dividedBy: 20),
                            width: screenWidth(context, dividedBy: 20),
                            child: Image(
                                image:
                                    AssetImage(ImageConstants.visibility_off)),
                          )
                        : Container(
                            height: screenHeight(context, dividedBy: 20),
                            width: screenWidth(context, dividedBy: 20),
                            child: Image(
                                image: AssetImage(ImageConstants.visibility)),
                          )
                    : hidePassword
                        ? Container(
                            height: screenHeight(context, dividedBy: 20),
                            width: screenWidth(context, dividedBy: 20),
                            child: Image(
                                image:
                                    AssetImage(ImageConstants.visibility_off)),
                          )
                        : Container(
                            height: screenHeight(context, dividedBy: 20),
                            width: screenWidth(context, dividedBy: 20),
                            child: Image(
                                image: AssetImage(ImageConstants.visibility)),
                          ),
                onPressed: () {
                  if (widget.hintText == "Confirm Password") {
                    hideConfirmPassword = !hideConfirmPassword;
                  } else {
                    hidePassword = !hidePassword;
                  }
                  setState(() {});
                }),
            hintStyle: const TextStyle(color: ColorCodes.greyText)),
      ),
    );
  }
}
