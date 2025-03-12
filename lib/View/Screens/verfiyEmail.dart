import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gftr/Helper/appConfig.dart';
import 'package:gftr/View/Screens/welcome.dart';
import 'package:gftr/View/Widgets/customLoader.dart';
import 'package:gftr/View/Widgets/flutterToast.dart';
import 'package:gftr/ViewModel/Cubits/resend_cubit.dart';
import 'package:gftr/ViewModel/Cubits/signUp.dart';
import 'package:gftr/ViewModel/Cubits/verifyforgott.dart';
import 'package:pinput/pinput.dart';
import '../../Helper/colorConstants.dart';
import '../../Helper/imageConstants.dart';
import '../../ViewModel/Cubits/verifyOtp.dart';
import '../Widgets/customText.dart';

// ignore: must_be_immutable
class VerifyPhone extends StatefulWidget {
  String phoneNumber;
  int screenIndex;
  VerifyPhone({
    Key? key,
    required this.phoneNumber,
    required this.screenIndex,
  }) : super(key: key);

  @override
  State<VerifyPhone> createState() => _VerifyPhoneState();
}

class _VerifyPhoneState extends State<VerifyPhone> {
  final pinController = TextEditingController();
  SignUpCubit signUpCubit = SignUpCubit();
  VerifyOtpCubit verifyOtpCubit = VerifyOtpCubit();
  VerifyForgotOtpCubit verifyForgotOtpCubit = VerifyForgotOtpCubit();
  ResendOtpCubit resendOtpCubit = ResendOtpCubit();
  @override
  void initState() {
    super.initState();
    verifyOtpCubit = BlocProvider.of<VerifyOtpCubit>(context);
    verifyForgotOtpCubit = BlocProvider.of<VerifyForgotOtpCubit>(context);
    signUpCubit = BlocProvider.of<SignUpCubit>(context);
  }

  @override
  Widget build(BuildContext context) {
    final defaultPinTheme = PinTheme(
      width: screenWidth(context, dividedBy: 7),
      height: screenHeight(context, dividedBy: 15),
      textStyle: const TextStyle(
          fontSize: 20, color: Colors.grey, fontWeight: FontWeight.w600),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
                offset: const Offset(1.0, 2.0),
                color: Colors.grey.shade300,
                blurRadius: 4)
          ]),
    );
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
          backgroundColor: Colors.white10,
          body: SizedBox(
              height: screenHeight(context),
              width: screenWidth(context),
              child: Stack(children: [
                SizedBox(
                    height: screenHeight(context, dividedBy: 3.2),
                    width: screenWidth(context),
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
                Positioned(
                  top: screenHeight(context,dividedBy: 10),
                  child:
                  IconButton(onPressed: () {
                    Navigator.pop(context);
                  }, icon: Icon(Icons.arrow_back_ios_new,color: Colors.white,)),
                ),
                Container(
                    height: screenHeight(context, dividedBy: 1.2),
                    width: screenWidth(context),
                    margin: EdgeInsets.only(
                        top: screenHeight(context, dividedBy: 4.5)),
                    decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius:
                            BorderRadius.only(topLeft: Radius.circular(60))),
                    child: Column(children: [
                      Padding(
                        padding: EdgeInsets.only(
                            right: screenWidth(context, dividedBy: 20),
                            top: screenHeight(context, dividedBy: 20)),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            customText("Verify Your Cell Number", Colors.black,
                                18, FontWeight.w300, madeOuterSans),
                            SizedBox(
                              height: screenHeight(context, dividedBy: 80),
                            ),
                            customText(
                                "Please enter the code we send to your phone.",
                                ColorCodes.greyText,
                                12,
                                FontWeight.w100,
                                poppins),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: screenHeight(context, dividedBy: 15),
                      ),
                      Expanded(
                        child: SingleChildScrollView(
                          physics: const BouncingScrollPhysics(),
                          child: Column(
                            children: [
                              Container(
                                  padding: EdgeInsets.symmetric(
                                      horizontal:
                                          screenWidth(context, dividedBy: 10)),
                                  width: screenWidth(context, dividedBy: 1.1),
                                  color: Colors.white,
                                  child: Pinput(
                                    length: 6,
                                    controller: pinController,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    defaultPinTheme: defaultPinTheme,
                                    showCursor: true,
                                    onCompleted: (pin) => log(pin),
                                  )),
                              SizedBox(
                                  height: screenHeight(context, dividedBy: 50)),
                              GestureDetector(
                                onTap: () {
                                  log(widget.phoneNumber);
                                  log(widget.screenIndex.toString());
                                  resendOtpCubit.resendOtpService(
                                      widget.phoneNumber, context);
                                },
                                child: SizedBox(
                                    width:
                                        screenWidth(context, dividedBy: 1.43),
                                    child: BlocBuilder<ResendOtpCubit,
                                            ResendOtpState>(
                                        builder: (context, state) {
                                      if (state is ResendOtpLoading) {
                                        return spinkitLoader(
                                            context, ColorCodes.coral);
                                      }
                                      return customText(
                                          "Resend Code",
                                          ColorCodes.coral,
                                          12,
                                          FontWeight.w500,
                                          poppins,
                                          isTextUnderline: true);
                                    })),
                              ),
                              SizedBox(
                                  height:
                                      screenHeight(context, dividedBy: 3)),
                              GestureDetector(
                                  //1 = signUp
                                  //2 = forgotten
                                  onTap: widget.screenIndex == 1
                                      ? () async {
                                   // Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=> Welcome()),(route) => false);
                                          if (pinController.text.isEmpty) {
                                            flutterToast(
                                                "Please enter otp", false);
                                          } else {
                                            verifyOtpCubit.verifyOtpService(
                                                widget.phoneNumber,
                                                pinController.text,
                                                context);
                                          }
                                        }
                                      : () {
                                          if (!verifyForgotOtpCubit
                                              .isButtonClicked) {
                                            if (pinController.text.isEmpty) {
                                              flutterToast(
                                                  "Please enter otp", false);
                                            } else {
                                              verifyForgotOtpCubit
                                                  .verifyForgotOtpService(
                                                      widget.phoneNumber,
                                                      pinController.text,
                                                      context);
                                            }
                                          }
                                        },
                                  child: Container(
                                      alignment: Alignment.center,
                                      height:
                                          screenHeight(context, dividedBy: 18),
                                      width:
                                          screenWidth(context, dividedBy: 2.4),
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
                                      child: widget.screenIndex == 1
                                          ? BlocBuilder<VerifyOtpCubit,
                                                  VerifyOtpState>(
                                              builder: (context, state) {
                                              if (state is VerifyOtpLoading) {
                                                return spinkitLoader(
                                                    context, Colors.white);
                                              }
                                              return customText(
                                                  "Verify",
                                                  Colors.white,
                                                  14,
                                                  FontWeight.w600,
                                                  poppins);
                                            })
                                          : BlocBuilder<VerifyForgotOtpCubit,
                                                  VerifyForgotOtpState>(
                                              builder: (context, state) {
                                              if (state
                                                  is VerifyForgotOtpLoading) {
                                                return spinkitLoader(
                                                    context, Colors.white);
                                              }
                                              return customText(
                                                  "Verify",
                                                  Colors.white,
                                                  14,
                                                  FontWeight.w600,
                                                  poppins);
                                            }))),
                            ],
                          ),
                        ),
                      )
                    ]))
              ]))),
    );
  }
}

