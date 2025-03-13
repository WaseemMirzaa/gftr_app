import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:gftr/Helper/appConfig.dart';

Widget customLoader(BuildContext context){
  return Center(
    child: Container(
      height: screenHeight(context,dividedBy: 12),
      width: screenHeight(context,dividedBy: 12),
      alignment: Alignment.center,

      child: const SpinKitFadingCircle(
        color: Color(0xffF37A5B),
        size: 20.0
      ),
    )
  );
}

Widget spinkitLoader(BuildContext context, Color color){
  return SpinKitFadingCircle(
      color: color,
      size: screenWidth(context,dividedBy: 16)
  );
}