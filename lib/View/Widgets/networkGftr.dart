import 'package:flutter/material.dart';
import '../../Helper/appConfig.dart';

Widget networkGftr(BuildContext context, String imagePath) {
  return Container(
    padding: EdgeInsets.only(
      left: screenWidth(context, dividedBy: 80),
      right: screenWidth(context, dividedBy: 80),
    ),
    height: screenHeight(context, dividedBy: 13),
    width: screenWidth(context, dividedBy: 1.2),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(10),
      boxShadow: const [
        BoxShadow(
            offset: Offset(0.5, 1.0),
            spreadRadius: 0.1,
            color: Colors.grey,
            blurRadius: 1)
      ],
    ),
    child: Row(
      // mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          padding: const EdgeInsets.all(4.2),
          width: screenWidth(context, dividedBy: 7),
          height: screenHeight(context, dividedBy: 14),
          decoration: const BoxDecoration(
              // color: ColorCodes.coral,
              // border: GradientBoxBorder(
              //   gradient: LinearGradient(colors: [Colors.blue, Colors.red]),
              //   width: 5,
              // ),
              ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(100),
            child: Image.asset(imagePath),
          ),
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding:
                  EdgeInsets.only(left: screenWidth(context, dividedBy: 70)),
              child: const Text(
                "Marcy Stevens",
                style: TextStyle(
                    color: Color(0xff231F20),
                    fontWeight: FontWeight.bold,
                    fontSize: 14),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                  left: screenWidth(context, dividedBy: 100),
                  right: screenWidth(context, dividedBy: 10)),
              child: const Text(
                "Mother's day",
                style: TextStyle(fontSize: 10),
              ),
            ), //B5B5B5
          ],
        ),
        Container(
          padding: EdgeInsets.only(right: screenWidth(context, dividedBy: 30)),
          height: screenHeight(context, dividedBy: 28),
          width: screenWidth(context, dividedBy: 20),
          decoration: const BoxDecoration(),
          child: Stack(
            children: [
              Padding(
                padding: EdgeInsets.only(
                  right: screenWidth(context, dividedBy: 100),
                  left: screenWidth(context, dividedBy: 2.9),
                ),
                child: Icon(Icons.arrow_forward_ios_outlined,
                    color: const Color(0xff231F20),
                    size: screenHeight(context, dividedBy: 45)),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}
