import 'package:flutter/material.dart';
import 'package:gftr/Helper/appConfig.dart';
import 'package:gftr/Helper/colorConstants.dart';
import 'package:gftr/Helper/imageConstants.dart';
import 'package:gftr/View/Widgets/customText.dart';
import 'package:gftr/View/Widgets/drawer.dart';
import 'package:gftr/View/Widgets/roundedAppBar.dart';


// ignore: must_be_immutable
class AboutUs extends StatelessWidget {
  AboutUs({Key? key}) : super(key: key);

  List<BoxShadow> shadow = [
    const BoxShadow(color: Colors.grey, offset: Offset(0.0, 1.0), blurRadius: 3)
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          appBar: appBar(context),
          // appBar: AppBar(
          //   leading: Padding(
          //     padding: EdgeInsets.only(left: screenWidth(context, dividedBy: 13)),
          //     child: SizedBox(
          //       height: screenHeight(context, dividedBy: 30),
          //       width: screenWidth(context, dividedBy: 30),
          //       child: Image.asset(ImageConstants.sideMenu),
          //     ),
          //   ),
          //   backgroundColor: Colors.black,
          //   centerTitle: true,
          //   //elevation: 0,
          //   automaticallyImplyLeading: false,
          //   title: SizedBox(
          //       height: screenHeight(context, dividedBy: 30),
          //       // width: screenWidth(context,dividedBy: 20),
          //       child: Image.asset(ImageConstants.gftrLogo)),
          //   shape: const RoundedRectangleBorder(
          //     borderRadius: BorderRadius.vertical(
          //       bottom: Radius.circular(31),
          //     ),
          //   ),
          // ),
          drawer: drawerWidget(context),
          body: SizedBox(
              height: screenHeight(context),
              width: screenWidth(context),
              child: SingleChildScrollView(
                child: Column(children: [
                  SizedBox(
                    height: screenHeight(context, dividedBy: 35),
                  ),
                  SizedBox(
                    width: screenWidth(context, dividedBy: 1.2),
                    child: Row(
                      children: [
                        SizedBox(
                            // width: screenWidth(context, dividedBy: ),
                            child: customText("About Us", Colors.black, 20,
                                FontWeight.w300, madeOuterSans)),
                        Padding(
                          padding: EdgeInsets.only(
                              left: screenWidth(context, dividedBy: 5)),
                          child: Container(
                              height: screenHeight(context, dividedBy: 29),
                              width: screenWidth(context, dividedBy: 2.9),
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  boxShadow: shadow,
                                  borderRadius: BorderRadius.circular(10)),
                              child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Image.asset(
                                      ImageConstants.privacyPolicy,
                                      height:
                                          screenHeight(context, dividedBy: 50),
                                      width: screenHeight(context, dividedBy: 50),
                                    ),
                                    SizedBox(
                                      width: screenWidth(context, dividedBy: 50),
                                    ),
                                    customText("Privacy Policy", ColorCodes.coral,
                                        13, FontWeight.w500, poppins,
                                        maxLines: 500)
                                  ])),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: screenHeight(context, dividedBy: 70),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        left: screenWidth(context, dividedBy: 6.5)),
                    child: Row(
                      children: [
                        Image.asset(
                          ImageConstants.gftrBlack,
                          width: screenWidth(context, dividedBy: 7),
                          // height: screenHeight(context, dividedBy: 12),
                          fit: BoxFit.contain,
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                              top: screenHeight(context, dividedBy: 80)),
                          child: customText(
                              "was born from one simple desire to:",
                              ColorCodes.greyText,
                              12,
                              FontWeight.w600,
                              poppins),
                        ),
                      ],
                    ),
                  ),
                  Stack(
                    children: [
                      customText("make giving easier.", ColorCodes.greyText, 16,
                          FontWeight.w500, poppins),
                      Padding(
                        padding: EdgeInsets.only(
                            top: screenHeight(context, dividedBy: 35)),
                        child: Container(
                          width: screenWidth(context, dividedBy: 2.5),
                          height: 1,
                          color: const Color(0xff888888),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: screenHeight(context, dividedBy: 40),
                  ),
                  Image.asset(ImageConstants.aboutUs,
                      width: screenWidth(context, dividedBy: 1.2),
                      fit: BoxFit.contain),
                  SizedBox(height: screenHeight(context, dividedBy: 60)),
                  customText("We all know a ‘Gifter’.", ColorCodes.greyText, 16,
                      FontWeight.w500, poppins),
                  SizedBox(height: screenHeight(context, dividedBy: 60)),
                  const Text(
                      "  That one person in your life who, year after year, not\n only remembers your birthday / anniversary / Saint’s\n Day, but somehow also has the time and creativity to\n              think up and track down the perfect gift!",
                      style: TextStyle(
                          color: Color(0xff888888),
                          fontSize: 13,
                          fontFamily: "Poppins",
                          fontWeight: FontWeight.w500)),
                  customText("Every. Damn. Time.", ColorCodes.greyText, 13,
                      FontWeight.bold, poppins),
                  SizedBox(
                    height: screenHeight(context, dividedBy: 50),
                  ),
                  const Text(
                      "     These people, these Gifters, they’re… incredible…\n superhuman… a divine species operating at levels of\n   imagination, organization and insight to which the\n        rest of us mere mortals dare not even aspire…",
                      style: TextStyle(
                          color: Color(0xff888888),
                          fontSize: 13,
                          fontFamily: "Poppins",
                          fontWeight: FontWeight.w500)),
                  SizedBox(
                    height: screenHeight(context, dividedBy: 50),
                  ),
                  customText("Until now.", ColorCodes.greyText, 13,
                      FontWeight.w500, poppins),
                  SizedBox(
                    height: screenHeight(context, dividedBy: 50),
                  ),
                  customText("Move over, the ‘Gifters’ in your life...",
                      ColorCodes.greyText, 13, FontWeight.w500, poppins),
                  SizedBox(
                    height: screenHeight(context, dividedBy: 45),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        left: screenWidth(context, dividedBy: 3.2)),
                    child: Row(
                      children: [
                        customText("You're a", ColorCodes.greyText, 13,
                            FontWeight.w500, poppins),
                        SizedBox(width: screenWidth(context, dividedBy: 60)),
                        Image.asset(
                          ImageConstants.gftrBlack,
                          width: screenWidth(context, dividedBy: 9),
                          fit: BoxFit.contain,
                        ),
                        SizedBox(width: screenWidth(context, dividedBy: 80)),
                        customText("now.", ColorCodes.greyText, 13,
                            FontWeight.w500, poppins),
                      ],
                    ),
                  )
                ]),
              ))),
    );
  }
}
