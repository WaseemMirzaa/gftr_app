
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:gftr/Helper/imageConstants.dart';

import 'package:gftr/View/Screens/ManageBottom/gftrStoryViewPage.dart';
import 'package:gftr/View/Screens/getGifting.dart';
import 'package:gftr/View/Screens/getgiftedPublic.dart';
import 'package:gftr/View/Screens/google.dart';
import 'package:gftr/View/Screens/inbox.dart';
import 'package:gftr/View/Screens/notificationPage.dart';
import 'package:gftr/View/Screens/settings.dart';
import 'package:gftr/View/Widgets/bottomNavigationBar.dart';
import 'package:gftr/View/Widgets/drawer.dart';

import 'package:gftr/View/Widgets/roundedAppBar.dart';
import 'package:gftr/ViewModel/Cubits/Msgnotifications.dart';
import 'package:gftr/ViewModel/Cubits/groupnotificationreply.dart';


class NotificationPageView extends StatefulWidget {
  const NotificationPageView({Key? key}) : super(key: key);

  @override
  State<NotificationPageView> createState() => _NotificationPageViewState();
}

class _NotificationPageViewState extends State<NotificationPageView> {
  int indexdata = 0;
  int selectedIndex = 4;
  GroupReplyNotificationCubit groupReplyNotificationCubit = GroupReplyNotificationCubit();
  MessagnotiCubit messagnotiCubit = MessagnotiCubit();
  int value = 0;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    groupReplyNotificationCubit = BlocProvider.of<GroupReplyNotificationCubit>(context);
    messagnotiCubit = BlocProvider.of<MessagnotiCubit>(context);
    messagnotiCubit.messages();
    groupReplyNotificationCubit.getgroupRequestReplyNotification();
    value = groupReplyNotificationCubit.groupRequestReplyNotification?.groupRequestReply?.length.toInt() ?? 0;
    setState(() {});
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar:  indexdata == 2
            ? null
            : appBar(context, searchbar: true, calender: true,notification: false),
        drawer: drawerWidget(context),
        floatingActionButton:indexdata == 2
            ? null
            : FloatingActionButton(
            backgroundColor: Colors.blue,
            child: Image.asset(ImageConstants.bottomNavFloat),
            onPressed: () {
              // _handleSignIn();
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>  GfterStoryViewPage()));
              selectedIndex=4;
              bottombarblack = true;
            }),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        bottomNavigationBar:indexdata == 2
            ? null
            : bottomNavigationBarManage( selectedIndex: selectedIndex,
          bottomindex: indexdata,
          onTap: (index) {
            indexdata = index;
            selectedIndex = indexdata;
            messagnotiCubit.messages();
            setState(() {});
          },
        ),
        body: BottomNavBar(selectedIndex: selectedIndex,
          screenextra:   const   NotificationPage(),
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
