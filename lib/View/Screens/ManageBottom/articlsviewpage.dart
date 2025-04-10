import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:gftr/Helper/imageConstants.dart';

import 'package:gftr/View/Screens/ManageBottom/gftrStoryViewPage.dart';
import 'package:gftr/View/Screens/articles.dart';
import 'package:gftr/View/Screens/getGifting.dart';
import 'package:gftr/View/Screens/getgiftedPublic.dart';
import 'package:gftr/View/Screens/google.dart';
import 'package:gftr/View/Screens/inbox.dart';
import 'package:gftr/View/Widgets/bottomNavigationBar.dart';
import 'package:gftr/View/Widgets/drawer.dart';

import 'package:gftr/View/Widgets/roundedAppBar.dart';
import 'package:gftr/ViewModel/Cubits/Msgnotifications.dart';

import '../../../ViewModel/Cubits/groupnotificationreply.dart';

bool isSearchbar = true;
bool isIcon = true;

class ArticlsViewPage extends StatefulWidget {
  const ArticlsViewPage({Key? key}) : super(key: key);

  @override
  State<ArticlsViewPage> createState() => _ArticlsViewPageState();
}

class _ArticlsViewPageState extends State<ArticlsViewPage> {
  int indexdata = 0;
  int selectedIndex = 4;
  MessagnotiCubit messagnotiCubit = MessagnotiCubit();
  GroupReplyNotificationCubit groupReplyNotificationCubit = GroupReplyNotificationCubit();
  int value = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    messagnotiCubit = BlocProvider.of<MessagnotiCubit>(context);
    messagnotiCubit.messages();
    groupReplyNotificationCubit = BlocProvider.of<GroupReplyNotificationCubit>(context);
    groupReplyNotificationCubit.getgroupRequestReplyNotification();
    value = groupReplyNotificationCubit.groupRequestReplyNotification?.groupRequestReply?.length.toInt() ?? 0;
    setState(() {});
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: indexdata == 2
            ? null
            : appBar(context, searchbar: true, calender: true,value: value),
        drawer: drawerWidget(context),
        floatingActionButton: isIcon == true
            ?indexdata == 2
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
        bottomNavigationBar:indexdata == 2
            ? null
            : bottomNavigationBarManage(
          selectedIndex: selectedIndex,
          bottomindex: indexdata,
          onTap: (index) {
            indexdata = index;
            selectedIndex = indexdata;
            isSearchbar = true;
            messagnotiCubit.messages();
            setState(() {});
          },
        ),
        body:  BottomNavBar(
          selectedIndex: selectedIndex,
          screenextra: const ArticlesPage(),
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
