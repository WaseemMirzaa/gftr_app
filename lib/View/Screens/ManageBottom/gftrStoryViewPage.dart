import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gftr/Helper/imageConstants.dart';
import 'package:gftr/View/Screens/ManageBottom/articlsviewpage.dart';
import 'package:gftr/View/Screens/getGifting.dart';
import 'package:gftr/View/Screens/getgiftedPublic.dart';
import 'package:gftr/View/Screens/gftrStories.dart';
import 'package:gftr/View/Screens/google.dart';
import 'package:gftr/View/Screens/inbox.dart';
import 'package:gftr/View/Widgets/bottomNavigationBar.dart';
import 'package:gftr/View/Widgets/drawer.dart';
import 'package:gftr/View/Widgets/roundedAppBar.dart';
import 'package:gftr/ViewModel/Cubits/Msgnotifications.dart';
import 'package:gftr/ViewModel/Cubits/groupnotificationreply.dart';
import 'package:gftr/ViewModel/Cubits/setting_cubit.dart';
import 'package:gftr/ViewModel/Cubits/viewsetting.dart';

bool bottombarblack = true;


class GfterStoryViewPage extends StatefulWidget {
  GfterStoryViewPage({Key? key}) : super(key: key);
  @override
  State<GfterStoryViewPage> createState() => _GfterStoryViewPageState();
}

class _GfterStoryViewPageState extends State<GfterStoryViewPage> {
  int indexdata = 0;
  int selectedIndex = 4;
  SettingCubit settingCubit =SettingCubit();
  ViewSettingCubit viewSettingCubit =ViewSettingCubit();
  GroupReplyNotificationCubit groupReplyNotificationCubit = GroupReplyNotificationCubit();
  MessagnotiCubit messagnotiCubit = MessagnotiCubit();
  int value = 0;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    settingCubit = BlocProvider.of<SettingCubit>(context);
    viewSettingCubit = BlocProvider.of<ViewSettingCubit>(context);
    groupReplyNotificationCubit = BlocProvider.of<GroupReplyNotificationCubit>(context);
    messagnotiCubit = BlocProvider.of<MessagnotiCubit>(context);
    messagnotiCubit.messages();
    viewSettingCubit.getviewSetting();
    groupReplyNotificationCubit.getgroupRequestReplyNotification();
    value = groupReplyNotificationCubit.groupRequestReplyNotification?.groupRequestReply?.length.toInt() ?? 0;

  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: indexdata == 2
            ? null
            : appBar(context, searchbar: true, calender: true,value: value,notification: false),
        drawer: drawerWidget(context),
        backgroundColor: bottombarblack == true ? Colors.black : Colors.white,
        floatingActionButton: indexdata == 2
            ? null
            : FloatingActionButton(
            backgroundColor: Colors.transparent,
            child: bottombarblack == true
                ? Image.asset(ImageConstants.gftrRoundBlack)
                : Image.asset(ImageConstants.bottomNavFloat),
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => GfterStoryViewPage(),
                ),
              );
              bottombarblack = true;
              isSearchbar = true;
            }),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        bottomNavigationBar: indexdata == 2
            ? null
            : bottomNavigationBarManage(
          backGroundColor: bottombarblack,
          selectedIndex: selectedIndex,
          bottomindex: indexdata,
          onTap: (index) {
            indexdata = index;
            selectedIndex = indexdata;
            bottombarblack = false;
            isSearchbar = true;
            messagnotiCubit.messages();
            setState(() {});
          },
        ),
        body: BottomNavBar(
          selectedIndex: selectedIndex,
          screenList: [
            GetGiftedPublicPage(),
            InboxPage(),
            GooglePage(),
            GetGiftingPage()
          ],
          screenMange: indexdata,
          screenextra: GfterStories(),
        ));
  }
}
