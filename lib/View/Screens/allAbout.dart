import 'package:flutter/material.dart';
import 'package:gftr/Helper/appConfig.dart';
import 'package:gftr/Helper/colorConstants.dart';
import 'package:gftr/Helper/imageConstants.dart';
import 'package:gftr/View/Screens/aboutpageview.dart';
import 'package:gftr/View/Screens/allaboutUs7.dart';
import 'package:gftr/View/Widgets/customText.dart';
import 'package:gradient_borders/box_borders/gradient_box_border.dart';

class AllAbout extends StatefulWidget {
  const AllAbout({Key? key}) : super(key: key);

  @override
  State<AllAbout> createState() => _AllAboutState();
}

class _AllAboutState extends State<AllAbout> {
  LinearGradient coralTealColor = const LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [ColorCodes.teal, ColorCodes.coral],
  );

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          height: double.infinity,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(
                ImageConstants.welcomeBackGround,
              ),
              fit: BoxFit.fill,
            ),
          ),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: screenHeight(context, dividedBy: 30)),
                Container(
                  height: screenHeight(context, dividedBy: 4.6),
                  width: screenWidth(context, dividedBy: 1.5),
                  child: Image.asset(
                    ImageConstants.textWithLogo,
                  ),
                ),
                customText(
                  "Make Giving Easier",
                  Colors.white,
                  30,
                  FontWeight.bold,
                  poppins,
                ),
                SizedBox(height: screenHeight(context, dividedBy: 60)),
                customText(
                  "We all know a ‘Gifter’...",
                  Colors.white,
                  13,
                  FontWeight.w500,
                  poppins,
                ),
                Container(
                  margin: EdgeInsets.only(
                    top: 18,
                  ),
                  width: screenWidth(context, dividedBy: 1.18),
                  child: customText(
                      "That one person in your life who, year after year, not only remembers your birthday, but also somehow has the time, creativity & forethought  to find, buy and deliver the perfect gift...",
                      Colors.white,
                      13,
                      FontWeight.w500,
                      poppins,
                      isTextAlign: true),
                ),
                SizedBox(height: 18),
                customText(
                  "Every. Damn. Time.",
                  Colors.white,
                  13,
                  FontWeight.w500,
                  poppins,
                  isTextAlign: true,
                ),
                SizedBox(height: 20),
                customText(
                  "Well, move over, the ‘Gifters’ in your life...",
                  Colors.white,
                  13,
                  FontWeight.w500,
                  poppins,
                  isTextAlign: true,
                ),
                SizedBox(height: 18),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    customText(
                      "You’re a",
                      Colors.white,
                      13,
                      FontWeight.w500,
                      poppins,
                      isTextAlign: true,
                    ),
                    SizedBox(
                      width: 8,
                    ),
                    Image.asset(
                      ImageConstants.gftrBlack,
                      color: Colors.white,
                      height: 25,
                    ),
                    SizedBox(
                      width: 8,
                    ),
                    customText(
                      "now",
                      Colors.white,
                      13,
                      FontWeight.w500,
                      poppins,
                    ),
                  ],
                ),
                SizedBox(height: 18),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 80),
                  child: Divider(
                    color: Colors.white,
                    height: 10,
                  ),
                ),
                SizedBox(
                  height: 18,
                ),
                customText(
                  "How it works:",
                  Colors.white,
                  15,
                  FontWeight.w500,
                  poppins,
                  isTextAlign: true,
                ),
                SizedBox(height: 18),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => AboutUsPageView(
                                        isFromLogin: true,
                                      )));
                          pageViewIndex = 0;
                          setState(() {});
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => AboutUsPageView(
                                        isFromLogin: true,
                                      )));
                          pageViewIndex = 4;
                          setState(() {});
                        },
                        child: Container(
                          margin: EdgeInsets.only(
                              top: screenHeight(context, dividedBy: 40)),
                          alignment: Alignment.center,
                          height: screenHeight(context, dividedBy: 20),
                          width: screenWidth(context, dividedBy: 2.3),
                          decoration: BoxDecoration(
                              border:
                                  GradientBoxBorder(gradient: coralTealColor),
                              borderRadius: BorderRadius.circular(30)),
                          child: customText("The Wishlist", Colors.white, 13,
                              FontWeight.w100, poppins),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => AboutUsPageView(
                                        isFromLogin: true,
                                      )));
                          pageViewIndex = 5;
                          setState(() {});
                        },
                        child: Container(
                          margin: EdgeInsets.only(
                              top: screenHeight(context, dividedBy: 40)),
                          alignment: Alignment.center,
                          height: screenHeight(context, dividedBy: 20),
                          width: screenWidth(context, dividedBy: 2.3),
                          decoration: BoxDecoration(
                              border:
                                  GradientBoxBorder(gradient: coralTealColor),
                              borderRadius: BorderRadius.circular(30)),
                          child: customText("The Group", Colors.white, 13,
                              FontWeight.w100, poppins),
                        ),
                      )
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => AllAboutUs07(
                                  isFromMenu: false,
                                )));

                    setState(() {});
                  },
                  child: Container(
                    margin: EdgeInsets.only(
                        top: screenHeight(context, dividedBy: 40)),
                    alignment: Alignment.center,
                    height: screenHeight(context, dividedBy: 20),
                    width: screenWidth(context, dividedBy: 2.3),
                    decoration: BoxDecoration(
                        border: GradientBoxBorder(gradient: coralTealColor),
                        borderRadius: BorderRadius.circular(30)),
                    child: customText("The Guide", Colors.white, 13,
                        FontWeight.w100, poppins),
                  ),
                ),
                SizedBox(
                  height: screenHeight(context, dividedBy: 50),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
