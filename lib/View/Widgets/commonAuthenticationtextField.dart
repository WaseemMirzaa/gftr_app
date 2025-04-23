// ignore_for_file: must_be_immutable, non_constant_identifier_names

import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:gftr/Helper/appConfig.dart';
import 'package:gftr/Helper/colorConstants.dart';
import 'package:gftr/Helper/imageConstants.dart';
import 'package:gftr/View/Screens/LoginPage.dart';
import 'package:gftr/View/Widgets/customText.dart';
import 'package:gftr/View/Widgets/flutterToast.dart';

class CommonAuthTextField extends StatefulWidget {
  BuildContext context;
  TextEditingController controller;
  String hintText;
  String iconPath;
  FocusNode focusNode;
  CommonAuthTextField(
      {Key? key,
        required this.context,
        required this.controller,
        required this.hintText,
        required this.iconPath,
        required this.focusNode})
      : super(key: key);
  @override
  State<CommonAuthTextField> createState() => _CommonAuthTextFieldState();
}

class _CommonAuthTextFieldState extends State<CommonAuthTextField> {
  bool hidePassword = true;
  bool hideConfirmPassword = true;

  @override
  Widget build(BuildContext context) {
    return Container(
        alignment: Alignment.center,
        width: screenWidth(context),
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
            focusNode: widget.focusNode,
            obscureText: ((widget.hintText == "Password" && hidePassword) ||
                (widget.hintText == "Confirm Password" &&
                    hideConfirmPassword))
                ? true
                : false,
            textInputAction: TextInputAction.next,
            textAlignVertical: TextAlignVertical.center,
            style: TextStyle(
              fontSize: 14.0,
              fontFamily: poppins,
              fontWeight: FontWeight.w400,
              color: Colors.black,
            ),
            decoration: InputDecoration(
                isDense: true,
                contentPadding: const EdgeInsets.symmetric(vertical: 15),
                border: InputBorder.none,
                hintText: widget.hintText,
                hintStyle: TextStyle(
                  fontSize: 14.0,
                  fontFamily: poppins,
                  fontWeight: FontWeight.w400,
                  color: ColorCodes.greyText,
                ),
                prefixIcon: Container(
                    padding: EdgeInsets.all(screenWidth(context, dividedBy: 30)),
                    child: Image.asset(
                      widget.iconPath,
                      height: 10,
                      width: 10,
                      fit: BoxFit.contain,
                    )),
                suffixIcon: ((widget.hintText == "Password") ||
                    (widget.hintText == "Confirm Password"))
                    ? IconButton(
                    icon: (widget.hintText == "Confirm Password")
                        ? hideConfirmPassword
                        ? Container(
                      height:
                      screenHeight(context, dividedBy: 20),
                      width: screenWidth(context, dividedBy: 20),
                      child: Image(
                          image: AssetImage(
                              ImageConstants.visibility_off)),
                    )
                        : Container(
                      height:
                      screenHeight(context, dividedBy: 20),
                      width: screenWidth(context, dividedBy: 20),
                      child: Image(
                          image: AssetImage(
                              ImageConstants.visibility)),
                    )
                        : hidePassword
                        ? Container(
                      height:
                      screenHeight(context, dividedBy: 20),
                      width: screenWidth(context, dividedBy: 20),
                      child: Image(
                          image: AssetImage(
                              ImageConstants.visibility_off)),
                    )
                        : Container(
                      height:
                      screenHeight(context, dividedBy: 20),
                      width: screenWidth(context, dividedBy: 20),
                      child: Image(
                          image: AssetImage(
                              ImageConstants.visibility)),
                    ),
                    onPressed: () {
                      if (widget.hintText == "Confirm Password") {
                        hideConfirmPassword = !hideConfirmPassword;
                      } else {
                        hidePassword = !hidePassword;
                      }
                      setState(() {});
                    })
                    : null)));
  }
}

class SimpleAuthTextField extends StatefulWidget {
  BuildContext context;
  TextEditingController controller;
  String hintText;
  String iconPath;
  FocusNode focusNode;
  bool? numberKeyboard;

  SimpleAuthTextField(
      {Key? key,
        required this.context,
        required this.controller,
        required this.hintText,
        required this.iconPath,
        required this.focusNode,
        this.numberKeyboard = false})
      : super(key: key);
  @override
  State<SimpleAuthTextField> createState() => _SimpleAuthTextFieldState();
}

class _SimpleAuthTextFieldState extends State<SimpleAuthTextField> {
  bool hidePassword = true;
  bool hideConfirmPassword = true;
  @override
  Widget build(BuildContext context) {
    return Container(
        width: screenWidth(context),
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
        child: Container(
            alignment: Alignment.center,
            child: TextField(
                keyboardType: widget.numberKeyboard == true
                    ? TextInputType.number
                    : TextInputType.text,
                controller: widget.controller,
                focusNode: widget.focusNode,
                cursorColor: ColorCodes.greyText,
                textInputAction: TextInputAction.next,
                textAlignVertical: TextAlignVertical.center,
                style: TextStyle(
                  fontSize: 14.0,
                  fontFamily: poppins,
                  fontWeight: FontWeight.w400,
                  color: Colors.black,
                ),
                obscureText: ((widget.hintText == "Password" && hidePassword) ||
                    (widget.hintText == "Confirm Password" &&
                        hideConfirmPassword))
                    ? true
                    : false,
                decoration: InputDecoration(
                    isDense: true,
                    contentPadding: const EdgeInsets.symmetric(vertical: 15),
                    border: InputBorder.none,
                    hintText: widget.hintText,
                    hintStyle: TextStyle(
                      fontSize: 14.0,
                      fontFamily: poppins,
                      fontWeight: FontWeight.w400,
                      color: ColorCodes.greyText,
                    ),
                    prefixIcon: (widget.hintText == 'Phone Number')
                        ? GestureDetector(
                      onTap: () {
                        showCountryPicker(
                          context: context,
                          showPhoneCode: true,
                          onSelect: (Country country) {
                            print('Select country: ${country.phoneCode}');
                            countryCodeSelect = country.phoneCode;
                            flutterToast(
                                country.displayNameNoCountryCode, true);
                            setState(() {});
                          },
                        );
                      },
                      child: Container(
                        margin: EdgeInsets.only(right: 10),
                        alignment: Alignment.center,
                        width: screenWidth(context, dividedBy: 5),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(10),
                                bottomLeft: Radius.circular(10)),
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.grey.shade300, blurRadius: 1)
                            ]),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              SizedBox(
                                  width: screenWidth(context, dividedBy: 70)),
                              customText(
                                  "+$countryCodeSelect",
                                  ColorCodes.greyText,
                                  17,
                                  FontWeight.w100,
                                  poppins),
                              const Icon(
                                Icons.keyboard_arrow_down_rounded,
                                color: Colors.grey,
                                size: 20,
                              ),
                              SizedBox(
                                width: screenWidth(context, dividedBy: 70),
                              )
                            ]),
                      ),
                    )
                        : Container(
                        padding:
                        EdgeInsets.all(screenWidth(context, dividedBy: 27)),
                        height: screenHeight(context, dividedBy: 100),
                        child: Image.asset(
                          widget.iconPath,
                          width: 15,
                          height: 15,
                        )),
                    suffixIcon: ((widget.hintText == "Password") ||
                        (widget.hintText == "Confirm Password"))
                        ? IconButton(
                        icon: (widget.hintText == "Confirm Password")
                            ? hideConfirmPassword
                            ? Container(
                          height: screenHeight(context, dividedBy: 20),
                          width: screenWidth(context, dividedBy: 20),
                          child: Image(
                              image: AssetImage(
                                  ImageConstants.visibility_off)),
                        )
                            : Container(
                          height: screenHeight(context, dividedBy: 20),
                          width: screenWidth(context, dividedBy: 20),
                          child: Image(
                              image: AssetImage(
                                  ImageConstants.visibility)),
                        )
                            : hidePassword
                            ? Container(
                          height: screenHeight(context, dividedBy: 20),
                          width: screenWidth(context, dividedBy: 20),
                          child: Image(
                              image: AssetImage(
                                  ImageConstants.visibility_off)),
                        )
                            : Container(
                          height: screenHeight(context, dividedBy: 20),
                          width: screenWidth(context, dividedBy: 20),
                          child: Image(
                              image: AssetImage(
                                  ImageConstants.visibility)),
                        ),
                        onPressed: () {
                          if (widget.hintText == "Confirm Password") {
                            hideConfirmPassword = !hideConfirmPassword;
                          } else {
                            hidePassword = !hidePassword;
                          }
                          setState(() {});
                        })
                        : null))));
  }
}

Widget ContectAuthTextField(BuildContext context,
    TextEditingController controller, String hintText, FocusNode focusNode,
    {bool? numberKeybord = false}) {
  return Container(
      width: screenWidth(context),
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
      child: Padding(
          padding: EdgeInsets.only(left: screenWidth(context, dividedBy: 25)),
          child: TextField(
              controller: controller,
              focusNode: focusNode,
              keyboardType: numberKeybord == true
                  ? TextInputType.phone
                  : TextInputType.text,
              textInputAction: TextInputAction.next,
              textAlignVertical: TextAlignVertical.center,
              style: TextStyle(
                fontSize: 14.0,
                fontFamily: poppins,
                fontWeight: FontWeight.w400,
                color: Colors.black,
              ),
              decoration: InputDecoration(
                  isDense: true,
                  contentPadding: const EdgeInsets.symmetric(vertical: 15),
                  border: InputBorder.none,
                  hintText: hintText,
                  hintStyle: TextStyle(
                    fontSize: 14.0,
                    fontFamily: poppins,
                    fontWeight: FontWeight.w400,
                    color: ColorCodes.greyText,
                  )))));
}
