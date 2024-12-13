import 'package:flutter/material.dart';
import 'package:gftr/Helper/appConfig.dart';
import 'package:gftr/Helper/imageConstants.dart';
import 'package:gftr/View/Screens/ManageBottom/articlsviewpage.dart';
import 'package:gftr/View/Screens/ManageBottom/evenclalenderview.dart';
import 'package:gftr/View/Screens/ManageBottom/gftrStoryViewPage.dart';
import 'package:gftr/View/Screens/ManageBottom/notificationpageview.dart';
import 'package:gftr/View/Widgets/customText.dart';


AppBar appBar(
    BuildContext context, {
      bool calender = false,
      bool searchbar = false,
      int value = 1,
      bool notification = false,

    }) {
  return
    AppBar(
      leading: Builder(builder: (context) {
        return Padding(
          padding: EdgeInsets.all(15),
          child: GestureDetector(
            onTap: () {
              Scaffold.of(context).openDrawer();
            },
            child: SizedBox(
                height: screenHeight(context, dividedBy: 40),
                width: screenHeight(context, dividedBy: 40),
                child: Image.asset(
                  ImageConstants.sideMenu,
                  color: Colors.white,
                )),
          ),
        );
      }),
      backgroundColor: Colors.black,
      centerTitle: true,
      //elevation: 0,
      automaticallyImplyLeading: false,
      title: bottombarblack == true
          ? SizedBox()
          : GestureDetector(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => GfterStoryViewPage(),
              ));
          bottombarblack = true;
        },
        child: SizedBox(
            height: screenHeight(context, dividedBy: 30),
            // width: screenWidth(context,dividedBy: 20),
            child: Image.asset(
              ImageConstants.gftrBlack,
              color: Colors.white,
            )),
      ),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          bottom: Radius.circular(31),
        ),
      ),
      actions: [
        value >= 1 && notification == true ? GestureDetector(
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => NotificationPageView()));
              bottombarblack = false;
            },
            child:Center(child: Container(
              height: screenHeight(context,dividedBy: 20),
              width: screenWidth(context,dividedBy:20),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.white),
                  shape: BoxShape.circle
              ),
              child: Center(child: customText("${value.toString()}", Colors.white, 10, FontWeight.w100, "poppins")),
            )
              // customText("1", Colors.white, 15, FontWeight.w100, poppins)
            )


        ) : SizedBox(),

        SizedBox(
          width: screenWidth(context, dividedBy: 45),
        ),
        calender == true
            ? GestureDetector(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return CalanderViewPage(appbarIs: false);
                  },
                ));
          },
          child: SizedBox(
              height: screenHeight(context, dividedBy: 40),
              width: screenHeight(context, dividedBy: 40),
              child: Image.asset(
                ImageConstants.calenderGradient,
                color: Colors.white,
              )),
        )
            : SizedBox(),
        SizedBox(
          width: screenWidth(context, dividedBy: 30),
        ),

        GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => ArticlsViewPage()),
            );
            isSearchbar = false;
            bottombarblack = false;
          },
          child: Padding(
            padding: EdgeInsets.only(
                right: screenWidth(context, dividedBy: 13)),
            child: Container(
              // height: screenHeight(context, dividedBy: 30),
              child: Image.asset(ImageConstants.search,
                  height: screenHeight(context, dividedBy: 30),
                  width: screenWidth(context, dividedBy: 22)),
            ),
          ),
        )

      ],
    );
}
