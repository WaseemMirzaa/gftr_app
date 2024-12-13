import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gftr/Helper/appConfig.dart';
import 'package:flutter/material.dart';
import 'package:gftr/Helper/imageConstants.dart';
import 'package:gftr/View/Screens/LoginPage.dart';
import 'package:gftr/View/Screens/ManageBottom/gftrStoryViewPage.dart';
import 'package:gftr/ViewModel/Cubits/setting_cubit.dart';
import 'package:gftr/ViewModel/Cubits/viewsetting.dart';
import 'package:gftr/ViewModel/prefsService.dart';
class SplashPage extends StatefulWidget {
  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  SharedPrefsService prefsService = SharedPrefsService();
  SettingCubit settingCubit =SettingCubit();
  ViewSettingCubit viewSettingCubit =ViewSettingCubit();

  @override
  void initState() {
    super.initState();
      settingCubit = BlocProvider.of<SettingCubit>(context);
      viewSettingCubit = BlocProvider.of<ViewSettingCubit>(context);
      viewSettingCubit.getviewSetting();
    splashTimer();
  }

  splashTimer() async {
    SharedPrefsService prefsService = SharedPrefsService();
    authorization = (await prefsService.getStringData("authToken"))!;
    Selectbirtmsg = (await prefsService.getStringData("Selectbirtmsg"))!;
    Selecthollymsg = (await prefsService.getStringData("Selecthollymsg"))!;
    text_or_msg = (await prefsService.getStringData("text_or_msg"))!;
    only_or_any = (await prefsService.getBoolData("only_or_any"))!;
    Timer(const Duration(seconds: 3), () {
      if (authorization.length > 1) {
        setState(() {
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => GfterStoryViewPage()),
              (route) => false);
        });
      } else {
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => const LoginPage()),
            (route) => false);
        setState(() {

        });
      }
    });
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
