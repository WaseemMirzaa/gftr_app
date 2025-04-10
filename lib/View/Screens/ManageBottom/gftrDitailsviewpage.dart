import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gftr/Helper/imageConstants.dart';
import 'package:gftr/View/Screens/ManageBottom/gftrStoryViewPage.dart';
import 'package:gftr/View/Screens/getGifting.dart';
import 'package:gftr/View/Screens/getgiftedPublic.dart';
import 'package:gftr/View/Screens/gftrDetails.dart';
import 'package:gftr/View/Screens/google.dart';
import 'package:gftr/View/Screens/inbox.dart';
import 'package:gftr/View/Widgets/bottomNavigationBar.dart';
import 'package:gftr/View/Widgets/drawer.dart';
import 'package:gftr/View/Widgets/roundedAppBar.dart';
import 'package:gftr/ViewModel/Cubits/Msgnotifications.dart';
import 'package:gftr/ViewModel/Cubits/groupnotificationreply.dart';


class GftrDetailsViewPage extends StatefulWidget {
  String image;
  String id;
  String nots;
  String name;
  String title;
  String price,url;
  GftrDetailsViewPage(
      {Key? key,
      required this.image,
      required this.name,
        required this.id,
      required this.nots,
      required this.price,
      required this.url,
      required this.title})
      : super(key: key);

  @override
  State<GftrDetailsViewPage> createState() => _GftrDetailsViewPageState();
}

class _GftrDetailsViewPageState extends State<GftrDetailsViewPage> {
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
            backgroundColor: Colors.transparent,
                child: Image.asset(ImageConstants.bottomNavFloat),
                onPressed: () {
                  // _handleSignIn();
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => GfterStoryViewPage()));
                  bottombarblack = true;
                }),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        bottomNavigationBar: indexdata == 2
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
          screenextra:  GftrDetails( title: widget.title,name:widget.name ,
            image:  widget.image ,
            weburl: widget.url,
            id:widget.id,
            price: widget.price,
            nots: widget.nots),
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
