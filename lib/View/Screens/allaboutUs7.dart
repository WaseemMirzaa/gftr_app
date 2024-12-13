import 'package:flutter/material.dart';
import 'package:gftr/Helper/appConfig.dart';
import 'package:gftr/Helper/colorConstants.dart';
import 'package:gftr/Helper/imageConstants.dart';
import 'package:gftr/View/Screens/LoginPage.dart';
import 'package:gftr/View/Screens/ManageBottom/gftrStoryViewPage.dart';
import 'package:gftr/View/Widgets/customText.dart';
import 'package:gftr/ViewModel/prefsService.dart';
import 'package:gradient_borders/box_borders/gradient_box_border.dart';

import 'ManageBottom/Thegiftrguids.dart';

class AllAboutUs07 extends StatefulWidget {
  final bool isFromMenu;
  const AllAboutUs07({Key? key, this.isFromMenu = false}) : super(key: key);

  @override
  State<AllAboutUs07> createState() => _AllAboutUs07State();
}

class _AllAboutUs07State extends State<AllAboutUs07> {
  LinearGradient coralTealColor = const LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [ColorCodes.coral, ColorCodes.teal],
  );
  SharedPrefsService prefsService = SharedPrefsService();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage(ImageConstants.welcomeBackGround),
                fit: BoxFit.fill)),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding:
                    EdgeInsets.only(top: screenHeight(context, dividedBy: 25)),
                child: customText(
                    'The Guide', Colors.white, 18, FontWeight.bold, poppins),
              ),
              Container(
                margin:
                    EdgeInsets.only(top: screenHeight(context, dividedBy: 80)),
                height: screenHeight(context, dividedBy: 2.5),
                width: screenWidth(context, dividedBy: 1),
                alignment: Alignment.center,
                color: ColorCodes.lightGrey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      width: screenWidth(context, dividedBy: 1.4),
                      child: customText(
                          "Video of clicking through to the Gftr Guide homepage, scrolling through articles etc. ",
                          Colors.black,
                          13,
                          FontWeight.w400,
                          poppins,
                          isTextAlign: true),
                    ),
                    Container(
                      width: screenWidth(context, dividedBy: 1.8),
                      child: customText(
                          "Then quick video of the settings page and the reminder options.",
                          Colors.black,
                          13,
                          FontWeight.w400,
                          poppins,
                          isTextAlign: true),
                    ),
                    Container(
                      width: screenWidth(context, dividedBy: 1.8),
                      child: customText("End on GFTR logo.", Colors.black, 13,
                          FontWeight.w400, poppins,
                          isTextAlign: true),
                    ),
                  ],
                ),
              ),
              Container(
                margin:
                    EdgeInsets.only(top: screenHeight(context, dividedBy: 30)),
                width: screenWidth(context, dividedBy: 1.35),
                child: customText(
                    "Check out our GFTR Guide for gifting ideas for every occasion; fascinating interviews with gifting aficionados; and ‘Small Business Spotlight’ articles.",
                    Colors.white,
                    13,
                    FontWeight.w400,
                    poppins,
                    isTextAlign: true),
              ),
              Padding(
                padding:
                    EdgeInsets.only(top: screenHeight(context, dividedBy: 80)),
                child: customText(
                    "That’s it!", Colors.white, 13, FontWeight.w400, poppins,
                    isTextAlign: true),
              ),
              Container(
                margin:
                    EdgeInsets.only(top: screenHeight(context, dividedBy: 80)),
                width: screenWidth(context, dividedBy: 1.35),
                child: customText(
                    "(And don’t worry. We’ve all forgotten the occasional birthday… but not anymore! Just check your settings to make sure we will always remind you in plenty of time to get that perfect gift…)",
                    Colors.white,
                    13,
                    FontWeight.w400,
                    poppins,
                    isTextAlign: true),
              ),
              Padding(
                padding:
                    EdgeInsets.only(top: screenHeight(context, dividedBy: 60)),
                child: customText("So what are you waiting for?", Colors.white,
                    13, FontWeight.w400, poppins,
                    isTextAlign: true),
              ),
              GestureDetector(
                onTap: () {
                  // if (authorization.length > 1)
                  if (widget.isFromMenu) {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => GfterStoryViewPage(),
                      ),
                    );
                    bottombarblack = true;
                    isSearchbar = true;
                  } else {
                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const LoginPage()),
                        (route) => false);
                  }
                },
                child: Container(
                  margin: EdgeInsets.only(
                      top: screenHeight(context, dividedBy: 37)),
                  alignment: Alignment.center,
                  height: screenHeight(context, dividedBy: 20),
                  width: screenWidth(context, dividedBy: 2.3),
                  decoration: BoxDecoration(
                      border: GradientBoxBorder(gradient: coralTealColor),
                      borderRadius: BorderRadius.circular(30)),
                  child: customText("Get Gifting!", Colors.white, 13,
                      FontWeight.w100, poppins),
                ),
              ),
              SizedBox(height: screenHeight(context, dividedBy: 50))
            ],
          ),
        ),
      ),
    );
  }
}
