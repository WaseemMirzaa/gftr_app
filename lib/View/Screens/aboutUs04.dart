import 'package:flutter/material.dart';
import 'package:gftr/Helper/appConfig.dart';
import 'package:gftr/Helper/imageConstants.dart';
import 'package:gftr/View/Widgets/customText.dart';

class AboutUs04 extends StatefulWidget {
  const AboutUs04({Key? key}) : super(key: key);

  @override
  State<AboutUs04> createState() => _AboutUs04State();
}

class _AboutUs04State extends State<AboutUs04> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage(ImageConstants.welcomeBackGround),
                fit: BoxFit.fill)),
        child: Column(
          children: [
            SizedBox(
              height: screenHeight(context, dividedBy: 12),
            ),
            customText("How to", Colors.white, 17, FontWeight.w400, poppins),
            SizedBox(
              height: screenHeight(context, dividedBy: 7),
            ),
            Padding(
              padding:
                  EdgeInsets.only(left: screenWidth(context, dividedBy: 4)),
              child: Row(
                children: [
                  customText(
                      "Give", Colors.white, 23, FontWeight.bold, poppins),
                  SizedBox(
                    width: screenWidth(context, dividedBy: 70),
                  ),
                  customText("Them The Gift", Colors.white, 22, FontWeight.w400,
                      poppins),
                ],
              ),
            ),
            Padding(
              padding:
                  EdgeInsets.only(left: screenWidth(context, dividedBy: 5)),
              child: Row(
                children: [
                  customText("They", Colors.white, 28, FontWeight.bold, poppins,
                      fontStyle: FontStyle.italic),
                  SizedBox(
                    width: screenWidth(context, dividedBy: 60),
                  ),
                  customText(
                      "Want To", Colors.white, 27, FontWeight.w400, poppins,
                      fontStyle: FontStyle.italic),
                  SizedBox(
                    width: screenWidth(context, dividedBy: 60),
                  ),
                  customText("Get", Colors.white, 28, FontWeight.bold, poppins,
                      fontStyle: FontStyle.italic),
                ],
              ),
            ),
            SizedBox(
              height: screenHeight(context, dividedBy: 25),
            ),
            customText("&", Colors.white, 20, FontWeight.w400, poppins),
            SizedBox(
              height: screenHeight(context, dividedBy: 25),
            ),
            Padding(
              padding:
                  EdgeInsets.only(left: screenWidth(context, dividedBy: 3)),
              child: Row(
                children: [
                  customText("Get", Colors.white, 23, FontWeight.bold, poppins),
                  SizedBox(
                    width: screenWidth(context, dividedBy: 70),
                  ),
                  customText(
                      "The Gift", Colors.white, 22, FontWeight.w400, poppins),
                ],
              ),
            ),
            Padding(
              padding:
                  EdgeInsets.only(left: screenWidth(context, dividedBy: 9)),
              child: Row(
                children: [
                  customText("You", Colors.white, 28, FontWeight.bold, poppins,
                      fontStyle: FontStyle.italic),
                  SizedBox(
                    width: screenWidth(context, dividedBy: 60),
                  ),
                  customText(
                      "Want To Be", Colors.white, 27, FontWeight.w400, poppins,
                      fontStyle: FontStyle.italic),
                  SizedBox(
                    width: screenWidth(context, dividedBy: 60),
                  ),
                  customText(
                      "Given", Colors.white, 28, FontWeight.bold, poppins,
                      fontStyle: FontStyle.italic),
                ],
              ),
            ),
            SizedBox(
              height: screenHeight(context, dividedBy: 8),
            ),
            customText("Well, we solved both!", Colors.white, 17,
                FontWeight.w400, poppins),
            SizedBox(
              height: screenHeight(context, dividedBy: 30),
            ),
            customText("And here’s how we did it", Colors.white, 17,
                FontWeight.w400, poppins),
          ],
        ),
      ),
    );
  }
}
