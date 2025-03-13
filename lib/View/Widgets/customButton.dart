import 'package:flutter/material.dart';
import 'package:gftr/Helper/appConfig.dart';
import 'package:gftr/Helper/colorConstants.dart';
import 'package:gftr/View/Widgets/customText.dart';


Widget customButton(BuildContext context,double width,String text){
  return Container(
    height: screenHeight(context,dividedBy: 20),
    width: width,
    decoration: BoxDecoration(
      color: ColorCodes.coral,
      borderRadius: BorderRadius.circular(100),
      boxShadow: [
        BoxShadow(
          color: Colors.grey,
          blurRadius: 5.0,
          // spreadRadius: 0.0,
          offset: Offset(
            1.0,
            2.0,
          ),
        )
      ],
    ),
    alignment: Alignment.center,
    child: customText(text, Colors.white, 13, FontWeight.w600, poppins),
  );
}