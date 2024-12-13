import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gftr/Helper/apiConstants.dart';
import 'package:gftr/Helper/appConfig.dart';
import 'package:gftr/Helper/colorConstants.dart';
import 'package:gftr/Helper/imageConstants.dart';
import 'package:gftr/View/Widgets/customLoader.dart';
import 'package:gftr/View/Widgets/customText.dart';
import 'package:gradient_borders/box_borders/gradient_box_border.dart';
import '../../ViewModel/Cubits/groupnotificationreply.dart';

class NotificationPage extends StatefulWidget {
  const NotificationPage({Key? key}) : super(key: key);

  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  List<BoxShadow> shadow = [
     BoxShadow(color: Colors.grey, offset: Offset(0.0, 1.0), blurRadius: 3)
  ];
  LinearGradient coralTealColor = const LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [ColorCodes.coral, ColorCodes.teal],
  );
  GroupReplyNotificationCubit groupReplyNotificationCubit = GroupReplyNotificationCubit();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    groupReplyNotificationCubit = BlocProvider.of<GroupReplyNotificationCubit>(context);
    groupReplyNotificationCubit.getgroupRequestReplyNotification();
    setState(() {

    });
  }
  @override
  Widget build(BuildContext context) {
    return  BlocBuilder<GroupReplyNotificationCubit, GroupReplyNotificationState>(
        builder: (context, state) {
          log("GroupRequestReplyNotification $state");
          if (state is GroupReplyNotificationLoading) {
            return Center(
              child: spinkitLoader(context, ColorCodes.coral),
            );
          } else if (state is GroupReplyNotificationError) {
            return Center(
                child: customText("No Data Found!", Colors.black, 14,
                    FontWeight.w300, poppins));
          } else if (state is GroupReplyNotificationSuccess) {
            return groupReplyNotificationCubit
                .groupRequestReplyNotification?.groupRequestReply!=null? ListView.builder(
                itemCount: groupReplyNotificationCubit
                    .groupRequestReplyNotification?.groupRequestReply?.length,
                shrinkWrap: true,
                padding: EdgeInsets.only(top: screenHeight(context,dividedBy: 20)),
                itemBuilder: (context, index) {
                  return Column(children: [
                    Container(
                      height: screenHeight(context, dividedBy: 10),
                      width: screenWidth(context, dividedBy: 1.1),
                      decoration: BoxDecoration(
                          boxShadow: shadow,
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10)),
                      child: Column(
                        children: [
                          SizedBox(
                            height: screenHeight(context, dividedBy: 90),
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              SizedBox(
                                width:
                                screenWidth(context, dividedBy: 50),
                              ),
                              Container(
                                height:
                                screenHeight(context, dividedBy: 15),
                                width:
                                screenHeight(context, dividedBy: 15),
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    border: GradientBoxBorder(
                                        width: 2,
                                        gradient: coralTealColor)),
                                child: ClipRRect(
                                    borderRadius:
                                    BorderRadius.circular(100),
                                    child: Image.network(
                                      "${ApiConstants.baseUrlsSocket}${groupReplyNotificationCubit.groupRequestReplyNotification?.groupRequestReply?[index].avatar}",
                                      fit: BoxFit.cover,
                                    )),
                              ),
                              SizedBox(
                                width:
                                screenWidth(context, dividedBy: 50),
                              ),
                              SizedBox(
                                width:
                                screenWidth(context, dividedBy: 1.8),
                                child: customText(
                                    groupReplyNotificationCubit
                                        .groupRequestReplyNotification
                                        ?.groupRequestReply?[index].text??
                                        '',
                                    Colors.black,
                                    13,
                                    FontWeight.w400,
                                    poppins,
                                    maxLines: 2),
                              ),
                              SizedBox(
                                width:
                                screenWidth(context, dividedBy: 50),
                              ),
                              customText(groupReplyNotificationCubit
                                  .groupRequestReplyNotification
                                  ?.groupRequestReply?[index].restime.toString()??
                                  '', ColorCodes.greyText, 12,
                                  FontWeight.w500, poppins),
                            ],
                          ),

                        ],
                      ),
                    ),
                    SizedBox(
                      height: screenHeight(context, dividedBy: 50),
                    )
                  ]);
                }):  Expanded(
                  child: Center(
                    child: customText("No Notification ", ColorCodes.greyText, 15,
                    FontWeight.w500, poppins),
                  ),
                );
          }
          return Container();
        });
  }
}
