import 'package:flutter/material.dart';
import 'package:gftr/Helper/appConfig.dart';
import 'package:gftr/Helper/colorConstants.dart';
import 'package:gftr/View/Screens/aboutUs04.dart';
import 'package:gftr/View/Screens/aboutUs05.dart';
import 'package:gftr/View/Screens/aboutUs_03.dart';
import 'package:gftr/View/Screens/aboutUs_2.dart';
import 'package:gftr/View/Screens/allabout5.dart';
import 'package:gftr/View/Screens/allaboutUs6.dart';
import 'package:gftr/View/Screens/allaboutUs7.dart';

late int pageViewIndex;

class AboutUsPageView extends StatefulWidget {
  final bool isFromLogin; // Another example parameter

  const AboutUsPageView({
    Key? key,
    this.isFromLogin = false,
  }) : super(key: key);

  @override
  State<AboutUsPageView> createState() => _AboutUsPageViewState();
}

class _AboutUsPageViewState extends State<AboutUsPageView>
    with TickerProviderStateMixin {
  late TabController tabController;
  bool showDots = true; // State to track dot visibility

  @override
  void initState() {
    super.initState();
    tabController =
        TabController(length: 7, vsync: this, initialIndex: pageViewIndex);

    // Add a listener to update the showDots state
    tabController.addListener(() {
      setState(() {
        // Hide dots if on the 7th screen (index 6)
        showDots = tabController.index < 6;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(
          alignment: Alignment.center,
          children: [
            // Main TabBarView for the screens
            TabBarView(controller: tabController, children: [
              AboutUs02(),
              AboutUs03(),
              AboutUs04(),
              AboutUs05(),
              AllAboutUs05(),
              AllAboutUs06(),
              AllAboutUs07(
                isFromMenu: !widget.isFromLogin,
              ),
            ]),
            // Show or hide the dots using the updated showDots state
            if (showDots)
              Positioned(
                bottom: 25.0,
                child: Padding(
                  padding: EdgeInsets.only(
                      bottom: screenHeight(context, dividedBy: 21)),
                  child: TabPageSelector(
                    color: ColorCodes.lightGrey,
                    borderStyle: BorderStyle.none,
                    indicatorSize: 6,
                    selectedColor: ColorCodes.teal,
                    controller: tabController,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}


// class _AboutUsPageViewState extends State<AboutUsPageView>
//     with TickerProviderStateMixin {
//   TabController? tabController;

//   @override
//   void initState() {
//     super.initState();
//     tabController =
//         TabController(length: 7, vsync: this, initialIndex: pageViewIndex);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: Scaffold(
//         body: Stack(
//           alignment: Alignment.center,
//           children: [
//             TabBarView(controller: tabController, children: const [
//               AboutUs02(),
//               AboutUs03(),
//               AboutUs04(),
//               AboutUs05(),
//               AllAboutUs05(),
//               AllAboutUs06(),
//               AllAboutUs07(),
//             ]),
//             tabController!.index > 7
//                 ? SizedBox()
//                 : Positioned(
//                     bottom: 25.0,
//                     // alignment: Alignment.bottomCenter,
//                     child: Padding(
//                       padding: EdgeInsets.only(
//                           bottom: screenHeight(context, dividedBy: 21)),
//                       child: TabPageSelector(
//                         color: ColorCodes.lightGrey,
//                         borderStyle: BorderStyle.none,
//                         indicatorSize: 6,
//                         selectedColor: ColorCodes.teal,
//                         controller: tabController,
//                       ),
//                     ),
//                   )
//           ],
//         ),
//       ),
//     );
//   }
// }
