import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gftr/Helper/imageConstants.dart';
import 'package:gftr/Model/groups.dart';
import 'package:gftr/View/Screens/ManageBottom/gftrStoryViewPage.dart';
import 'package:gftr/View/Screens/getGifting.dart';
import 'package:gftr/View/Screens/getgiftedPublic.dart';
import 'package:gftr/View/Screens/gftrGrannyTrish.dart';
import 'package:gftr/View/Screens/google.dart';
import 'package:gftr/View/Screens/inbox.dart';
import 'package:gftr/View/Widgets/bottomNavigationBar.dart';
import 'package:gftr/View/Widgets/drawer.dart';
import 'package:gftr/View/Widgets/roundedAppBar.dart';
import 'package:gftr/ViewModel/Cubits/Msgnotifications.dart';
import 'package:gftr/ViewModel/Cubits/groupnotificationreply.dart';


class GrannyTrishViePage extends StatefulWidget {
  String? groupName;
  List<Myidea>? gifts;
  List<Myidea>? PublicData;
  String? Adress;
  GrannyTrishViePage(
      {Key? key,  this.groupName,  this.gifts,this.Adress,this.PublicData})
      : super(key: key);

  @override
  State<GrannyTrishViePage> createState() => _GrannyTrishViePageState();
}

class _GrannyTrishViePageState extends State<GrannyTrishViePage> {
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
        floatingActionButton: indexdata == 2
            ? null
            : FloatingActionButton(
                backgroundColor: Colors.blue,

                child: Image.asset(ImageConstants.bottomNavFloat),
                onPressed: () {
                  // _handleSignIn();
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => GfterStoryViewPage()));
                  bottombarblack = true;
                }),
        floatingActionButtonLocation: FloatingActionButtonLocation.miniCenterDocked,
        resizeToAvoidBottomInset: false,
        bottomNavigationBar: indexdata == 2
            ? null
            : bottomNavigationBarManage(
                bottomindex: indexdata,
                selectedIndex: selectedIndex,
                onTap: (index) {
                  indexdata = index;
                  selectedIndex = indexdata;
                  messagnotiCubit.messages();
                  setState(() {});
                },
              ),
        body: BottomNavBar(
          selectedIndex: selectedIndex,
          screenextra: GftrGrannyTrish(
              groupName: widget.groupName??'', gifts: widget.gifts??[], Add: widget.Adress ?? '',PublicData:widget.PublicData ?? []),
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
