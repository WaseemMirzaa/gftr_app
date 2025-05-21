import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gftr/Helper/appConfig.dart';
import 'package:gftr/Helper/colorConstants.dart';
import 'package:gftr/Helper/imageConstants.dart';
import 'package:gftr/View/Screens/LoginPage.dart';
import 'package:gftr/View/Screens/verfiyEmail.dart';
import 'package:gftr/View/Widgets/commonAuthenticationtextField.dart';
import 'package:gftr/View/Widgets/customLoader.dart';
import 'package:gftr/View/Widgets/customText.dart';
import 'package:gftr/View/Widgets/flutterToast.dart';
import 'package:gftr/ViewModel/Cubits/fcm_token_cubit.dart';
import 'package:gftr/ViewModel/Cubits/signUp.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  TextEditingController firstName = TextEditingController();
  TextEditingController lastName = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController confirmPassword = TextEditingController();
  String? fcmToken;
  Widget spaceBetweenFields() {
    return SizedBox(height: screenHeight(context, dividedBy: 60));
  }

  SignUpCubit signUpCubit = SignUpCubit();
  FcmTokenCubit fcmTokenCubit = FcmTokenCubit();
  FocusNode firstNameNode = FocusNode();
  FocusNode lastNameNode = FocusNode();
  FocusNode phoneNode = FocusNode();
  FocusNode emailNode = FocusNode();
  FocusNode passwordNode = FocusNode();
  FocusNode confirmPasswordNode = FocusNode();

  @override
  void initState() {
    super.initState();
    signUpCubit = BlocProvider.of<SignUpCubit>(context);
    loadFcmToken();
  }


  loadFcmToken()async{
    fcmToken = fcmTokenCubit.getFcmToken();
  }

  @override
  Widget build(BuildContext context) {
  
      fcmToken = fcmTokenCubit.getFcmToken();


    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        backgroundColor: Colors.white10,
        body: SizedBox(
          height: screenHeight(context),
          width: screenWidth(context),
          child: Stack(
            children: [
              Stack(
                children: [
                  SizedBox(
                      width: screenWidth(context),
                      child: Image.asset(
                        ImageConstants.gftrBack,
                        fit: BoxFit.cover,
                      )), //gftr background image
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
                  ),
                ],
              ),
              Container(
                height: screenHeight(context, dividedBy: 1.2),
                width: screenWidth(context),
                margin:
                    EdgeInsets.only(top: screenHeight(context, dividedBy: 4.9)),
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
                          left: screenWidth(context, dividedBy: 8)),
                      child: customText("Sign Up", Colors.black, 20,
                          FontWeight.w200, madeOuterSans),
                    ),
                    SizedBox(height: screenHeight(context, dividedBy: 100)),
                    Padding(
                      padding: EdgeInsets.only(
                          left: screenWidth(context, dividedBy: 8)),
                      child: customText(
                          "Please enter the details below to continue.",
                          ColorCodes.greyText,
                          12,
                          FontWeight.w400,
                          poppins),
                    ),
                    SizedBox(
                      height: screenHeight(context, dividedBy: 90),
                    ),
                    Expanded(
                      child: SingleChildScrollView(
                        physics: const BouncingScrollPhysics(),
                        child: Column(
                          children: [
                            Padding(
                              padding: EdgeInsets.only(
                                top: screenHeight(context, dividedBy: 80),
                                right: screenWidth(context, dividedBy: 10),
                                left: screenWidth(context, dividedBy: 10),
                              ),
                              child: SimpleAuthTextField(
                                context: context,
                                controller: firstName,
                                hintText: "First Name",
                                iconPath: ImageConstants.user,
                                focusNode: firstNameNode,
                              ),
                            ),
                            spaceBetweenFields(),
                            Padding(
                              padding: EdgeInsets.only(
                                // top: screenHeight(context, dividedBy: 90),
                                right: screenWidth(context, dividedBy: 10),
                                left: screenWidth(context, dividedBy: 10),
                              ),
                              child: SimpleAuthTextField(
                                context: context,
                                controller: lastName,
                                hintText: "Last Name",
                                iconPath: ImageConstants.user,
                                focusNode: lastNameNode,
                              ),
                            ),
                            spaceBetweenFields(),
                            Padding(
                              padding: EdgeInsets.only(
                                right: screenWidth(context, dividedBy: 10),
                                left: screenWidth(context, dividedBy: 10),
                              ),
                              child: SimpleAuthTextField(
                                context: context,
                                controller: phone,
                                hintText: "Phone Number",
                                iconPath: ImageConstants.phoneWhite,
                                focusNode: phoneNode,
                                numberKeyboard: true,
                              ),
                            ),
                            spaceBetweenFields(),
                            Padding(
                              padding: EdgeInsets.only(
                                // top: screenHeight(context, dividedBy: 90),
                                right: screenWidth(context, dividedBy: 10),
                                left: screenWidth(context, dividedBy: 10),
                              ),
                              child: SimpleAuthTextField(
                                  context: context,
                                  controller: email,
                                  hintText: "E-mail",
                                  iconPath: ImageConstants.email,
                                  focusNode: emailNode),
                            ),
                            spaceBetweenFields(),
                            Padding(
                              padding: EdgeInsets.only(
                                // top: screenHeight(context, dividedBy: 90),
                                right: screenWidth(context, dividedBy: 10),
                                left: screenWidth(context, dividedBy: 10),
                              ),
                              child: SimpleAuthTextField(
                                context: context,
                                controller: password,
                                hintText: "Password",
                                iconPath: ImageConstants.password,
                                focusNode: passwordNode,
                              ),
                            ),
                            spaceBetweenFields(),
                            Padding(
                              padding: EdgeInsets.only(
                                // top: screenHeight(context, dividedBy: 90),
                                right: screenWidth(context, dividedBy: 10),
                                left: screenWidth(context, dividedBy: 10),
                              ),
                              child: SimpleAuthTextField(
                                context: context,
                                controller: confirmPassword,
                                hintText: "Confirm Password",
                                iconPath: ImageConstants.password,
                                focusNode: confirmPasswordNode,
                              ),
                            ),
                            SizedBox(
                                height: screenHeight(context, dividedBy: 25)),
                            Center(
                                child: GestureDetector(
                                    onTap: () async {
                                      String pattern =
                                          r'(^(?:[+0]9)?[0-9]{10,12}$)';
                                      RegExp regExp = RegExp(pattern);
                                      String _pattern1 =
                                          r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
                                      RegExp _regExp1 = RegExp(_pattern1);
                                      if (firstName.text.isEmpty) {
                                        flutterToast(
                                            "Please enter first name", false);
                                      } else if (lastName.text.isEmpty) {
                                        flutterToast(
                                            "Please enter last name", false);
                                      } else if (phone.text.isEmpty) {
                                        flutterToast(
                                            "Please enter Phone Number", false);
                                      } else if (email.text.isEmpty) {
                                        flutterToast(
                                            "Please enter email", false);
                                      } else if (!_regExp1
                                          .hasMatch(email.text)) {
                                        flutterToast(
                                            'Please enter valid Email', false);
                                      } else if (password.text.isEmpty) {
                                        flutterToast(
                                            "Please enter password", false);
                                      } else if (confirmPassword.text.isEmpty) {
                                        flutterToast(
                                            "Please enter confirm password",
                                            false);
                                      } else if (password.text !=
                                          confirmPassword.text) {
                                        flutterToast(
                                            "password not match", false);
                                      } else if (countryCodeSelect == '') {
                                        flutterToast(
                                            "Please Select Country Code",
                                            false);
                                      } else if (!regExp.hasMatch(phone.text)) {
                                        flutterToast(
                                            'Please enter valid mobile number',
                                            false);
                                      } else {
                                        signUpCubit.signUpService(
                                            email: email.text,
                                            firstname: firstName.text,
                                            lastname: lastName.text,
                                            phoneNumber: phone.text,
                                            password: password.text,
                                            confirmPassword:
                                                confirmPassword.text,
                                                fcmToken: fcmToken ?? "No Token",
                                            context: context);
                                      }
                                      setState(() {});
                                    },
                                    child: Container(
                                        alignment: Alignment.center,
                                        height: screenHeight(context,
                                            dividedBy: 18),
                                        width: screenWidth(context,
                                            dividedBy: 2.4),
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
                                        child: BlocBuilder<SignUpCubit,
                                                SignUpState>(
                                            builder: (context, state) {
                                          if (state is SignUpLoading) {
                                            return spinkitLoader(
                                                context, Colors.white);
                                          }
                                          return customText(
                                              "Sign Up",
                                              Colors.white,
                                              15,
                                              FontWeight.w600,
                                              poppins);
                                        })))),
                            SizedBox(
                                height: screenHeight(context, dividedBy: 25)),
                            Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  customText(
                                      "Already have an accounts? ",
                                      ColorCodes.greyText,
                                      14,
                                      FontWeight.w100,
                                      poppins),
                                  GestureDetector(
                                      onTap: () {
                                        Navigator.pushReplacement(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  const LoginPage()),
                                        );
                                      },
                                      child: customText('Log In', Colors.black,
                                          14, FontWeight.w600, poppins))
                                ]),
                            SizedBox(
                                height: screenHeight(context, dividedBy: 20)),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ), //Full screen Container
      ),
    );
  }
}
