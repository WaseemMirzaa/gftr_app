import 'package:flutter/material.dart';

import 'package:gftr/Helper/imageConstants.dart';
import 'package:gftr/View/Screens/GiftDetails.dart';

import 'package:gftr/View/Screens/ManageBottom/gftrStoryViewPage.dart';
import 'package:gftr/View/Screens/getGifting.dart';
import 'package:gftr/View/Screens/getgiftedPublic.dart';
import 'package:gftr/View/Screens/google.dart';
import 'package:gftr/View/Screens/inbox.dart';
import 'package:gftr/View/Widgets/bottomNavigationBar.dart';
import 'package:gftr/View/Widgets/drawer.dart';

import 'package:gftr/View/Widgets/roundedAppBar.dart';

bool isSearchbar = true;
bool isIcon = true;

class giftr_details extends StatefulWidget {
  int cur;
  giftr_details(this.cur);

  @override
  State<giftr_details> createState() => _giftr_detailsState();
}

class _giftr_detailsState extends State<giftr_details> {
  int indexdata = 0;
  int selectedIndex = 4;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: indexdata == 2
            ? null
            : appBar(context, searchbar: true, calender: true),
        drawer: drawerWidget(context),
        floatingActionButton: isIcon == true
            ? indexdata == 2
                ? null
                : FloatingActionButton(
            backgroundColor: Colors.transparent,
                    child: Image.asset(ImageConstants.bottomNavFloat),
                    onPressed: () {
                      // _handleSignIn();
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => GfterStoryViewPage()));
                      selectedIndex = 4;
                      bottombarblack = true;
                    })
            : null,
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        bottomNavigationBar: indexdata == 2
            ? null
            : bottomNavigationBarManage(
                selectedIndex: selectedIndex,
                bottomindex: indexdata,
                onTap: (index) {
                  indexdata = index;
                  selectedIndex = indexdata;
                  isSearchbar = true;
                  setState(() {});
                },
              ),
        body: BottomNavBar(
          selectedIndex: selectedIndex,
          screenextra: Gift_Ditails(widget.cur),
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
