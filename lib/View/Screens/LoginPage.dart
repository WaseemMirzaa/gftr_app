import 'dart:developer';
import 'dart:async';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gftr/NotificationService/notification_service.dart';
import 'package:gftr/ViewModel/Cubits/Google_login.dart';
import 'package:gftr/ViewModel/Cubits/fcm_token_cubit.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gftr/Helper/apiConstants.dart';
import 'package:gftr/Helper/appConfig.dart';
import 'package:gftr/Helper/imageConstants.dart';
import 'package:gftr/View/Screens/allAbout.dart';
import 'package:gftr/View/Screens/forgetPassword.dart';
import 'package:gftr/View/Screens/signup.dart';
import 'package:gftr/View/Widgets/customLoader.dart';
import 'package:gftr/View/Widgets/flutterToast.dart';
import 'package:gftr/ViewModel/Cubits/signIn.dart';
import 'package:gftr/ViewModel/prefsService.dart';
import '../../Helper/colorConstants.dart';
import '../Widgets/commonAuthenticationtextField.dart';
import '../Widgets/customText.dart';

String countryCodeSelect = '1';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController phoneNumber = TextEditingController();
  TextEditingController password = TextEditingController();

  GoogleSignIn _googleSignIn = GoogleSignIn();
  SignInCubit signInCubit = SignInCubit();
  FcmTokenCubit fcmTokenCubit = FcmTokenCubit();
  FocusNode emailNode = FocusNode();
  FocusNode passwordNode = FocusNode();
  SharedPrefsService prefsService = SharedPrefsService();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  late final WebViewController _controller;
  final dio = Dio();
  String htmlpage = '';
  String? fcmToken;
  findingEmailsCubit _helloo = findingEmailsCubit();
  Future<UserCredential> signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;
    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    // Once signed in, return the UserCredential
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }

  Future<void> handleGoogleSignIn() async {
    try {
      final resuilt = await _googleSignIn.signIn();
      print("resuilt :${resuilt}");
      _helloo.Delete_frdss(
          context, resuilt?.email ?? '', resuilt?.displayName ?? '', '');
    } catch (error) {
      print(" error :$error");
    }
  }

  Future getGoogleAuth() async {
    // Decryption? response = await DioClient().decryptDataGetMethod("${ApiConstants.google_auth}");
    final response = await dio.post(
      '${ApiConstants.find_Email}',
    );
    print("response :$response");
    htmlpage = response.data;
    setState(() {});
  }

  readFcmToken() async {
    NotificationServices sp = NotificationServices();
    fcmToken = await sp.getToken();
    // fcmTokenCubit.getFcmToken();
    print("Token fetch Login $fcmToken");
  }

  @override
  void initState() {
    super.initState();
    signInCubit = BlocProvider.of<SignInCubit>(context);
    readFcmToken();
    //getGoogleAuth();
    // print(signInCubit);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
          key: _scaffoldKey,
          backgroundColor: Colors.white10,
          body: SizedBox(
              height: screenHeight(context),
              width: screenWidth(context),
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
                    ),
                  ],
                ),
                Container(
                    height: screenHeight(context, dividedBy: 1.25),
                    width: screenWidth(context),
                    margin: EdgeInsets.only(
                        top: screenHeight(context, dividedBy: 4.8)),
                    decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius:
                            BorderRadius.only(topLeft: Radius.circular(60))),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: screenHeight(context, dividedBy: 20),
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                              left: screenWidth(context, dividedBy: 8),
                            ),
                            child: customText("Login", Colors.black, 20,
                                FontWeight.w200, madeOuterSans),
                          ),
                          SizedBox(
                            height: screenHeight(context, dividedBy: 100),
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                              left: screenWidth(context, dividedBy: 8),
                            ),
                            child: customText(
                                "Please enter the details below to continue.",
                                ColorCodes.greyText,
                                12,
                                FontWeight.w400,
                                poppins),
                          ),
                          SizedBox(
                              height: screenHeight(context, dividedBy: 20)),
                          Expanded(
                            child: SingleChildScrollView(
                              physics: const BouncingScrollPhysics(),
                              child: Column(
                                children: [
                                  GestureDetector(
                                    child: Padding(
                                      padding: EdgeInsets.only(
                                        right:
                                            screenWidth(context, dividedBy: 10),
                                        left:
                                            screenWidth(context, dividedBy: 10),
                                      ),
                                      child: SimpleAuthTextField(
                                        context: context,
                                        controller: phoneNumber,
                                        hintText: "Phone Number",
                                        iconPath: ImageConstants.phoneWhite,
                                        focusNode: emailNode,
                                        numberKeyboard: true,
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(
                                      top: screenHeight(context, dividedBy: 50),
                                      right:
                                          screenWidth(context, dividedBy: 10),
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
                                  SizedBox(
                                    height:
                                        screenHeight(context, dividedBy: 100),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(
                                        right:
                                            screenWidth(context, dividedBy: 9),
                                        top: screenWidth(context,
                                            dividedBy: 90)),
                                    child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          GestureDetector(
                                            onTap: () {
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          const ForgetPassword()));
                                            },
                                            child: customText(
                                                "Forgot Password",
                                                ColorCodes.coral,
                                                12,
                                                FontWeight.w400,
                                                poppins),
                                          ),
                                        ]),
                                  ),
                                  SizedBox(
                                      height:
                                          screenHeight(context, dividedBy: 30)),
                                  Center(
                                      child: GestureDetector(
                                          onTap: () async {
                                            String pattern =
                                                r'(^(?:[+0]9)?[0-9]{10,12}$)';
                                            RegExp regExp = RegExp(pattern);

                                            if (phoneNumber.text.isEmpty) {
                                              flutterToast(
                                                  "Please enter Phone Number",
                                                  false);
                                            } else if (phoneNumber.text.length >
                                                13) {
                                              flutterToast(
                                                  "Please enter 10 Digit",
                                                  false);
                                            } else if (password.text.isEmpty) {
                                              flutterToast(
                                                  "Please enter password",
                                                  false);
                                            } else if (countryCodeSelect ==
                                                '') {
                                              flutterToast(
                                                  "Please Select Country Code",
                                                  false);
                                            } else if (!regExp
                                                .hasMatch(phoneNumber.text)) {
                                              flutterToast(
                                                  'Please enter valid mobile number',
                                                  false);
                                            } else {
                                              signInCubit.signInService(
                                                  phoneNumber.text,
                                                  password.text,
                                                  fcmToken ?? "No Token",
                                                  context);
                                            }

                                            log('CountryCode : $countryCodeSelect');
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
                                              child: BlocBuilder<SignInCubit,
                                                      SignInState>(
                                                  builder: (context, state) {
                                                if (state is SignInLoading) {
                                                  return spinkitLoader(
                                                      context, Colors.white);
                                                }
                                                return customText(
                                                    "Login",
                                                    Colors.white,
                                                    14,
                                                    FontWeight.w600,
                                                    poppins);
                                              })))),
                                  SizedBox(
                                      height:
                                          screenHeight(context, dividedBy: 20)),
                                  Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Container(
                                          width: screenWidth(context,
                                              dividedBy: 3.7),
                                          height: 1,
                                          color: Colors.grey[400],
                                        ),
                                        customText(' OR ', Colors.grey[400]!,
                                            13, FontWeight.bold, poppins),
                                        Container(
                                          width: screenWidth(context,
                                              dividedBy: 3.7),
                                          height: 1,
                                          color: Colors.grey[400],
                                        )
                                      ]),
                                  SizedBox(
                                      height:
                                          screenHeight(context, dividedBy: 40)),

                                  // Row(
                                  //   mainAxisAlignment: MainAxisAlignment.center,
                                  //   children: [
                                  //     GestureDetector(
                                  //       onTap: () {
                                  //         handleGoogleSignIn();
                                  //       },
                                  //       child: Container(
                                  //         height: screenHeight(context,
                                  //             dividedBy: 22),
                                  //         width: screenWidth(context,
                                  //             dividedBy: 1.6),
                                  //         decoration: BoxDecoration(
                                  //             color: Colors.white,
                                  //             borderRadius:
                                  //                 BorderRadius.circular(10),
                                  //             boxShadow: [
                                  //               BoxShadow(
                                  //                   offset:
                                  //                       const Offset(1.0, 1.0),
                                  //                   spreadRadius: 1,
                                  //                   color: Colors.grey.shade300,
                                  //                   blurRadius: 3)
                                  //             ]),
                                  //         child: Stack(children: [
                                  //           Padding(
                                  //             padding: EdgeInsets.only(
                                  //                 left: screenWidth(context,
                                  //                     dividedBy: 16)),
                                  //             child: Row(
                                  //               children: [
                                  //                 SizedBox(
                                  //                   height: screenHeight(
                                  //                       context,
                                  //                       dividedBy: 10),
                                  //                   width: screenWidth(context,
                                  //                       dividedBy: 17),
                                  //                   child: Image.asset(
                                  //                     ImageConstants
                                  //                         .googleColor,
                                  //                   ),
                                  //                 ),
                                  //                 Padding(
                                  //                   padding: EdgeInsets.only(
                                  //                       left: screenWidth(
                                  //                           context,
                                  //                           dividedBy: 23)),
                                  //                   child: customText(
                                  //                       'Login with Google',
                                  //                       ColorCodes.greyText,
                                  //                       14,
                                  //                       FontWeight.w100,
                                  //                       poppins),
                                  //                 )
                                  //               ],
                                  //             ),
                                  //           ),
                                  //         ]),
                                  //       ),
                                  //     ),
                                  //   ],
                                  // ),

                                  SizedBox(
                                      height:
                                          screenHeight(context, dividedBy: 30)),
                                  Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        customText(
                                            "Don't have an account?",
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
                                                          const SignUp()));
                                            },
                                            child: customText(
                                                ' Sign Up',
                                                Colors.black,
                                                14,
                                                FontWeight.w600,
                                                poppins))
                                      ]),
                                  SizedBox(
                                      height:
                                          screenHeight(context, dividedBy: 14)),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      customText('Click ', ColorCodes.greyText,
                                          14, FontWeight.w100, poppins),
                                      GestureDetector(
                                        onTap: () => Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    const AllAbout())),
                                        child: customText('here', Colors.black,
                                            14, FontWeight.bold, poppins),
                                      ),
                                      customText(
                                          ' to find out',
                                          ColorCodes.greyText,
                                          14,
                                          FontWeight.w100,
                                          poppins),
                                      customText(
                                          ' what we’re all about',
                                          ColorCodes.greyText,
                                          14,
                                          FontWeight.w100,
                                          poppins,
                                          fontStyle: FontStyle.italic),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          )
                        ]))
              ]))),
    );
  }
}
