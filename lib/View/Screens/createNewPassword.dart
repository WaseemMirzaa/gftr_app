import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gftr/Helper/appConfig.dart';
import 'package:gftr/Helper/colorConstants.dart';
import 'package:gftr/Helper/imageConstants.dart';
import 'package:gftr/View/Widgets/customLoader.dart';
import 'package:gftr/View/Widgets/customText.dart';
import 'package:gftr/View/Widgets/flutterToast.dart';
import 'package:gftr/ViewModel/Cubits/newPassword.dart';

import '../Widgets/newPasswordAuthenticationTetfield.dart';

// ignore: must_be_immutable
class NewPasswordPage extends StatefulWidget {
  String phoneNumber;
  NewPasswordPage({Key? key, required this.phoneNumber}) : super(key: key);
  @override
  State<NewPasswordPage> createState() => _NewPasswordPageState();
}

class _NewPasswordPageState extends State<NewPasswordPage> {
  TextEditingController passWord = TextEditingController();
  TextEditingController confirmPassWord = TextEditingController();
  NewPasswordCubit newPasswordCubit = NewPasswordCubit();

  @override
  void initState() {
    super.initState();
    newPasswordCubit = BlocProvider.of<NewPasswordCubit>(context);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(onTap: () =>  FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
          body: Container(
              height: screenHeight(context),
              width: screenWidth(context),
              color: Colors.teal,
              child: Stack(children: [
                Stack(
                  children: [
                    SizedBox(

                        child: Image.asset(
                          ImageConstants.gftrBack,
                          fit: BoxFit.cover,
                        )),
                    Container(
                      alignment: Alignment.center,
                      height: screenHeight(context, dividedBy: 3.9),
                      width: screenWidth(context),
                      child: Image.asset(
                        ImageConstants.gftrLogo,
                        height: screenHeight(context, dividedBy: 5),
                        width: screenWidth(context, dividedBy: 5),
                        fit: BoxFit.contain,
                      ),
                    ),//Gftr logo
                  ],
                ),
                Container(
                    height: screenHeight(context, dividedBy: 1.2),
                    width: screenWidth(context),
                    padding: EdgeInsets.only(
                        left: screenWidth(context, dividedBy: 12),
                        right: screenWidth(context, dividedBy: 12)),
                    margin: EdgeInsets.only(
                        top: screenHeight(context, dividedBy: 4.8)),
                    decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius:
                            BorderRadius.only(topLeft: Radius.circular(60))),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: screenHeight(context, dividedBy: 18)),
                          Padding(
                            padding: EdgeInsets.only(
                                left: screenWidth(context, dividedBy: 37)),
                            child: customText("Create New Password", Colors.black,
                                18, FontWeight.w300, madeOuterSans),
                          ),
                          SizedBox(height: screenHeight(context, dividedBy: 100)),
                          Padding(
                            padding: EdgeInsets.only(
                                left: screenWidth(context, dividedBy: 40)),
                            child: customText(
                                " Your new password cannot be the \n as a previous password.",
                                ColorCodes.greyText,
                                12,
                                FontWeight.w100,
                                poppins),
                          ),
                          SizedBox(height: screenHeight(context, dividedBy: 30)),
                          Expanded(
                            child: SingleChildScrollView(
                              physics: const BouncingScrollPhysics(),
                              child: Column(
                                children: [
                                  SizedBox(
                                      height:
                                          screenHeight(context, dividedBy: 40)),
                                  NewPasswordAuthTextField(
                                      context: context,
                                      controller: passWord,
                                      hintText: "Password",
                                      iconPath: ImageConstants.password),
                                  SizedBox(
                                      height:
                                          screenHeight(context, dividedBy: 40)),
                                  NewPasswordAuthTextField(
                                      context: context,
                                      controller: confirmPassWord,
                                      hintText: "Confirm Password",
                                      iconPath: ImageConstants.password),
                                  SizedBox(
                                      height:
                                          screenHeight(context, dividedBy: 3.4)),
                                  Padding(
                                      padding: EdgeInsets.only(
                                          left: screenWidth(context,
                                              dividedBy: 20)),
                                      child: GestureDetector(
                                          onTap: () {
                                            if (!newPasswordCubit
                                                .isButtonClicked) {
                                              if (passWord.text.isEmpty) {
                                                flutterToast(
                                                    "Please enter password",
                                                    false);
                                              } else if (confirmPassWord
                                                  .text.isEmpty) {
                                                flutterToast(
                                                    "Please enter Confirm Password",
                                                    false);
                                              } else if (passWord.text !=
                                                  confirmPassWord.text) {
                                                flutterToast(
                                                    "Password is not match",
                                                    false);
                                              } else {
                                                newPasswordCubit
                                                    .newPasswordService(context,
                                                        phoneNumber:
                                                            widget.phoneNumber,
                                                        password: passWord.text,
                                                        confirmPassword:
                                                            confirmPassWord.text);
                                              }
                                            }setState(() {

                                            });
                                          },
                                          child: Container(
                                              height: screenHeight(context,
                                                  dividedBy: 20),
                                              width: screenWidth(context,
                                                  dividedBy: 2.3),
                                              decoration: BoxDecoration(
                                                  color: ColorCodes.coral,
                                                  borderRadius:
                                                      BorderRadius.circular(100),
                                                boxShadow: [
                                                  BoxShadow(
                                                    color: Colors.grey,
                                                    blurRadius: 5.0,
                                                    // spreadRadius: 0.0,
                                                    offset: Offset(
                                                      1.0,
                                                      2.0,
                                                    ),
                                                  )
                                                ],
                                              ),
                                              child: Center(child: BlocBuilder<
                                                      NewPasswordCubit,
                                                      NewPasswordState>(
                                                  builder: (context, state) {
                                                if (state is NewPasswordLoading) {
                                                  return spinkitLoader(
                                                      context, Colors.white);
                                                }
                                                return customText(
                                                    "Save",
                                                    Colors.white,
                                                    16,
                                                    FontWeight.w600,
                                                    poppins);
                                              }))))),
                                ],
                              ),
                            ),
                          )
                        ]))
              ]))),
    );
  }
}
