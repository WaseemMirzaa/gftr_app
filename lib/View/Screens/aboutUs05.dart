import 'package:flutter/material.dart';
import 'package:gftr/Helper/appConfig.dart';
import 'package:gftr/Helper/imageConstants.dart';
import 'package:gftr/View/Widgets/customText.dart';

class AboutUs05 extends StatefulWidget {
  const AboutUs05({Key? key}) : super(key: key);

  @override
  State<AboutUs05> createState() => _AboutUs05State();
}

class _AboutUs05State extends State<AboutUs05> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(

        width: double.infinity,
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage(ImageConstants.welcomeBackGround),
                fit: BoxFit.fill)),
        child: Column(
          children: [
            SizedBox(
              height: screenHeight(context, dividedBy: 7),
            ),
            Container(
              width: screenWidth(context, dividedBy: 1.5),
              child: Image.asset(
                ImageConstants.textWithLogo2,
              ),
            ),
            SizedBox(
              height: screenHeight(context, dividedBy: 9),
            ),
            customText("First:", Colors.white, 20, FontWeight.w400, poppins),
            customText("Your Universal Wishlist", Colors.white, 23,
                FontWeight.bold, poppins),
            SizedBox(
              height: screenHeight(context, dividedBy: 13),
            ),
            customText(
                "Second: :", Colors.white, 20, FontWeight.w400, poppins),
            customText("Your Ultimate Gifting Guide", Colors.white, 23,
                FontWeight.bold, poppins),
            SizedBox(
              height: screenHeight(context, dividedBy: 10),
            ),

          ],
        ),
      ),
    );
  }
}
