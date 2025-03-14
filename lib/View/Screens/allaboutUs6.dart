import 'package:flutter/material.dart';
import 'package:gftr/Helper/appConfig.dart';
import 'package:gftr/Helper/colorConstants.dart';
import 'package:gftr/Helper/imageConstants.dart';
import 'package:gftr/View/Widgets/customText.dart';

class AllAboutUs06 extends StatefulWidget {
  const AllAboutUs06({Key? key}) : super(key: key);

  @override
  State<AllAboutUs06> createState() => _AllAboutUs06State();
}

class _AllAboutUs06State extends State<AllAboutUs06> {
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
                  'The Group', Colors.white, 18, FontWeight.bold, poppins),
            ),
            Container(
              margin:
                  EdgeInsets.only(top: screenHeight(context, dividedBy: 80)),
              height: screenHeight(context, dividedBy: 2.5),
              width: screenWidth(context, dividedBy: 1),
              alignment: Alignment.center,
              color: ColorCodes.lightGrey,
              child: Container(
                width: screenWidth(context, dividedBy: 1.7),
                child: customText(
                    "Video of adding friends from contact list, seeing the GFTR Group page, clicking on one user, seeing their saved gift ideas and selecting one to buy.",
                    Colors.black,
                    13,
                    FontWeight.w400,
                    poppins,
                    isTextAlign: true),
              ),
            ),
            Container(
              margin:
                  EdgeInsets.only(top: screenHeight(context, dividedBy: 15)),
              width: screenWidth(context, dividedBy: 1.4),
              child: customText(
                  " Create your GFTR Group of Friends & Family you’d like to get gifts for (or from!), then check out their Gftr Wishlists to see what they’ve got their eye on.",
                  Colors.white,
                  13,
                  FontWeight.w400,
                  poppins,
                  isTextAlign: true),
            ),
            Padding(
              padding:
                  EdgeInsets.only(top: screenHeight(context, dividedBy: 30)),
              child: customText("And, with a single click, give that gift!",
                  Colors.white, 13, FontWeight.w400, poppins,
                  isTextAlign: true),
            ),
          ],
        ),
      ),
    );
  }
}
