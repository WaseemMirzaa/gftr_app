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

        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage(ImageConstants.welcomeBackGround),
                fit: BoxFit.fill)),
        child: Column(
          children: [
            Padding(
              padding:
                  EdgeInsets.only(top: screenHeight(context, dividedBy: 25)),
              child: customText(
                  'The Wishlist', Colors.white, 19, FontWeight.bold, poppins),
            ),
            Container(
              margin:  EdgeInsets.only(top: screenHeight(context, dividedBy: 80)),
              height: screenHeight(context, dividedBy: 2.5),
              width: screenWidth(context, dividedBy: 1),
              alignment: Alignment.center,
              color: ColorCodes.lightGrey,
              child: Container(
                width: screenWidth(context, dividedBy: 1.4),
                child: customText(
                    """Video of using the plug-in (like in the ‘Share to Gftr’ pages) and saving the item to a new folder, then seeing the ‘Get Gifted’ page """,
                    Colors.black, 14,
                    FontWeight.w400,
                    poppins,
                    isTextAlign: true),
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
                  FontWeight.w400,
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
                  FontWeight.w400,
                  poppins,
                  isTextAlign: true),
            ), Padding(
              padding:  EdgeInsets.only(top: screenHeight(context, dividedBy: 30)),
              child: customText(
                  "Think of it as... ‘Pinterest for Presents’.",
                  Colors.white,
                  13,
                  FontWeight.w400,
                  poppins,
                  isTextAlign: true),
            ),
          ],
        ),
      ),
    );
  }
}
