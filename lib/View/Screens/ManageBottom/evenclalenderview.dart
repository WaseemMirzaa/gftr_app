import 'package:flutter/material.dart';
import 'package:gftr/Helper/appConfig.dart';

import 'package:gftr/Helper/imageConstants.dart';
import 'package:gftr/View/Screens/EventCalendar.dart';
import 'package:gftr/View/Screens/ManageBottom/articlsviewpage.dart';
import 'package:gftr/View/Screens/ManageBottom/gftrStoryViewPage.dart';
import 'package:gftr/View/Screens/getGifting.dart';
import 'package:gftr/View/Screens/getgiftedPublic.dart';
import 'package:gftr/View/Screens/google.dart';
import 'package:gftr/View/Screens/inbox.dart';
import 'package:gftr/View/Widgets/bottomNavigationBar.dart';
import 'package:gftr/View/Widgets/drawer.dart';
import 'package:gftr/View/Widgets/roundedAppBar.dart';
bool _black = true;
class CalanderViewPage extends StatefulWidget {
  bool appbarIs;
  CalanderViewPage({Key? key, required this.appbarIs}) : super(key: key);

  @override
  State<CalanderViewPage> createState() => _CalanderViewPageState();
}

class _CalanderViewPageState extends State<CalanderViewPage> {
  int indexdata = 0;
  int selectedIndex = 4;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: widget.appbarIs == true
            ? indexdata == 2
            ? null
            : appBar(context, searchbar: true, calender: true)
            : null,
        drawer: drawerWidget(context),
        floatingActionButton: isIcon == true
            ? indexdata == 2
            ? null
            : FloatingActionButton(
            backgroundColor: Colors.blue,
            child: Image.asset(ImageConstants.bottomNavFloat),
            onPressed: () {
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) => GfterStoryViewPage()));
              bottombarblack = true;
            })
            : null,
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        bottomNavigationBar: indexdata == 2
            ? null
            : bottomNavigationBarManage(
          selectedIndex: selectedIndex,
          bottomindex: indexdata,
          backGroundColor: _black,
          onTap: (index) {
            indexdata = index;
            selectedIndex = indexdata;
            widget.appbarIs=true;
            _black = false;

            setState(() {});
          },
        ),
        body: BottomNavBar(
          selectedIndex: selectedIndex,
          screenextra: const EventCalendarScreen(),
          screenList: const [
            GetGiftedPublicPage(),
            InboxPage(),
            GooglePage(),
            GetGiftingPage()
          ],
          screenMange: indexdata,
        ));
  }
}
