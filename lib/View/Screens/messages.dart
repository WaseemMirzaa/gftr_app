import 'dart:async';
import 'dart:developer';
import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:flutter/material.dart';
import 'package:gftr/Helper/apiConstants.dart';
import 'package:gftr/Helper/colorConstants.dart';
import 'package:gftr/View/Widgets/customLoader.dart';
import 'package:gftr/View/Widgets/customText.dart';
import 'package:gftr/View/Widgets/drawer.dart';
import 'package:gftr/ViewModel/Cubits/Msgnotifications.dart';
import 'package:gradient_borders/box_borders/gradient_box_border.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:socket_io_client/socket_io_client.dart';
import '../../Helper/appConfig.dart';
import '../../Helper/imageConstants.dart';
import 'package:flutter/foundation.dart' as foundation;

class MessagesPage extends StatefulWidget {
  String userId;
  String userName;
  String targetId;
  String Avatar;
  MessagesPage(
      {Key? key,
      required this.userId,
      required this.targetId,
      required this.userName,
      required this.Avatar})
      : super(key: key);

  @override
  State<MessagesPage> createState() => _MessagesPageState();
}

class _MessagesPageState extends State<MessagesPage> {
  TextEditingController messageController = TextEditingController();
  FocusNode focusNode = FocusNode();
  List messages = [];
  bool emojiShowing = false;
  bool? isConcted;
  bool? isActive;

  // String? roomId;
  late IO.Socket socket;

  StreamController<List<dynamic>> messageList =
      StreamController<List<dynamic>>();
  Stream<List<dynamic>> userResponse2() {
    socket
        .emit("getOldMessages", {"to": widget.targetId, "from": widget.userId});
    return messageList.stream;
  }

  ScrollController _scrollController = ScrollController();

  void initSocket() async {
    log("⚠️⚠️⚠️⚠️ Initializing socket connection");
    socket = IO.io(
        ApiConstants.baseUrlsSocket,
        OptionBuilder()
            .setTransports(['websocket'])
            .disableAutoConnect()
            .setQuery({"userName": widget.userId})
            .build());
    //socket = io('/', { "query": { "recipientId": widget.userId } });
    socket.connect();
    socket.onConnect((_) {
      isConcted = socket.connected;
      log("Socket connected: $isConcted 👍👍👍");
      print('Connection established');
    });
    isActive = socket.active;
    log("Socket active status: $isActive 😊😊😊😊");
    //log("Active : $isActive");
    socket
        .emit("getOldMessages", {"to": widget.targetId, "from": widget.userId});
    log("Requested old messages: to=${widget.targetId}, from=${widget.userId}]🎊🎊🎊");
    socket.on("data", (data) {
      try {
        log("Received message data from socket 🎈🎈🎈🎈");
        if (data != null) {
          messageList.sink.add(data);
          log("Message data added to stream: ${data.length} messages 🎆🎆🎆🎆🎆🎆🎆");
          log("Show a notification to the user showNotification(${data})");
          print("New message from ${data.widget.userId}: ${data.messages}");
          log(data.toString());
          if (mounted) {
            setState(() {});
          }
        }
      } catch (e) {
        log("Error handling socket data: $e");
      }
    });

    socket.onDisconnect((_) {
      log("Socket disconnected 🎊🎊🎊🎊🎊");
      print('Connection Disconnection');
    });
    socket.onConnectError((err) {
      log("Socket connection error: $err 🎁🎁🎁🎁");
      print('=====================================${err}');
    });
    socket.onError((err) {
      log("Socket error: $err 🧧🧧🧧");
      print("err");
    });
  }

  sendMesseage({
    required String message,
    required String toIdId,
    required String fromId,
  }) {
    log("Sending message: '$message' to: $toIdId from: $fromId 🧧🧧🧧🧧🧧");
    socket.emit("sendMessage", {
      'message': message,
      "to": toIdId,
      "from": fromId,
    });
    log("Emitted sendMessage event🧧🧧🧧🧧🧧");
    socket.emit("getOldMessages", {"to": toIdId, "from": fromId});
    log("Requested updated message history 🧧🧧🧧🧧🧧");
    socket.emit("newMessages", {"to": toIdId, "from": fromId});
    log("Notified about new message 🧧🧧🧧🧧🧧");
    setState(() {});
  }

  MessagnotiCubit messagnotiCubit = MessagnotiCubit();

  @override
  void initState() {
    super.initState();
    initSocket();
    userResponse2();
    setState(() {});
  }

  // @override
  // void didChangeDependencies() {
  //   super.didChangeDependencies();
  //   userResponse2();
  // }

  @override
  void dispose() {
    socket.disconnect();
    socket.dispose();
    _scrollController.dispose();
    messageList.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
        emojiShowing = false;
        setState(() {});
      },
      child: Scaffold(
          backgroundColor: Colors.white,
          drawer: drawerWidget(context),
          appBar: AppBar(
            leading: Padding(
              padding:
                  EdgeInsets.only(left: screenWidth(context, dividedBy: 13)),
              child: GestureDetector(
                onTap: () {
                  Scaffold.of(context).openDrawer();
                },
                child: SizedBox(
                  height: screenHeight(context, dividedBy: 30),
                  width: screenWidth(context, dividedBy: 30),
                  child: Image.asset(ImageConstants.sideMenu),
                ),
              ),
            ),
            backgroundColor: Colors.black,
            centerTitle: true,
            //elevation: 0,
            automaticallyImplyLeading: false,
            title: SizedBox(
                height: screenHeight(context, dividedBy: 30),
                // width: screenWidth(context,dividedBy: 20),
                child: Image.asset(ImageConstants.gftrLogo)),
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(
                bottom: Radius.circular(31),
              ),
            ),
          ),
          body: Column(children: [
            SizedBox(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context, 'refresh');
                    },
                    child: SizedBox(
                      width: screenWidth(context, dividedBy: 5.2),
                      height: screenHeight(context, dividedBy: 47),
                      child: Icon(
                        Icons.chevron_left_rounded,
                        color: Colors.black,
                        size: screenWidth(context, dividedBy: 16),
                      ),
                    ),
                  ),
                  customText(widget.userName, Colors.black, 14, FontWeight.bold,
                      poppins),
                  Padding(
                    padding:
                        const EdgeInsets.only(right: 8.0, top: 4, bottom: 4),
                    child: Container(
                      alignment: Alignment.center,
                      width: screenWidth(context, dividedBy: 10),
                      height: screenHeight(context, dividedBy: 20),
                      decoration: BoxDecoration(
                          // color: ColorCodes.coral,
                          border: GradientBoxBorder(
                            gradient: LinearGradient(
                                colors: [ColorCodes.coral, ColorCodes.teal]),
                            width: 2,
                          ),
                          shape: BoxShape.circle),
                      child: ClipRRect(
                          borderRadius: BorderRadius.circular(30),
                          child: CircleAvatar(
                            backgroundImage: NetworkImage(widget.Avatar),
                          )),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              height: 2,
              width: double.infinity,
              color: const Color(0xffF2F2F2),
            ),
            StreamBuilder(
                stream: userResponse2(),
                builder: (context, AsyncSnapshot snapshot) {
                  if (snapshot.hasError) {
                    return Expanded(
                        child: Center(
                            child: customText(snapshot.error.toString(),
                                Colors.black, 13, FontWeight.w500, poppins)));
                  } else if (!snapshot.hasData) {
                    return Expanded(
                        child: Center(
                            child: spinkitLoader(context, ColorCodes.teal)));
                  } else if (snapshot.hasData) {
                    return Expanded(
                        child: ListView.builder(
                      shrinkWrap: true,
                      controller: _scrollController,
                      // controller: _scrollController,
                      physics: AlwaysScrollableScrollPhysics(),
                      itemCount: snapshot.data.length + 1,
                      itemBuilder: (context, index) {
                        if (index == snapshot.data.length) {
                          return Container(height: 70);
                        }
                        return Row(
                          mainAxisAlignment:
                              snapshot.data[index]['from'] == widget.userId
                                  ? MainAxisAlignment.end
                                  : MainAxisAlignment.start,
                          children: [
                            Flexible(
                              child: Column(
                                crossAxisAlignment: snapshot.data[index]
                                            ['from'] ==
                                        widget.userId
                                    ? CrossAxisAlignment.end
                                    : CrossAxisAlignment.start,
                                children: [
                                  Container(
                                      // width:screenWidth(context,dividedBy: 1.1),
                                      margin: const EdgeInsets.symmetric(
                                        vertical: 4,
                                        horizontal: 16,
                                      ),
                                      padding: const EdgeInsets.symmetric(
                                        vertical: 10,
                                        horizontal: 10,
                                      ),
                                      decoration: BoxDecoration(
                                        color: snapshot.data[index]['from'] ==
                                                widget.userId
                                            ? ColorCodes.teal
                                            : Colors.grey.shade400,
                                        borderRadius: snapshot.data[index]
                                                    ['from'] ==
                                                widget.userId
                                            ? BorderRadius.only(
                                                topRight: Radius.circular(30),
                                                topLeft: Radius.circular(30),
                                                bottomLeft: Radius.circular(30),
                                              )
                                            : BorderRadius.only(
                                                topRight: Radius.circular(30),
                                                topLeft: Radius.circular(30),
                                                bottomRight:
                                                    Radius.circular(30),
                                              ),
                                      ),
                                      child: Text(
                                        snapshot.data[index]['message'],
                                        style: TextStyle(
                                            color: snapshot.data[index]
                                                        ['from'] ==
                                                    widget.userId
                                                ? Colors.white
                                                : Colors.black,
                                            fontFamily: poppins),
                                      )),
                                  Padding(
                                    padding: snapshot.data[index]['from'] ==
                                            widget.userId
                                        ? EdgeInsets.only(right: 15)
                                        : EdgeInsets.only(left: 15),
                                    child: customText(
                                        snapshot.data[index]['time'],
                                        ColorCodes.greyText,
                                        10,
                                        FontWeight.w100,
                                        'poppins'),
                                  )
                                ],
                              ),
                            ),
                          ],
                        );
                      },
                    ));
                  }
                  return Expanded(
                      child: Center(
                          child: spinkitLoader(context, ColorCodes.coral)));
                }),
            Container(
                margin: const EdgeInsets.all(18),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white,
                    boxShadow: const [
                      BoxShadow(
                          offset: Offset(1.0, 1.0),
                          spreadRadius: 1,
                          color: Colors.grey,
                          blurRadius: 3)
                    ]),
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(children: [
                  Padding(
                    padding: EdgeInsets.only(
                        right: screenWidth(context, dividedBy: 30)),
                    child: GestureDetector(
                      onTap: () {
                        emojiShowing = !emojiShowing;
                        FocusManager.instance.primaryFocus?.unfocus();
                        setState(() {});
                      },
                      child: Image.asset(ImageConstants.emojis,
                          height: screenHeight(context, dividedBy: 20),
                          width: screenWidth(context, dividedBy: 14)),
                    ),
                  ),
                  Flexible(
                    child: TextField(
                      controller: messageController,
                      maxLines: null,
                      onTap: () {
                        emojiShowing = false;
                        setState(() {});
                      },
                      decoration: const InputDecoration(
                          border: InputBorder.none, hintText: "Messages..."),
                    ),
                  ),
                  InkWell(
                      onTap: () {
                        if (messageController.text.isNotEmpty) {
                          setState(() {
                            _scrollController.animateTo(
                                _scrollController.position.maxScrollExtent,
                                duration: Duration(milliseconds: 100),
                                curve: Curves.easeOut);
                          });
                          // messages.insert(0, messageController.text.trim());
                          sendMesseage(
                              message: messageController.text.trim(),
                              toIdId: widget.targetId,
                              fromId: widget.userId);
                          messageController.clear();
                          setState(() {});
                        }
                      },
                      child: Image(
                          image: AssetImage(ImageConstants.send),
                          width: screenWidth(context, dividedBy: 18),
                          height: screenHeight(context, dividedBy: 18)))
                ])),
            Offstage(
                offstage: !emojiShowing,
                child: SizedBox(
                    height: 250,
                    child: EmojiPicker(
                      textEditingController: messageController,
                      config: Config(
                        skinToneConfig: SkinToneConfig(
                            dialogBackgroundColor: Colors.white,
                            indicatorColor: Colors.grey,
                            enabled: true),
                        emojiViewConfig: EmojiViewConfig(
                          columns: 7,
                          emojiSizeMax: 32 *
                              (foundation.defaultTargetPlatform ==
                                      TargetPlatform.android
                                  ? 1.30
                                  : 1.0),
                          horizontalSpacing: 0,
                          gridPadding: EdgeInsets.zero,
                          verticalSpacing: 0,
                          recentsLimit: 28,
                          replaceEmojiOnLimitExceed: false,
                          loadingIndicator: const SizedBox.shrink(),
                          noRecents: const Text(
                            'No Recents',
                            style:
                                TextStyle(fontSize: 20, color: Colors.black26),
                            textAlign: TextAlign.center,
                          ),
                          buttonMode: ButtonMode.MATERIAL,
                        ),
                        categoryViewConfig: CategoryViewConfig(
                          initCategory: Category.RECENT,
                          backgroundColor: Color(0xFFF2F2F2),
                          indicatorColor: Colors.blue,
                          iconColor: Colors.grey,
                          iconColorSelected: Colors.blue,
                          backspaceColor: Colors.blue,
                          tabIndicatorAnimDuration: kTabScrollDuration,
                          categoryIcons: const CategoryIcons(),
                        ),
                        // loadingIndicator: const SizedBox.shrink(),
                        checkPlatformCompatibility: true,
                      ),
                    ))),
          ])),
    );
  }
}
