import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gftr/Helper/imageConstants.dart';
import 'package:gftr/View/Screens/ManageBottom/gftrStoryViewPage.dart';
import 'package:gftr/View/Screens/getGifting.dart';
import 'package:gftr/View/Screens/google.dart';
import 'package:gftr/View/Screens/inbox.dart';
import 'package:gftr/View/Widgets/bottomNavigationBar.dart';
import 'package:gftr/View/Widgets/drawer.dart';
import 'package:gftr/View/Widgets/roundedAppBar.dart';
import 'package:gftr/ViewModel/Cubits/Msgnotifications.dart';
import 'package:gftr/ViewModel/Cubits/groupnotificationreply.dart';
import '../getgiftedPrivate.dart';

class GetGiftedPrivateViewPage extends StatefulWidget {
  int indexdata;
  GetGiftedPrivateViewPage({Key? key, required this.indexdata})
      : super(key: key);

  @override
  State<GetGiftedPrivateViewPage> createState() =>
      _GetGiftedPrivateViewPageState();
}

class _GetGiftedPrivateViewPageState extends State<GetGiftedPrivateViewPage> {
  int index = 0;
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
    setState(() {

    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar:  widget.indexdata == 2
            ? null
            : appBar(context, searchbar: true, calender: true,value: value),
        drawer: drawerWidget(context),
        floatingActionButton:widget.indexdata == 2
            ? null: FloatingActionButton(
            backgroundColor: Colors.transparent,
            child: Image.asset(ImageConstants.bottomNavFloat),
            onPressed: () {
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) => GfterStoryViewPage()));
              bottombarblack = true;
            }),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        bottomNavigationBar:widget.indexdata == 2
            ? null
            : bottomNavigationBarManage(
          backGroundColor: false,
          bottomindex: widget.indexdata,
          selectedIndex: 0,
          onTap: (index) {
            widget.indexdata = index;
            messagnotiCubit.messages();
            setState(() {});
          },
        ),
        body: BottomNavBar(
          selectedIndex: 0,
          screenList: const [
            GetGiftedPrivatePage(),
            InboxPage(),
            GooglePage(),
            GetGiftingPage()
          ],
          screenMange: widget.indexdata,
        ));
  }
}
