import 'dart:developer';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/material.dart';
import 'package:gftr/View/Screens/gftrNetwork.dart';

class FirebaseDyanamicLinkService {
  static Future<void> creatDynamicLink(BuildContext context) async {
    String linkMessage;
    DynamicLinkParameters dynamicLinkParams = DynamicLinkParameters(
      link: Uri.parse("https://gftruser.page.link/email"),
      uriPrefix: "https://gftruser.page.link",
      androidParameters: const AndroidParameters(
        packageName: "com.example.gftr",
        minimumVersion: 125,
      ),
      iosParameters: IOSParameters(
        bundleId: "com.user.gftr",
        minimumVersion: "1.0.1",
      ),
    );
    final dynamicLink =
        await FirebaseDynamicLinks.instance.buildShortLink(dynamicLinkParams);
    final data = FirebaseDynamicLinks.instance.onLink.listen((event) {
      final url =event.link;
      final quaryParams=url.queryParameters;
      if(quaryParams.isNotEmpty){
        Navigator.push(context, MaterialPageRoute(builder: (context) => GftrNetwork(),));
      }
    });
    log(dynamicLink.shortUrl.toString());
    log(data.toString());
  }
}
