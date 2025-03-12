import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:gftr/Helper/imageConstants.dart';
import 'package:gftr/View/Screens/ManageBottom/articlsviewpage.dart';
import 'package:gftr/View/Screens/ManageBottom/gftrStoryViewPage.dart';
import 'package:gftr/View/Screens/getGifting.dart';
import 'package:gftr/View/Screens/getgiftedPublic.dart';
import 'package:gftr/View/Screens/google.dart';
import 'package:gftr/View/Screens/inbox.dart';
import 'package:gftr/View/Screens/settings.dart';
import 'package:gftr/View/Widgets/bottomNavigationBar.dart';
import 'package:gftr/View/Widgets/drawer.dart';
import 'package:gftr/View/Widgets/roundedAppBar.dart';
import 'package:gftr/ViewModel/Cubits/Msgnotifications.dart';
import 'package:gftr/ViewModel/Cubits/groupnotificationreply.dart';

class SetingViewPage extends StatefulWidget {
  const SetingViewPage({Key? key}) : super(key: key);

  @override
  State<SetingViewPage> createState() => _GetGiftingViewPageState();
}

class _GetGiftingViewPageState extends State<SetingViewPage> {
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
        appBar: indexdata == 2
            ? null
            : appBar(context, searchbar: true, calender: true,value: value),
        drawer: drawerWidget(context),
        floatingActionButton: isIcon == true
            ? indexdata == 2
            ? null
            :FloatingActionButton(
                backgroundColor: Colors.blue,
                child: Image.asset(ImageConstants.bottomNavFloat),
                onPressed: () {
                  Navigator.pushReplacement(
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
            messagnotiCubit.messages();
            setState(() {});
          },
        ),
        body: BottomNavBar(
                selectedIndex: selectedIndex,
                screenextra: const SettingsPage(),
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
