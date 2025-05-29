import 'dart:async';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gftr/Helper/appConfig.dart';
import 'package:flutter/material.dart';
import 'package:gftr/Helper/imageConstants.dart';
import 'package:gftr/View/Screens/LoginPage.dart';
import 'package:gftr/View/Screens/ManageBottom/gftrStoryViewPage.dart';
import 'package:gftr/View/Widgets/bottomNavigationBar.dart';
import 'package:gftr/ViewModel/Cubits/setting_cubit.dart';
import 'package:gftr/ViewModel/Cubits/viewsetting.dart';
import 'package:gftr/ViewModel/prefsService.dart';
import 'package:gftr/main.dart';

class SplashPage extends StatefulWidget {
  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  SharedPrefsService prefsService = SharedPrefsService();
  SettingCubit settingCubit = SettingCubit();
  ViewSettingCubit viewSettingCubit = ViewSettingCubit();

  @override
  void initState() {
    super.initState();
    settingCubit = BlocProvider.of<SettingCubit>(context);
    viewSettingCubit = BlocProvider.of<ViewSettingCubit>(context);
    viewSettingCubit.getviewSetting();
    checkLoginStatus();
    // checkforNotification();
  }

  // checkforNotification()async{
  //   await checkLoginStatus();
  //   try {
  //     if(mounted){
  //       FirebaseMessaging.onMessage.listen((event) {
  //           void handleMessage(RemoteMessage? message){
  //   if(message == null) return;
  //     notificationRouteKey.currentState?.pushNamed(
  //   NavigationScreen.navigationRoute,
  //   // arguments: {
  //   //   "index" : 1
  //   // }
  //     );
  //        }});
  //     }
  //   } catch (e) {
      
  //   }
  // }


  Future<void> checkLoginStatus() async {
    try {
      String? token = await prefsService.getStringData("authToken");
      bool hasSeenSplash =
          await prefsService.getBoolData("has_seen_splash") ?? false;

      // Set global variables
      authorization = token ?? '';
      Selectbirtmsg = (await prefsService.getStringData("Selectbirtmsg")) ?? '';
      Selecthollymsg =
          (await prefsService.getStringData("Selecthollymsg")) ?? '';
      text_or_msg = (await prefsService.getStringData("text_or_msg")) ?? '';
      only_or_any = (await prefsService.getBoolData("only_or_any")) ?? false;

      if (!hasSeenSplash) {
        // First time - show splash for 3 seconds
        await prefsService.setBoolData("has_seen_splash", true);
        Timer(const Duration(seconds: 3), () {
          navigateToNextScreen(token);
        });
      } else {
        // Skip splash animation
        navigateToNextScreen(token);
      }
    } catch (e) {
      print("Error checking login status: $e");
      navigateToNextScreen(null);
    }
  }

  void navigateToNextScreen(String? token) {
    if (token != null && token.isNotEmpty) {
      bottombarblack = true;
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => GfterStoryViewPage()),
          (route) => false);
    } else {
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => const LoginPage()),
          (route) => false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      height: screenHeight(context),
      width: screenWidth(context),
      decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage(ImageConstants.welcomeBackGround),
              fit: BoxFit.fill)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            ImageConstants.gftrLogo,
            width: screenWidth(context, dividedBy: 3),
            height: screenHeight(context, dividedBy: 3),
          )
        ],
      ),
    ));
  }
}
