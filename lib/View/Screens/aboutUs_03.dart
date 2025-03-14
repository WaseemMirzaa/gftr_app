import 'package:flutter/material.dart';
import 'package:gftr/Helper/appConfig.dart';
import 'package:gftr/Helper/imageConstants.dart';
import 'package:gftr/View/Widgets/customText.dart';

class AboutUs03 extends StatefulWidget {
  const AboutUs03({Key? key}) : super(key: key);

  @override
  State<AboutUs03> createState() => _AboutUs03State();
}

class _AboutUs03State extends State<AboutUs03> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
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
            Padding(
              padding:
                  EdgeInsets.only(top: screenHeight(context, dividedBy: 10)),
              child: customText(
                "Gift-Giving is a two-sided coin. \nWe call those sides",
                Colors.white,
                16,
                FontWeight.w400,
                poppins,
                isTextAlign: true,
              ),
            ),
            SizedBox(height: screenHeight(context, dividedBy: 10)),
            customText("GIFTING", Colors.white, 30, FontWeight.bold, poppins),
            customText("&", Colors.white, 20, FontWeight.w400, poppins),
            customText("GETTING", Colors.white, 30, FontWeight.bold, poppins),
            SizedBox(height: screenHeight(context, dividedBy: 30)),
            customText("(can't have one without the other!)", Colors.white, 13,
                FontWeight.w400, poppins),
            SizedBox(height: screenHeight(context, dividedBy: 10)),
            customText("And the same problems have faced", Colors.white, 16,
                FontWeight.w400, poppins),
            SizedBox(height: screenHeight(context, dividedBy: 30)),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                customText(
                    "GIFTERS", Colors.white, 22, FontWeight.bold, poppins),
                const SizedBox(width: 5),
                customText("&", Colors.white, 14, FontWeight.w400, poppins),
                const SizedBox(width: 5),
                customText(
                    "GETTERS", Colors.white, 22, FontWeight.bold, poppins),
              ],
            ),
            SizedBox(height: screenHeight(context, dividedBy: 30)),
            customText("since the dawn of time", Colors.white, 16,
                FontWeight.w400, poppins),
          ],
        ),
      ),
    );
  }
}
