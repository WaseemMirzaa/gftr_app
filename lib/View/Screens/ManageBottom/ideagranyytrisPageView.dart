import 'package:flutter/material.dart';
import 'package:gftr/Helper/imageConstants.dart';
import 'package:gftr/View/Screens/ManageBottom/gftrStoryViewPage.dart';
import 'package:gftr/View/Screens/getGifting.dart';
import 'package:gftr/View/Screens/getgiftedPublic.dart';
import 'package:gftr/View/Screens/google.dart';
import 'package:gftr/View/Screens/ideagrannyTrish.dart';
import 'package:gftr/View/Screens/inbox.dart';
import 'package:gftr/View/Widgets/bottomNavigationBar.dart';
import 'package:gftr/View/Widgets/drawer.dart';
import 'package:gftr/View/Widgets/roundedAppBar.dart';

import '../../../Model/groups.dart';



class IdeaGrannyTrishViePage extends StatefulWidget {
  String Groupsname;
  List<Myidea>? PublicData;

  IdeaGrannyTrishViePage({Key? key ,required this.Groupsname,required this.PublicData}) : super(key: key);

  @override
  State<IdeaGrannyTrishViePage> createState() => _IdeaGrannyTrishViePageState();
}

class _IdeaGrannyTrishViePageState extends State<IdeaGrannyTrishViePage> {
  int indexdata = 0;int selectedIndex = 4;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: indexdata == 2
            ? null
            : appBar(context, searchbar: true, calender: true),
        drawer: drawerWidget(context),floatingActionButton:indexdata == 2
        ? null
        : FloatingActionButton(
        backgroundColor: Colors.transparent,
        child: Image.asset(ImageConstants.bottomNavFloat),
        onPressed: () {
          // _handleSignIn();
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) =>  GfterStoryViewPage()));     bottombarblack = true;
        }),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        bottomNavigationBar:indexdata == 2
            ? null
            : bottomNavigationBarManage(bottomindex: indexdata, selectedIndex: selectedIndex,
          onTap: (index) {
            indexdata = index;
            selectedIndex=indexdata;
            setState(() {});
          },
        ),
        body: BottomNavBar(selectedIndex: selectedIndex,
          screenextra: IdeaGrannyTrish(PublicData: widget.PublicData ?? [],name: widget.Groupsname ?? ''),
          screenList:  [
            GetGiftedPublicPage(),
            InboxPage(),
            GooglePage(),
            GetGiftingPage()
          ],
          screenMange: indexdata,
        ));
  }
}
