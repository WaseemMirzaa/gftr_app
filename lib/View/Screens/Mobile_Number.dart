import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gftr/Helper/appConfig.dart';
import 'package:gftr/Helper/colorConstants.dart';
import 'package:gftr/Helper/imageConstants.dart';
import 'package:gftr/View/Widgets/commonAuthenticationtextField.dart';
import 'package:gftr/View/Widgets/customText.dart';
import 'package:gftr/ViewModel/Cubits/mobile_Auth.dart';

import 'LoginPage.dart';

class Mobile_number extends StatefulWidget {
  String email;
   Mobile_number({super.key,required this.email});

  @override
  State<Mobile_number> createState() => _Mobile_numberState();
}

class _Mobile_numberState extends State<Mobile_number> {
  TextEditingController phoneNumber = TextEditingController();
  FocusNode phoneNumberlNode = FocusNode();
  Mobile_AuthCubit mobile_authCubit = Mobile_AuthCubit();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    mobile_authCubit =BlocProvider.of<Mobile_AuthCubit>(context);
    setState(() {});
  }
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        body: Container(
          height: screenHeight(context),
          width: screenWidth(context),
          child: Stack(
            children: [
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
                  Positioned(
                    top: screenHeight(context,dividedBy: 10),
                    child: IconButton(onPressed: () {
                      Navigator.pop(context);
                    }, icon: Icon(Icons.arrow_back_ios_new,color: Colors.white,)),
                  )
                ],
              ),
              Container(
                height: screenHeight(context, dividedBy: 1.2),
                width: screenWidth(context),
                margin:
                EdgeInsets.only(top: screenHeight(context, dividedBy: 4.8)),
                decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius:
                    BorderRadius.only(topLeft: Radius.circular(60))),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: screenHeight(context, dividedBy: 18)),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(
                              left: screenWidth(context, dividedBy: 10)),
                          child: customText("Mobile Number", Colors.black, 16,
                              FontWeight.w400, madeOuterSans),
                        ),
                        SizedBox(height: screenHeight(context, dividedBy: 100)),
                        Padding(
                          padding: EdgeInsets.only(
                              left: screenWidth(context, dividedBy: 10)),
                          child: SizedBox(
                            width: screenWidth(context, dividedBy: 1.6),
                            child: customText(
                                "Enter the phone number ",
                                ColorCodes.greyText,
                                12,
                                FontWeight.w100,
                                poppins),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: screenHeight(context, dividedBy: 25)),
                    Expanded(
                      child: SingleChildScrollView(
                        physics: const BouncingScrollPhysics(),
                        child: Column(
                          children: [
                            Padding(
                              padding: EdgeInsets.only(
                                right: screenWidth(context, dividedBy: 10),
                                left: screenWidth(context, dividedBy: 10),
                              ),
                              child: SimpleAuthTextField(
                                context: context,
                                controller: phoneNumber,
                                hintText: "Phone Number",
                                iconPath: ImageConstants.phoneWhite,
                                focusNode: phoneNumberlNode,
                                numberKeyboard: true,
                              ),
                            ),
                            SizedBox(
                                height: screenHeight(context, dividedBy: 2.5)),
                            GestureDetector(
                              child: Container(
                                alignment: Alignment.center,
                                height: screenHeight(context, dividedBy: 18),
                                width: screenWidth(context, dividedBy: 2.4),
                                decoration: BoxDecoration(
                                  color: ColorCodes.coral,
                                  borderRadius: BorderRadius.circular(100),
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
                                child: Center(child: customText("Send", Colors.white, 14,
                                    FontWeight.w600, poppins)),
                              ),
                              onTap: () {
                                mobile_authCubit.events_views(context, number: phoneNumber.text,G_id:widget.email);
                                print("number :${phoneNumber.text}");
                                // if (!forgotPassCubit.isButtonClicked) {
                                //   if (phoneNumber.text.isEmpty) {
                                //     flutterToast(
                                //         "Please enter PhoneNumber", false);
                                //   } else if (countryCodeSelect == '') {
                                //     flutterToast(
                                //         "Please Select Country Code", false);
                                //   } else {
                                //     forgotPassCubit.forgotPassService(context,
                                //         phoneNumber: phoneNumber.text);
                                //   }
                                // }
                              },
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
