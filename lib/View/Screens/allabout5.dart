import 'package:flutter/material.dart';
import 'package:gftr/Helper/appConfig.dart';
import 'package:gftr/Helper/colorConstants.dart';
import 'package:gftr/Helper/imageConstants.dart';
import 'package:gftr/View/Screens/allaboutUs6.dart';
import 'package:gftr/View/Widgets/customText.dart';

class AllAboutUs05 extends StatefulWidget {
  const AllAboutUs05({Key? key}) : super(key: key);

  @override
  State<AllAboutUs05> createState() => _AllAboutUs05State();
}

class _AllAboutUs05State extends State<AllAboutUs05> {
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
            Container(
              height: screenHeight(context, dividedBy: 4.6),
              width: screenWidth(context, dividedBy: 2),
              child: Image.asset(
                ImageConstants.textWithLogo,
              ),
            ),
            Padding(
              padding:
                  EdgeInsets.only(top: screenHeight(context, dividedBy: 25)),
              child: customText(
                'The Wishlist',
                Colors.white,
                25,
                FontWeight.w600,
                poppins,
              ),
            ),
            Container(
              margin:
                  EdgeInsets.only(top: screenHeight(context, dividedBy: 15)),
              width: screenWidth(context, dividedBy: 1.3),
              child: customText(
                  "Save items from anywhere on the internet to your personal GFTR Wishlist with our handy GFTR plug-in.",
                  Colors.white,
                  13,
                  FontWeight.w500,
                  poppins,
                  isTextAlign: true),
            ),
            Container(
              margin:
                  EdgeInsets.only(top: screenHeight(context, dividedBy: 40)),
              width: screenWidth(context, dividedBy: 1.3),
              child: customText(
                  "Or just Google from within GFTR itself! Create folders. Make them private or public. You do you!",
                  Colors.white,
                  13,
                  FontWeight.w500,
                  poppins,
                  isTextAlign: true),
            ),
            Padding(
              padding:
                  EdgeInsets.only(top: screenHeight(context, dividedBy: 30)),
              child: customText("Think of it as... ‘Pinterest for Presents’.",
                  Colors.white, 13, FontWeight.w500, poppins,
                  isTextAlign: true),
            ),
            SizedBox(height: screenHeight(context, dividedBy: 20)),
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
