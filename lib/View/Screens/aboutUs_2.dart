import 'package:flutter/material.dart';
import 'package:gftr/Helper/appConfig.dart';
import 'package:gftr/Helper/imageConstants.dart';
import 'package:gftr/View/Widgets/customText.dart';

class AboutUs02 extends StatefulWidget {
  const AboutUs02({Key? key}) : super(key: key);

  @override
  State<AboutUs02> createState() => _AboutUs02State();
}

class _AboutUs02State extends State<AboutUs02> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
              ImageConstants.welcomeBackGround,
            ),
            fit: BoxFit.fill,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              height: screenHeight(context, dividedBy: 4.6),
              width: screenWidth(context, dividedBy: 2),
              child: Image.asset(
                ImageConstants.textWithLogo,
              ),
            ),
            SizedBox(
              height: screenHeight(context,dividedBy: 30)
            ),
            customText(
              "Make Giving Easier",
              Colors.white,
              25,
              FontWeight.w600,
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
            SizedBox(height:  screenHeight(context, dividedBy: 60)),
            Container(

              margin: EdgeInsets.only(
                top:  screenHeight(context, dividedBy: 40),
              ),
              width: screenWidth(context, dividedBy: 1.4),
              child: customText(
                  "That one person in your life who, year after year, not only remembers your birthday, but also somehow has the time, creativity & forethought  to find, buy and deliver the perfect gift...",
                  Colors.white,
                  13,
                  FontWeight.w500,
                  poppins,
                  isTextAlign: true),
            ),
            SizedBox(height:  screenHeight(context, dividedBy: 50)),
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
              "Well, move over, the ‘Gifters’ in your \nlife...",
              Colors.white,
              13,
              FontWeight.w500,
              poppins,
              isTextAlign: true,
            ),
            SizedBox(height:  screenHeight(context, dividedBy: 20)),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                customText(
                  "You’re a",
                  Colors.white,
                  16,
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
                  height: 30,
                ),
                SizedBox(
                  width: 8,
                ),
                customText(
                  "now",
                  Colors.white,
                  16,
                  FontWeight.w500,
                  poppins,
                ),
              ],
            ),


          ],
        ),
      ),
    );
  }
}
