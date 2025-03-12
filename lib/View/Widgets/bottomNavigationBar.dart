import 'dart:async';
import 'dart:developer';

import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gftr/Helper/appConfig.dart';
import 'package:gftr/Helper/colorConstants.dart';
import 'package:gftr/Helper/imageConstants.dart';
import 'package:gftr/View/Screens/ManageBottom/gftrStoryViewPage.dart';
import 'package:gftr/View/Screens/google.dart';
import 'package:badges/badges.dart' as badges;
import 'package:gftr/View/Widgets/customLoader.dart';

import '../../ViewModel/Cubits/Msgnotifications.dart';

class BottomNavBar extends StatefulWidget {
  List<Widget> screenList = [];
  int screenMange;
  int selectedIndex;
  final Widget? screenextra;
  BottomNavBar(
      {Key? key,
      required this.selectedIndex,
      required this.screenList,
      required this.screenMange,
      this.screenextra})
      : super(key: key);
  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar>
    with TickerProviderStateMixin {
  int curIndex = 0;
  late AnimationController _fabAnimationController;
  late AnimationController _borderRadiusAnimationController;
  late Animation<double> fabAnimation;
  late Animation<double> borderRadiusAnimation;
  late CurvedAnimation fabCurve;
  late CurvedAnimation borderRadiusCurve;
  late AnimationController _hideBottomBarAnimationController;
  @override
  void initState() {
    super.initState();
    _fabAnimationController = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );
    _borderRadiusAnimationController = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );
    fabCurve = CurvedAnimation(
      parent: _fabAnimationController,
      curve: const Interval(0.5, 1.0, curve: Curves.fastOutSlowIn),
    );
    borderRadiusCurve = CurvedAnimation(
      parent: _borderRadiusAnimationController,
      curve: const Interval(0.5, 1.0, curve: Curves.fastOutSlowIn),
    );
    fabAnimation = Tween<double>(begin: 0, end: 1).animate(fabCurve);
    borderRadiusAnimation = Tween<double>(begin: 0, end: 1).animate(
      borderRadiusCurve,
    );
    _hideBottomBarAnimationController = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );
    Future.delayed(
      const Duration(seconds: 1),
      () => _fabAnimationController.forward(),
    );
    Future.delayed(
      const Duration(seconds: 1),
      () => _borderRadiusAnimationController.forward(),
    );
  }

  bool onScrollNotification(ScrollNotification notification) {
    if (notification is UserScrollNotification &&
        notification.metrics.axis == Axis.vertical) {
      switch (notification.direction) {
        case ScrollDirection.forward:
          _hideBottomBarAnimationController.reverse();
          _fabAnimationController.forward(from: 0);
          break;
        case ScrollDirection.reverse:
          _hideBottomBarAnimationController.forward();
          _fabAnimationController.reverse(from: 1);
          break;
        case ScrollDirection.idle:
          break;
      }
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        extendBody: true,
        body: NavigationScreen(
          selectedIndex: widget.selectedIndex,
          index: widget.screenMange,
          screenList: widget.screenList,
          screenextra: widget.screenextra ?? Container(),
        ));
  }
}

class NavigationScreen extends StatefulWidget {
  List<Widget> screenList = [];
  Widget screenextra;
  int selectedIndex;
  int index;
  NavigationScreen(
      {required this.index,
      required this.screenList,
      required this.screenextra,
      required this.selectedIndex});

  @override
  _NavigationScreenState createState() => _NavigationScreenState();
}

class _NavigationScreenState extends State<NavigationScreen>
    with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    if (widget.selectedIndex != 4) {
      if (widget.index == 0) {
        return widget.screenList[0];
      } else if (widget.index == 1) {
        return widget.screenList[1];
      } else if (widget.index == 2) {
        defauilUrl = "https://www.google.com";
        return widget.screenList[2];
      } else if (widget.index == 3) {
        return widget.screenList[3];
      } else {
        return Container(
          color: Colors.green,
        );
      }
    } else {
      return widget.screenextra;
    }
  }
}

class bottomNavigationBarManage extends StatefulWidget {
  int bottomindex;
  int selectedIndex;
  bool? backGroundColor = false;
  Function(int) onTap;
  bottomNavigationBarManage(
      {Key? key,
      required this.onTap,
      required this.selectedIndex,
      required this.bottomindex,
      this.backGroundColor})
      : super(key: key);

  @override
  State<bottomNavigationBarManage> createState() =>
      _bottomNavigationBarManageState();
}

class _bottomNavigationBarManageState extends State<bottomNavigationBarManage> {
  List<String> bottomTabs = [
    ImageConstants.get,
    ImageConstants.chat,
    ImageConstants.google,
    ImageConstants.give
  ];
  List<String> bottomGradientTabs = [
    ImageConstants.getGradient,
    ImageConstants.chatGradient,
    ImageConstants.googleGradient,
    ImageConstants.giveGradient
  ];
  final autoSizeGroup = AutoSizeGroup();
  List<String> bottomTabsName = ["Get", "Messages", "Google", "Give"];
  MessagnotiCubit messagnotiCubit = MessagnotiCubit();

  List badgescolors = [
    Colors.transparent,
    Colors.red,
    Colors.transparent,
    Colors.transparent,
  ];
  List badgescolors1 = [
    Colors.transparent,
    Colors.black,
    Colors.transparent,
    Colors.transparent,
  ];

  //
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    messagnotiCubit = BlocProvider.of<MessagnotiCubit>(context);
    messagnotiCubit.messages();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBottomNavigationBar.builder(
        itemCount: bottomTabsName.length,
        height: screenHeight(context, dividedBy: 10),
        tabBuilder: (int index, bool isActive) {
          return Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                    height: screenHeight(context, dividedBy: 30),
                    width: screenHeight(context, dividedBy: 30),
                    child: BlocBuilder<MessagnotiCubit, MessagnotiState>(
                      builder: (context, state) {
                        return messagnotiCubit.notifications?.data == 0 ||
                                messagnotiCubit.notifications?.data == null
                            ? widget.backGroundColor == true
                                ? Image.asset(bottomTabs[index],
                                    color: Colors.white)
                                : Image.asset(
                                    isActive
                                        ? bottomGradientTabs[index]
                                        : bottomTabs[index],
                                    // color: widget.backGroundColor == true
                                    //     ? Colors.white
                                    //     : Colors.black,
                                  )
                            : badges.Badge(
                                badgeStyle: badges.BadgeStyle(
                                    badgeColor: badgescolors[index]),
                                badgeAnimation: badges.BadgeAnimation.fade(
                                  animationDuration:
                                      Duration(milliseconds: 100),
                                  toAnimate: true,
                                  loopAnimation: false,
                                  curve: Curves.linear,
                                ),
                                badgeContent: Text(
                                  messagnotiCubit.notifications?.data
                                          .toString() ??
                                      '0',
                                  style: TextStyle(color: badgescolors1[index]),
                                ),
                                child: widget.backGroundColor == true
                                    ? Image.asset(
                                        bottomTabs[index],
                                        color: Colors.white,
                                      )
                                    : Image.asset(
                                        isActive
                                            ? bottomGradientTabs[index]
                                            : bottomTabs[index],
                                        // color: widget.backGroundColor==true? Colors.white:Colors.black,
                                      ));
                      },
                    )
                    // Image.asset(
                    //   isActive || widget.backGroundColor==true ?  bottomGradientTabs[index] : bottomTabs[index],
                    // //  color: widget.backGroundColor==true? Colors.white:Colors.black,
                    // )
                    ),
                const SizedBox(height: 4),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8),
                  child: widget.backGroundColor == true
                      ? AutoSizeText(bottomTabsName[index],
                          maxLines: 1,
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight:
                                  isActive ? FontWeight.bold : FontWeight.w400),
                          group: autoSizeGroup)
                      : ShaderMask(
                          shaderCallback: (Rect bounds) {
                            return LinearGradient(
                              colors: [Color(0xffF37A5B), Color(0xff119BAA)],
                            ).createShader(bounds);
                          },
                          child: AutoSizeText(bottomTabsName[index],
                              maxLines: 1,
                              style: TextStyle(
                                  color: isActive
                                      ? Colors.white
                                      : widget.backGroundColor == true
                                          ? Colors.white
                                          : Colors.black,
                                  fontWeight: isActive
                                      ? FontWeight.bold
                                      : FontWeight.w400),
                              group: autoSizeGroup),
                        ),
                )
              ]);
        },
        splashRadius: 2,
        backgroundColor:
            widget.backGroundColor == true ? Colors.black : Colors.white,
        activeIndex: widget.selectedIndex == 4 ? 4 : widget.bottomindex,
        splashColor: Colors.orange,
        elevation: 0,
        splashSpeedInMilliseconds: 300,
        notchSmoothness: NotchSmoothness.defaultEdge,
        gapLocation: GapLocation.center,
        leftCornerRadius: 15,
        rightCornerRadius: 15,
        onTap: widget.onTap,
        shadow: const BoxShadow(
          offset: Offset(0, 1),
          blurRadius: 5,
          spreadRadius: 0.5,
          color: ColorCodes.greyDetailBox,
        ));
  }
}
