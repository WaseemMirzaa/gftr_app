import 'dart:async';
import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gftr/Helper/apiConstants.dart';
import 'package:gftr/Helper/appConfig.dart';
import 'package:gftr/Helper/colorConstants.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:gftr/View/Screens/messages.dart';
import 'package:gftr/View/Widgets/customLoader.dart';
import 'package:gftr/View/Widgets/customText.dart';
import 'package:gftr/ViewModel/Cubits/GetGifted/getgiftedview_dart.dart';
import 'package:gftr/ViewModel/Cubits/Msgnotifications.dart';
import 'package:gftr/ViewModel/Cubits/getContact.dart';
import 'package:gftr/ViewModel/Cubits/groupscubit.dart';
import 'package:gftr/ViewModel/Cubits/notification.dart';
import 'package:gftr/ViewModel/Cubits/upatedinvet.dart';
import 'package:gradient_borders/box_borders/gradient_box_border.dart';
import 'package:uuid/uuid.dart';

class InboxPage extends StatefulWidget {
  const InboxPage({Key? key}) : super(key: key);

  static const route = "/inbox_page";

  @override
  State<InboxPage> createState() => _InboxPageState();
}

class _InboxPageState extends State<InboxPage> {
  List<BoxShadow> shadow = [
    const BoxShadow(color: Colors.grey, offset: Offset(0.0, 1.0), blurRadius: 3)
  ];

  LinearGradient coralTealColor = const LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [ColorCodes.coral, ColorCodes.teal],
  );
  late IO.Socket socket;
  NotificationViewCubit notificationViewCubit = NotificationViewCubit();
  UpadetInviteCubit upadetInviteCubit = UpadetInviteCubit();
  GroupViewCubit groupViewCubit = GroupViewCubit();
  GetContactViewCubit getContactViewCubit = GetContactViewCubit();
  GetGiftedViewCubit getGiftedViewCubit = GetGiftedViewCubit();
  MessagnotiCubit messagnotiCubit = MessagnotiCubit();
  StreamController<List<dynamic>> messageList =
      StreamController<List<dynamic>>();

  var uuid = Uuid();
  final dio = Dio();
  Timer? timer;
  void getHttp() async {
    final response = await dio.get(ApiConstants.msg_seen,
        options: Options(headers: {
          'Authorization': ' $authorization',
        }));
    print('Response status: ${response.statusCode}');
    print(response);
  }

  ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getHttp();
    notificationViewCubit = BlocProvider.of<NotificationViewCubit>(context);
    upadetInviteCubit = BlocProvider.of<UpadetInviteCubit>(context);
    groupViewCubit = BlocProvider.of<GroupViewCubit>(context);
    messagnotiCubit = BlocProvider.of<MessagnotiCubit>(context);
    groupViewCubit.getGroups();
    notificationViewCubit.getMyNotifitication();
    messagnotiCubit.messages();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: screenHeight(context),
        width: screenWidth(context),
        child: Column(children: [
          SizedBox(
            height: screenHeight(context, dividedBy: 30),
          ),
          SizedBox(
              width: screenWidth(context, dividedBy: 1.1),
              child: customText("Messages", Colors.black, 16, FontWeight.w500,
                  madeOuterSans)),
          Container(
            margin: EdgeInsets.only(top: 5),
            height: screenHeight(context, dividedBy: 2.9),
            child: BlocBuilder<GroupViewCubit, GroupViewState>(
                builder: (context, state) {
              if (state is GroupViewLoading) {
                return spinkitLoader(context, ColorCodes.coral);
              } else if (state is GroupViewSuccess) {
                return Scrollbar(
                  controller: _scrollController,
                  thickness: 8,
                  radius: Radius.circular(16),
                  //--------------------------------CLOSED BY ME------------------------------------------------
                  // isAlwaysShown: true,
                   thumbVisibility: true,
                  //--------------------------------CLOSED BY ME------------------------------------------------
                  child: ListView.builder(
                      controller: _scrollController,
                      physics: BouncingScrollPhysics(),
                      itemCount: groupViewCubit.groups?.groupDetails?.length,
                      shrinkWrap: true,
                      padding: const EdgeInsets.all(5),
                      itemBuilder: (context, index) {
                        return Column(
                          children: [
                            GestureDetector(
                              onTap: () async {
                                // String roomId = uuid.v1();
                                String refresh = await Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => MessagesPage(
                                              Avatar:
                                                  "${ApiConstants.baseUrlsSocket}${groupViewCubit.groups?.groupDetails?[index].avatar}",
                                              userName: groupViewCubit
                                                      .groups
                                                      ?.groupDetails?[index]
                                                      .name ??
                                                  '',
                                              userId: groupViewCubit
                                                      .groups?.loggedUser ??
                                                  '',
                                              targetId: groupViewCubit
                                                      .groups
                                                      ?.groupDetails?[index]
                                                      .id ??
                                                  "",
                                            )));
                                if (refresh == "refresh") {
                                  setState(() {
                                    messagnotiCubit.messages();
                                  });
                                }
                              },
                              child: Container(
                                  height: screenHeight(context, dividedBy: 12),
                                  width: screenWidth(context, dividedBy: 1.1),
                                  decoration: BoxDecoration(
                                      boxShadow: shadow,
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(10)),
                                  child: Row(children: [
                                    SizedBox(
                                      width:
                                          screenWidth(context, dividedBy: 50),
                                    ),
                                    Row(
                                      children: [
                                        Container(
                                          height: screenHeight(context,
                                              dividedBy: 15),
                                          width: screenHeight(context,
                                              dividedBy: 15),
                                          decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              border: GradientBoxBorder(
                                                  width: 2,
                                                  gradient: coralTealColor)),
                                          child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(100),
                                              child: Image.network(
                                                "${ApiConstants.baseUrlsSocket}${groupViewCubit.groups?.groupDetails?[index].avatar}",
                                                fit: BoxFit.cover,
                                              )),
                                        ),
                                        SizedBox(
                                          width: screenWidth(context,
                                              dividedBy: 50),
                                        ),
                                        Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              customText(
                                                  groupViewCubit
                                                          .groups
                                                          ?.groupDetails?[index]
                                                          .name ??
                                                      "",
                                                  Colors.black,
                                                  14,
                                                  FontWeight.w500,
                                                  poppins,
                                                  maxLines: 2),
                                              SizedBox(
                                                height: screenHeight(context,
                                                    dividedBy: 200),
                                              ),
                                              SizedBox(
                                                width: screenWidth(context,
                                                    dividedBy: 1.8),
                                                child: customText(
                                                    groupViewCubit
                                                            .groups
                                                            ?.groupDetails?[
                                                                index]
                                                            .phoneNumber
                                                            .toString() ??
                                                        "",
                                                    ColorCodes.greyText,
                                                    12,
                                                    FontWeight.w400,
                                                    poppins),
                                              )
                                            ])
                                      ],
                                    ),
                                    Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          customText("", ColorCodes.greyText,
                                              12, FontWeight.w500, poppins),
                                          SizedBox(
                                            height: screenHeight(context,
                                                dividedBy: 200),
                                          ),
                                          // index == 0?
                                          Container(
                                              height: screenHeight(context,
                                                  dividedBy: 50),
                                              width: screenHeight(context,
                                                  dividedBy: 50),
                                              alignment: Alignment.center,
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(3),
                                                  //color: ColorCodes.coral
                                                  color: Colors.white),
                                              child: Text(
                                                "",
                                                //  ( messagnotiCubit.notifications!.data == null) ? "0" : messagnotiCubit.notifications!.data.toString(),
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontFamily: poppins,
                                                    fontSize: 10),
                                              ))
                                          // : SizedBox(
                                          //     height: screenHeight(
                                          //         context,
                                          //         dividedBy: 60),
                                          //     width: screenHeight(context,
                                          //         dividedBy: 60),
                                          //   ),
                                        ])
                                  ])),
                            ),
                            SizedBox(
                              height: screenHeight(context, dividedBy: 50),
                            )
                          ],
                        );
                      }),
                );
              }
              return Container();
            }),
          ),
          SizedBox(
              width: screenWidth(context, dividedBy: 1.1),
              child: customText("Notifications", Colors.black, 16,
                  FontWeight.bold, madeOuterSans)),
          Expanded(
            child: BlocBuilder<NotificationViewCubit, NotificationViewState>(
                builder: (context, state) {
              log("Notification $state");
              if (state is NotificationViewLoading) {
                return Center(
                  child: spinkitLoader(context, ColorCodes.coral),
                );
              } else if (state is NotificationViewError) {
                return Expanded(
                  child: Center(
                      child: customText("No Data Found!", Colors.black, 14,
                          FontWeight.w300, poppins)),
                );
              } else if (state is NotificationViewSuccess) {
                return ListView.builder(
                    physics: BouncingScrollPhysics(),
                    itemCount: notificationViewCubit
                        .myNotifications?.receivedRequestBy?.length,
                    shrinkWrap: true,
                    padding: EdgeInsets.zero,
                    itemBuilder: (context, index) {
                      return Column(children: [
                        Container(
                          height: screenHeight(context, dividedBy: 7),
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
                                    width: screenWidth(context, dividedBy: 50),
                                  ),
                                  Container(
                                    height:
                                        screenHeight(context, dividedBy: 15),
                                    width: screenHeight(context, dividedBy: 15),
                                    decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        border: GradientBoxBorder(
                                            width: 2,
                                            gradient: coralTealColor)),
                                    child: ClipRRect(
                                        borderRadius:
                                            BorderRadius.circular(100),
                                        child: Image.network(
                                          "${ApiConstants.baseUrlsSocket}${notificationViewCubit.myNotifications?.receivedRequestBy?[index].avatar}",
                                          fit: BoxFit.cover,
                                        )),
                                  ),
                                  SizedBox(
                                    width: screenWidth(context, dividedBy: 50),
                                  ),
                                  SizedBox(
                                    width: screenWidth(context, dividedBy: 1.8),
                                    child: customText(
                                        notificationViewCubit
                                                .myNotifications
                                                ?.receivedRequestBy?[index]
                                                .text ??
                                            '',
                                        Colors.black,
                                        13,
                                        FontWeight.w400,
                                        poppins,
                                        maxLines: 2),
                                  ),
                                  SizedBox(
                                    width: screenWidth(context, dividedBy: 50),
                                  ),
                                  customText(
                                      notificationViewCubit
                                              .myNotifications
                                              ?.receivedRequestBy?[index]
                                              .rektime
                                              .toString() ??
                                          '',
                                      ColorCodes.greyText,
                                      12,
                                      FontWeight.w500,
                                      poppins),
                                ],
                              ),
                              Row(
                                children: [
                                  SizedBox(
                                    width: screenWidth(context, dividedBy: 7),
                                    height:
                                        screenHeight(context, dividedBy: 20),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      upadetInviteCubit
                                          .getUpdateInvite(context,
                                              invite: true,
                                              id: notificationViewCubit
                                                      .myNotifications
                                                      ?.receivedRequestBy?[
                                                          index]
                                                      .groupId ??
                                                  '')
                                          .then((value) {
                                        setState(() {
                                          groupViewCubit.getGroups();
                                          notificationViewCubit
                                              .getMyNotifitication();
                                        });
                                      });
                                    },
                                    child: Container(
                                      alignment: Alignment.center,
                                      height: screenHeight(
                                        context,
                                        dividedBy: 30,
                                      ),
                                      width:
                                          screenWidth(context, dividedBy: 4.5),
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(8),
                                          color: ColorCodes.coral),
                                      child: customText("Confirm", Colors.white,
                                          10, FontWeight.w100, poppins),
                                    ),
                                  ),
                                  SizedBox(
                                    width: screenWidth(context, dividedBy: 40),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      upadetInviteCubit
                                          .getUpdateInvite(context,
                                              invite: false,
                                              id: notificationViewCubit
                                                      .myNotifications
                                                      ?.receivedRequestBy?[
                                                          index]
                                                      .groupId ??
                                                  '')
                                          .then((value) => notificationViewCubit
                                              .getMyNotifitication());
                                    },
                                    child: Container(
                                      alignment: Alignment.center,
                                      height: screenHeight(
                                        context,
                                        dividedBy: 30,
                                      ),
                                      width:
                                          screenWidth(context, dividedBy: 4.5),
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(8),
                                          boxShadow: shadow,
                                          color: Colors.white),
                                      child: customText(
                                          "Cancel",
                                          ColorCodes.coral,
                                          10,
                                          FontWeight.w100,
                                          poppins),
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                        SizedBox(
                          height: screenHeight(context, dividedBy: 50),
                        )
                      ]);
                    });
              }
              return Container();
            }),
          )
        ]));
  }
}
