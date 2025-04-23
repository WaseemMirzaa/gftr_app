import 'dart:async';
import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dialogs/flutter_dialogs.dart';
import 'package:gftr/Helper/apiConstants.dart';
import 'package:gftr/Model/decryption.dart';
import 'package:gftr/Model/get_sll_users.dart';
import 'package:gftr/ViewModel/Cubits/Delete_frds.dart';
import 'package:gftr/ViewModel/Cubits/GetGifted/getgiftedview_dart.dart';
import 'package:gftr/ViewModel/Cubits/Mutul_Friends.dart';
import 'package:gftr/ViewModel/Cubits/builGroup.dart';
import 'package:gftr/ViewModel/Cubits/groupscubit.dart';
import 'package:gftr/ViewModel/Cubits/view_users.dart';
import 'package:gftr/Helper/appConfig.dart';
import 'package:gftr/Helper/colorConstants.dart';
import 'package:gftr/Helper/imageConstants.dart';
import 'package:gftr/View/Widgets/customText.dart';
import 'package:gftr/ViewModel/Cubits/getContact.dart';
import 'package:gftr/ViewModel/Cubits/inviteEmail_cubit.dart';
import 'package:gftr/ViewModel/Cubits/viewsetting.dart';
import 'package:gftr/ViewModel/apiServices.dart';
import 'package:mailer/mailer.dart';
import 'package:gradient_borders/box_borders/gradient_box_border.dart';
import 'package:mailer/smtp_server/gmail.dart';
import 'package:flutter_sms/flutter_sms.dart';
import 'package:url_launcher/url_launcher.dart';
import '../Widgets/customLoader.dart';

class GftrNetwork extends StatefulWidget {
  const GftrNetwork({Key? key}) : super(key: key);

  @override
  State<GftrNetwork> createState() => _GftrNetworkState();
}

class _GftrNetworkState extends State<GftrNetwork> {
  LinearGradient coralTealColor = const LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [ColorCodes.coral, ColorCodes.teal],
  );
  Widget dateListTile(
      {required String image,
      required String eventName,
      required String date}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Image.asset(
          image,
          width: 20,
          height: 20,
          fit: BoxFit.fill,
        ),
        SizedBox(
          width: screenWidth(context, dividedBy: 55),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              eventName,
              style: TextStyle(
                  color: ColorCodes.greyText,
                  fontSize: 10.5,
                  fontFamily: poppins,
                  fontWeight: FontWeight.w100),
            ),
            Text(
              date,
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 10.5,
                  fontFamily: poppins,
                  fontWeight: FontWeight.w100),
            ),
          ],
        )
      ],
    );
  }

  // String kUriPrefix = 'https://gftruser.page.link';
  // String kProductpageLink = '/NetWork?id=24';
  // String? _linkMessage;
  // bool _isCreatingLink = false;
  // FirebaseDynamicLinks dynamicLinks = FirebaseDynamicLinks.instance;
  // Future<void> initDynamicLinks() async {
  //   dynamicLinks.onLink.listen((dynamicLinkData) {
  //     final Uri uri = dynamicLinkData.link;
  //     if (uri != null) {
  //       Navigator.push(
  //           context,
  //           MaterialPageRoute(
  //             builder: (context) => Gftrs(),
  //           ));
  //     } else {
  //       Navigator.push(
  //           context,
  //           MaterialPageRoute(
  //             builder: (context) => Gftrs(),
  //           ));
  //     }
  //   }).onError((error) {
  //     print('onLink error');
  //     print(error.message);
  //   });
  // }
  //
  // Future<void> _createDynamicLink(String link) async {
  //   setState(() {
  //     _isCreatingLink = true;
  //   });
  //
  //   final DynamicLinkParameters parameters = DynamicLinkParameters(
  //     uriPrefix: kUriPrefix,
  //     link: Uri.parse(ApiConstants.baseUrlsSocket + link),
  //     androidParameters: const AndroidParameters(
  //       packageName: "com.example.gftr",
  //       minimumVersion: 125,
  //     ),
  //     iosParameters: IOSParameters(
  //       bundleId: "com.user.gftr",
  //       minimumVersion: "1.0.1",
  //     ),
  //   );
  //   initDynamicLinks();
  //   Uri url;
  //   final ShortDynamicLink shortLink =
  //       await dynamicLinks.buildShortLink(parameters);
  //   url = shortLink.shortUrl;
  //
  //   setState(() {
  //     _linkMessage = url.toString();
  //     _isCreatingLink = false;
  //   });
  //   log(_linkMessage.toString());
  // }
  TextEditingController _searchbar = TextEditingController();
  TextEditingController EmailTo = TextEditingController();
  String EmailText = """""";
  List<String> smsNumbers = [];
  bool isBotton = false;
  bool _search = false;
  bool chang = false;
  int a = 0;
  void sendEmail() async {
    //  String username = 'tanthetaa.flutter@gmail.com';
    String username = ' admin@gftr.com';
    // String password = 'yvpulwxqalopiebc';
    String password = 'Gi5+er23!';

    final smtpServer = gmail(username, password);
    getContactViewCubit.emailList.forEach((element) async {
      final message = Message()
        ..from = Address(username)
        ..recipients.add(element.email)
        ..subject = 'Hey ${element.name} wants you on GFTR'
        ..text = """ 
Hello from The GFTR Group! We’re passing along an invitation from ${viewSettingCubit.viewSetting?.data?.firstname} ${viewSettingCubit.viewSetting?.data?.lastname} who thought you might be interested in joining the GFTR family. 

GFTR’s motto is ‘Easy Giving’ - and that pretty much says it all. Our ‘micro-social network’ platform is a simple way to give (and receive) gifts that you and your loved ones actually want. Just save gift ideas to easy-to-use wishlists (for you and them) from anywhere and everywhere, … get great ideas from our in-house GFTR Guide… check out what the members of your private GFTR Group are wishing for and… Get Gifting!

With GFTR, you know that every gift you give (and receive!) will be a home-run, without the waste or worry. To get started, come check us out  http://i.diwai.com/nBKqvS or email us “hello@gftr.com” and say hello. 

It’s great to meet you, we’re looking forward to gifting better together,

GFTR
""";
      try {
        final sendReport = await send(message, smtpServer);
        print('Message sent: ${sendReport.toString()}');
      } on MailerException catch (e) {
        print('Message not sent. ${e.toString()}');
      }
    });

    getContactViewCubit.emailList.clear();
  }

  void sendSms() async {
    String message =
        "Hey there. ${viewSettingCubit.viewSetting?.data?.firstname} ${viewSettingCubit.viewSetting?.data?.lastname} wants you to join them on GFTR. Get gifting (and gifted!) by downloading the app http://i.diwai.com/nBKqvS";
    String _result = await sendSMS(
            message: message,
            recipients: getContactViewCubit.smslList,
            sendDirect: true)
        .catchError((onError) {
      print(onError);
    });
    getContactViewCubit.smslList.clear();
    print(_result);
  }

  MutualFrdsCubit mutualFrdsCubit = MutualFrdsCubit();
  InviteEmialCubit inviteEmialCubit = InviteEmialCubit();
  GetContactViewCubit getContactViewCubit = GetContactViewCubit();
  ViewSettingCubit viewSettingCubit = ViewSettingCubit();
  GroupViewCubit groupViewCubit = GroupViewCubit();
  BuildGroupCubit buildGroupCubit = BuildGroupCubit();
  GetGiftedViewCubit getGiftedViewCubit = GetGiftedViewCubit();
  UsersviewsCubit usersviewsCubit = UsersviewsCubit();
  DeleteFriendsCubit deleteFriendsCubit = DeleteFriendsCubit();
  final dio = Dio();
  Timer? timer;
  List _users = [];
  Map? map1;
  Future<ViewAllUsers?> view_all_users() async {
    Decryption? data = await DioClient()
        .decryptDataGetMethod("${ApiConstants.view_all_users}");
    Map<String, dynamic> body = {"encData": data?.data};
    try {
      Response userData = await dio.post(ApiConstants.decryptData, data: body);
      Map _map = userData.data;
      setState(() {
        _users = _map['data'];
        print("Users ===>$_users");
        setState(() {
          groupViewCubit.uniqueArray;
        });
      });
      return ViewAllUsers.fromJson(userData.data);
    } catch (e) {
      print("view user error ${e.toString()}");
      return null;
    }
  }

  @override
  void initState() {
    super.initState();
    setState(() {
      groupViewCubit.uniqueArray;
    });
    results = _users;
    f = groupViewCubit.uniqueArray;
    mutualFrdsCubit = BlocProvider.of<MutualFrdsCubit>(context);
    usersviewsCubit = BlocProvider.of<UsersviewsCubit>(context);
    groupViewCubit = BlocProvider.of<GroupViewCubit>(context);
    inviteEmialCubit = BlocProvider.of<InviteEmialCubit>(context);
    getContactViewCubit = BlocProvider.of<GetContactViewCubit>(context);
    deleteFriendsCubit = BlocProvider.of<DeleteFriendsCubit>(context);
    viewSettingCubit = BlocProvider.of<ViewSettingCubit>(context);
    mutualFrdsCubit.mutual_frds();
    usersviewsCubit.users_views();
    groupViewCubit.getGroups();
    getContactViewCubit.getContactsList();
    viewSettingCubit.getviewSetting();
    view_all_users();
    Timer(Duration(milliseconds: 700), () {
      setState(() {
        results = _users;
        setState(() {
          f = groupViewCubit.uniqueArray;
          print("===>$f");
        });
        chang = true;
      });
    });
  }

  List results = [];
  List c = [];
  List d = [];
  List e = [];
  List f = [];
  final ScrollController _secondController = ScrollController();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    c.clear();
    f.clear();
    groupViewCubit.uniqueArray.clear();
    getContactViewCubit.smslList.clear();
    getContactViewCubit.emailList.clear();
    getContactViewCubit.displayname.clear();
    // e.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
        setState(() {});
      },
      child: SizedBox(
        height: screenHeight(context),
        width: screenWidth(context),
        child: SingleChildScrollView(
          physics: NeverScrollableScrollPhysics(),
          child: Column(
            children: [
              Container(
                alignment: Alignment.center,
                // height: screenHeight(context, dividedBy: 20),
                width: screenWidth(context, dividedBy: 1.1),
                margin:
                    EdgeInsets.only(top: screenHeight(context, dividedBy: 45)),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 5,
                      )
                    ]),
                child: TextField(
                  cursorColor: Colors.grey.shade600,
                  controller: _searchbar,
                  onChanged: (value) {
                    setState(() {
                      results = _users
                          .where((element) =>
                              element.toString().toLowerCase().contains(value))
                          .toList();
                    });
                  },
                  // maxLength: hintText=='Price'?5: null,
                  decoration: InputDecoration(
                      hintText: "Search for a Gftr",
                      prefixIcon: Padding(
                        padding: EdgeInsets.all(10),
                        child: Image.asset(ImageConstants.search,
                            color: ColorCodes.greyText, height: 10, width: 10),
                      ),
                      hintStyle: TextStyle(fontSize: 15, fontFamily: poppins),
                      border: InputBorder.none),
                ),

                // _search?
                // TextField(
                //   onChanged: (value) {
                //     setState(() {
                //       results = _users.where((element) => element.toString().toLowerCase().contains(value)).toList();
                //     });
                //   },
                //   decoration: InputDecoration(
                //     suffixIcon: Icon(Icons.search),
                //       hintText: 'Search for a Gftr',
                //       prefixIcon: Padding(
                //         padding: EdgeInsets.all(10),
                //         child: Image.asset(ImageConstants.search,
                //             color: ColorCodes.greyText, height: 10, width: 10),
                //       )),
                //
                //   controller: _searchbar,
                // ) :
                // getCustomTextFild(
                //   onTap: () {
                //     setState(() {
                //       _search=!_search;
                //     });
                //   },
                //     hintText: 'Search for a Gftr',
                //     controller: _searchbar,
                //     pefixIcon: Padding(
                //       padding: EdgeInsets.all(10),
                //       child: Image.asset(ImageConstants.search,
                //           color: ColorCodes.greyText, height: 10, width: 10),
                //     )
                // ),
              ),
              SizedBox(height: screenHeight(context, dividedBy: 40)),
              customText('Your Gftr Network', Colors.black, 18, FontWeight.w600,
                  poppins),
              SizedBox(
                height: screenHeight(context, dividedBy: 2.45),
                // color: Colors.red,
                child: BlocBuilder<MutualFrdsCubit, MutualFrdsState>(
                  builder: (context, state) {
                    log("MutualFrdsCubit $state");
                    if (state is MutualFrdsLoading) {
                      return Center(
                        child: spinkitLoader(context, ColorCodes.coral),
                      );
                    } else if (state is MutualFrdsError) {
                      return Scrollbar(
                        thickness: 8,
                        radius: Radius.circular(16),
                        //--------------------------------CLOSED BY ME------------------------------------------------
                        // isAlwaysShown: true,
                        thumbVisibility: true,
                        //--------------------------------CLOSED BY ME------------------------------------------------
                        controller: _secondController,
                        child: ListView.builder(
                          controller: _secondController,
                          itemCount: _searchbar.text.isNotEmpty
                              ? results.length
                              : _users.length,
                          itemBuilder: (context, index) {
                            return Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  height: screenHeight(context, dividedBy: 11),
                                  width: screenWidth(context, dividedBy: 1.1),
                                  alignment: Alignment.center,
                                  margin: EdgeInsets.only(
                                      top: screenHeight(context,
                                          dividedBy: 100)),
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(8),
                                      boxShadow: const [
                                        BoxShadow(
                                          color: Colors.black12,
                                          blurRadius: 5,
                                        )
                                      ]),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      SizedBox(
                                          width: screenWidth(context,
                                              dividedBy: 30)),
                                      Container(
                                        decoration: BoxDecoration(
                                            border: GradientBoxBorder(
                                                gradient: coralTealColor,
                                                width: 2),
                                            shape: BoxShape.circle),
                                        child: CircleAvatar(
                                          backgroundImage: _searchbar
                                                  .text.isNotEmpty
                                              ? NetworkImage(
                                                  "${ApiConstants.baseUrlsSocket}${results[index]['avatar']}")
                                              : NetworkImage(
                                                  "${ApiConstants.baseUrlsSocket}${_users[index]['avatar']}"),
                                          // AssetImage(ImageConstants.dummyProfile),
                                          radius: 23,
                                        ),
                                      ),
                                      SizedBox(
                                          width: screenWidth(context,
                                              dividedBy: 35)),
                                      Container(
                                          alignment: Alignment.center,
                                          height: screenHeight(context,
                                              dividedBy: 20),
                                          child: RichText(
                                            text: TextSpan(
                                              children: [
                                                TextSpan(
                                                  text:
                                                      _searchbar.text.isNotEmpty
                                                          ? results[index]
                                                              ['firstname']
                                                          : _users[index]
                                                              ['firstname'],
                                                  style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 15,
                                                    fontWeight: FontWeight.w200,
                                                    fontFamily: poppins,
                                                  ),
                                                ),
                                                TextSpan(text: ' '),
                                                TextSpan(
                                                  text:
                                                      _searchbar.text.isNotEmpty
                                                          ? results[index]
                                                              ['lastname']
                                                          : _users[index]
                                                              ['lastname'],
                                                  style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 15,
                                                    fontWeight: FontWeight.w200,
                                                    fontFamily: poppins,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          )),
                                      Spacer(),
                                      if (isBotton &&
                                          e.contains(
                                              "${_searchbar.text.isNotEmpty ? results[index]['phoneNumber'] : _users[index]['phoneNumber']}"))
                                        Container(
                                          margin: EdgeInsets.only(
                                              left: screenWidth(context,
                                                  dividedBy: 6)),
                                          height: screenHeight(context,
                                              dividedBy: 25),
                                          width: screenWidth(context,
                                              dividedBy: 5.5),
                                          alignment: Alignment.center,
                                          decoration: BoxDecoration(
                                              gradient: coralTealColor,
                                              // border: GradientBoxBorder(
                                              //     gradient: coralTealColor, width: 1),
                                              borderRadius:
                                                  BorderRadius.circular(25)),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Image.asset(
                                                  ImageConstants.askLogo,
                                                  width: 15,
                                                  height: 15),
                                              Text("Asked",
                                                  style: const TextStyle(
                                                    fontSize: 12,
                                                    color: Color(0xffFFFFFF),
                                                  ))
                                            ],
                                          ),
                                          // child: customText('Sending', Colors.black, 10,
                                          //     FontWeight.w100, poppins)
                                        )
                                      else if (f.contains(
                                          "${_searchbar.text.isNotEmpty ? results[index]['phoneNumber'] : _users[index]['phoneNumber']}"))
                                        Container(
                                            margin: EdgeInsets.only(
                                                left: screenWidth(context,
                                                    dividedBy: 6),
                                                right: screenWidth(context,
                                                    dividedBy: 90)),
                                            height: screenHeight(context,
                                                dividedBy: 25),
                                            width: screenWidth(context,
                                                dividedBy: 5.5),
                                            alignment: Alignment.center,
                                            decoration: BoxDecoration(
                                                border: GradientBoxBorder(
                                                    gradient: coralTealColor,
                                                    width: 1),
                                                borderRadius:
                                                    BorderRadius.circular(25)),
                                            child: InkWell(
                                              onTap: () {
                                                showDialog(
                                                  context: context,
                                                  builder: (context) {
                                                    return SimpleDialog(
                                                      shape:
                                                          RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          20)),
                                                      children: [
                                                        Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                        .symmetric(
                                                                    horizontal:
                                                                        20,
                                                                    vertical:
                                                                        20),
                                                            child: Center(
                                                                child: Text(
                                                                    "Are you sure ...."))),
                                                        Container(
                                                          width: 200,
                                                          height: 1,
                                                          decoration:
                                                              const BoxDecoration(
                                                                  color: Colors
                                                                      .black12,
                                                                  boxShadow: [
                                                                BoxShadow(
                                                                    color: Colors
                                                                        .black38,
                                                                    blurRadius:
                                                                        5)
                                                              ]),
                                                        ),
                                                        Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceEvenly,
                                                          children: [
                                                            InkWell(
                                                              onTap: () async {
                                                                Navigator.pop(
                                                                    context);
                                                              },
                                                              child: Container(
                                                                margin:
                                                                    const EdgeInsets
                                                                            .only(
                                                                        top: 5),
                                                                height: 20,
                                                                width: 100,
                                                                alignment:
                                                                    Alignment
                                                                        .center,
                                                                child: Padding(
                                                                    padding: const EdgeInsets
                                                                            .only(
                                                                        left:
                                                                            8.0),
                                                                    child: customText(
                                                                        "No",
                                                                        ColorCodes
                                                                            .greyText,
                                                                        14,
                                                                        FontWeight
                                                                            .w400,
                                                                        poppins)),
                                                              ),
                                                            ),
                                                            Container(
                                                              width:
                                                                  screenWidth(
                                                                      context,
                                                                      dividedBy:
                                                                          300),
                                                              height:
                                                                  screenHeight(
                                                                      context,
                                                                      dividedBy:
                                                                          20),
                                                              decoration: const BoxDecoration(
                                                                  color: Colors
                                                                      .black12,
                                                                  boxShadow: [
                                                                    BoxShadow(
                                                                        color: Colors
                                                                            .black38,
                                                                        blurRadius:
                                                                            5)
                                                                  ]),
                                                            ),
                                                            InkWell(
                                                              onTap: () async {
                                                                setState(() {
                                                                  chang = false;
                                                                });
                                                                print(
                                                                    "hyyy:${_users[index]['phoneNumber']}");
                                                                setState(() {
                                                                  deleteFriendsCubit
                                                                      .Delete_frdss(
                                                                          context,
                                                                          Numbers:
                                                                              "${_searchbar.text.isNotEmpty ? results[index]['phoneNumber'] : _users[index]['phoneNumber']}");
                                                                });
                                                                // Navigator.push(context, MaterialPageRoute(builder: (context) {
                                                                //   return GftrNetwork();
                                                                // },));
                                                                Navigator.pop(
                                                                    context);
                                                                Timer(
                                                                    Duration(
                                                                        milliseconds:
                                                                            1500),
                                                                    () {
                                                                  setState(() {
                                                                    groupViewCubit
                                                                        .uniqueArray;
                                                                    f.remove(
                                                                        "${_searchbar.text.isNotEmpty ? results[index]['phoneNumber'] : _users[index]['phoneNumber']}");
                                                                    // groupViewCubit.usernum.remove(usersviewsCubit.viewAllUsers!.data?[index].phoneNumber.toString());
                                                                    chang =
                                                                        true;
                                                                    print(
                                                                        "========== ${groupViewCubit.uniqueArray.toString()}");
                                                                    print(
                                                                        "==========fff ${f}");
                                                                  });
                                                                });
                                                              },
                                                              child: Container(
                                                                  margin: const EdgeInsets
                                                                          .only(
                                                                      top: 5),
                                                                  height: 20,
                                                                  width: 100,
                                                                  alignment:
                                                                      Alignment
                                                                          .center,
                                                                  child: Padding(
                                                                      padding: const EdgeInsets
                                                                              .only(
                                                                          left:
                                                                              8.0),
                                                                      child: customText(
                                                                          "Yes",
                                                                          ColorCodes
                                                                              .greyText,
                                                                          14,
                                                                          FontWeight
                                                                              .w400,
                                                                          poppins))),
                                                            )
                                                          ],
                                                        )
                                                      ],
                                                    );
                                                  },
                                                );
                                                // if(c.contains(_searchbar.text.isNotEmpty? b[index].toString(): usersviewsCubit.viewAllUsers!.data?[index].phoneNumber.toString())){
                                                //   c.remove(_searchbar.text.isNotEmpty? b[index].toString(): usersviewsCubit.viewAllUsers!.data?[index].phoneNumber.toString());
                                                // }else{
                                                //   c.add(_searchbar.text.isNotEmpty? b[index].toString(): usersviewsCubit.viewAllUsers!.data?[index].phoneNumber.toString());
                                                // }

                                                print("hello");
                                              },
                                              child: customText(
                                                  'Remove',
                                                  Colors.black,
                                                  10,
                                                  FontWeight.w100,
                                                  poppins),
                                            ))
                                      else
                                        Container(
                                          margin: EdgeInsets.only(
                                              left: screenWidth(context,
                                                  dividedBy: 6)),
                                          height: screenHeight(context,
                                              dividedBy: 25),
                                          width: screenWidth(context,
                                              dividedBy: 5.5),
                                          alignment: Alignment.center,
                                          decoration: BoxDecoration(
                                              color: ColorCodes.coral,
                                              borderRadius:
                                                  BorderRadius.circular(25)),
                                          child: GestureDetector(
                                            onTap: () {
                                              setState(() {
                                                if (c.contains(
                                                    "${_searchbar.text.isNotEmpty ? results[index]['phoneNumber'] : _users[index]['phoneNumber']}")) {
                                                  c.remove(
                                                      "${_searchbar.text.isNotEmpty ? results[index]['phoneNumber'] : _users[index]['phoneNumber']}");
                                                } else {
                                                  c.add(
                                                      "${_searchbar.text.isNotEmpty ? results[index]['phoneNumber'] : _users[index]['phoneNumber']}");
                                                  buildGroupCubit.getBuilGrop(
                                                      context,
                                                      checkData: c);
                                                }
                                                print(_searchbar.text.isNotEmpty
                                                    ? results[index]
                                                        ['phoneNumber']
                                                    : _users[index]
                                                        ['phoneNumber']);
                                                e.addAll(c);
                                                isBotton = true;
                                                c.clear();
                                                print("c:$c");
                                                print("f:$f");
                                                print("f:$e");
                                              });
                                            },
                                            child: customText(
                                                'Add',
                                                Colors.white,
                                                10,
                                                FontWeight.w100,
                                                poppins),
                                          ),
                                        ),
                                      SizedBox(
                                          width: screenWidth(context,
                                              dividedBy: 30)),
                                      // (d.contains(_searchbar.text.isNotEmpty? b[index].toString(): usersviewsCubit.viewAllUsers!.data?[index].phoneNumber.toString()) ) ?
                                      // InkWell(
                                      //     onTap: () {
                                      //       setState(() {
                                      //         if(d.contains(_searchbar.text.isNotEmpty? b[index].toString(): usersviewsCubit.viewAllUsers!.data?[index].phoneNumber.toString())){
                                      //           d.remove(_searchbar.text.isNotEmpty? b[index].toString(): usersviewsCubit.viewAllUsers!.data?[index].phoneNumber.toString());
                                      //         }else{
                                      //           d.add(_searchbar.text.isNotEmpty? b[index].toString(): usersviewsCubit.viewAllUsers!.data?[index].phoneNumber.toString());
                                      //         }
                                      //         isBotton = false;
                                      //       });
                                      //
                                      //     },
                                      //     child: Icon(Icons.keyboard_arrow_down_sharp)) :
                                      // InkWell(
                                      //     onTap: () {
                                      //       setState(() {
                                      //         if(d.contains(_searchbar.text.isNotEmpty? b[index].toString(): usersviewsCubit.viewAllUsers!.data?[index].phoneNumber.toString())){
                                      //           d.remove(_searchbar.text.isNotEmpty? b[index].toString(): usersviewsCubit.viewAllUsers!.data?[index].phoneNumber.toString());
                                      //         }else{
                                      //           d.add(_searchbar.text.isNotEmpty? b[index].toString(): usersviewsCubit.viewAllUsers!.data?[index].phoneNumber.toString());
                                      //         }
                                      //         isBotton = true;
                                      //       });
                                      //     },
                                      //     child: Icon(Icons.keyboard_arrow_right_rounded))
                                    ],
                                  ),
                                ),
                                // ( isBotton == true && d.contains(_searchbar.text.isNotEmpty? b[index].toString(): usersviewsCubit.viewAllUsers!.data?[index].phoneNumber.toString()))
                                //     ? Container(
                                //     height: screenHeight(context, dividedBy: 8),
                                //     width: screenWidth(context, dividedBy: 1.1),
                                //     alignment: Alignment.center,
                                //     margin: EdgeInsets.only(
                                //         top: screenHeight(context, dividedBy: 60)),
                                //     decoration: BoxDecoration(
                                //         color: Colors.white,
                                //         borderRadius: BorderRadius.circular(8),
                                //         boxShadow: const [
                                //           BoxShadow(
                                //             color: Colors.black12,
                                //             blurRadius: 5,
                                //           )
                                //         ]),
                                //     child: Row(
                                //       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                //       children: [
                                //         Column(
                                //           crossAxisAlignment: CrossAxisAlignment.start,
                                //           mainAxisAlignment: MainAxisAlignment.spaceAround,
                                //           children: [
                                //             (usersviewsCubit.viewAllUsers!.data?[index].birthday.toString() == null) ?
                                //             dateListTile(
                                //                 image: ImageConstants.birthDay,
                                //                 eventName: 'BirthDay',
                                //                 date: '00-00-00')
                                //            : dateListTile(
                                //                 image: ImageConstants.birthDay,
                                //                 eventName: 'BirthDay',
                                //                 date: '${usersviewsCubit.viewAllUsers!.data?[index].birthday.toString().substring(0,10)}'),
                                //             dateListTile(
                                //                 image: ImageConstants.daughters,
                                //                 eventName: "Daughters' Day",
                                //                 date: '24-09-1993'),
                                //           ],
                                //         ),
                                //         Column(
                                //           crossAxisAlignment: CrossAxisAlignment.start,
                                //           mainAxisAlignment: MainAxisAlignment.spaceAround,
                                //           children: [
                                //             dateListTile(
                                //                 image: ImageConstants.anniversary,
                                //                 eventName: 'Anniversary',
                                //                 date: '02-07-2000'),
                                //             dateListTile(
                                //                 image: ImageConstants.womens,
                                //                 eventName: "Women's Day",
                                //                 date: '02-07-2000'),
                                //           ],
                                //         ),
                                //         Column(
                                //           crossAxisAlignment: CrossAxisAlignment.start,
                                //           mainAxisAlignment: MainAxisAlignment.spaceAround,
                                //           children: [
                                //             dateListTile(
                                //                 image: ImageConstants.valentine,
                                //                 eventName: "Valentine's Day",
                                //                 date: '14-02-2023'),
                                //             dateListTile(
                                //                 image: ImageConstants.mothers,
                                //                 eventName: "Mother's Day",
                                //                 date: '14-02-2023'),
                                //           ],
                                //         )
                                //       ],
                                //     )
                                // )
                                //     : SizedBox(),
                              ],
                            );
                          },
                        ),
                      );
                    } else if (state is MutualFrdsSuccess) {
                      return Scrollbar(
                        thickness: 8,
                        radius: Radius.circular(16),
                        //--------------------------------CLOSED BY ME------------------------------------------------
                        // isAlwaysShown: true,
                        thumbVisibility: true,
                        //--------------------------------CLOSED BY ME------------------------------------------------
                        controller: _secondController,
                        child: ListView.builder(
                          controller: _secondController,
                          itemCount: mutualFrdsCubit.mutulfriendd?.data?.length,
                          itemBuilder: (context, Firstindex) {
                            final mutuInt = mutualFrdsCubit.mutulfriendd!
                                .data![Firstindex].mutualby.length;
                            return Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  height: screenHeight(context, dividedBy: 12),
                                  width: screenWidth(context, dividedBy: 1.08),
                                  alignment: Alignment.center,
                                  margin: EdgeInsets.only(
                                      top: screenHeight(context,
                                          dividedBy: 100)),
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(8),
                                      boxShadow: const [
                                        BoxShadow(
                                          color: Colors.black12,
                                          blurRadius: 5,
                                        )
                                      ]),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      SizedBox(
                                          width: screenWidth(context,
                                              dividedBy: 50)),
                                      Container(
                                        decoration: BoxDecoration(
                                            border: GradientBoxBorder(
                                                gradient: coralTealColor,
                                                width: 2),
                                            shape: BoxShape.circle),
                                        child: CircleAvatar(
                                          backgroundImage: NetworkImage(
                                              "${ApiConstants.baseUrlsSocket}${mutualFrdsCubit.mutulfriendd?.data?[Firstindex].frd.avatar}"),
                                          // AssetImage(ImageConstants.dummyProfile),
                                          radius: 23,
                                        ),
                                      ),
                                      SizedBox(
                                          width: screenWidth(context,
                                              dividedBy: 50)),
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                            alignment: Alignment.bottomLeft,
                                            height: screenHeight(context,
                                                dividedBy: 37),
                                            width: screenWidth(context,
                                                dividedBy: 4),
                                            child: Text(
                                              "${mutualFrdsCubit.mutulfriendd?.data?[Firstindex].frd.firstname}",
                                              style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 15,
                                                fontWeight: FontWeight.w200,
                                                fontFamily: poppins,
                                              ),
                                            ),
                                          ),
                                          Container(
                                            alignment: Alignment.center,
                                            height: screenHeight(context,
                                                dividedBy: 25),
                                            width: screenWidth(context,
                                                dividedBy: 2.15),
                                            child: Row(
                                              children: [
                                                Text(
                                                  "Mutual : ${mutualFrdsCubit.mutulfriendd?.data?[Firstindex].mutualby[0].name}",
                                                  style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 12,
                                                    fontWeight: FontWeight.w200,
                                                    fontFamily: poppins,
                                                  ),
                                                ),
                                                mutuInt >= 2
                                                    ? InkWell(
                                                        onTap: () {
                                                          showPlatformDialog(
                                                            context: context,
                                                            builder: (context) =>
                                                                BasicDialogAlert(
                                                              title: Text(
                                                                  "Mutual Friends"),
                                                              content:
                                                                  Container(
                                                                      height:
                                                                          100,
                                                                      child:
                                                                          Scrollbar(
                                                                        controller:
                                                                            _secondController,
                                                                        thickness:
                                                                            8,
                                                                        radius:
                                                                            Radius.circular(16),
                                                                        //--------------------------------CLOSED BY ME------------------------------------------------
                                                                        // isAlwaysShown: true,
                                                                        thumbVisibility:
                                                                            true,
                                                                        //--------------------------------CLOSED BY ME------------------------------------------------
                                                                        child: ListView
                                                                            .separated(
                                                                          padding:
                                                                              EdgeInsets.zero,
                                                                          controller:
                                                                              _secondController,
                                                                          scrollDirection:
                                                                              Axis.vertical,
                                                                          physics:
                                                                              ClampingScrollPhysics(),
                                                                          itemCount: mutualFrdsCubit
                                                                              .mutulfriendd!
                                                                              .data![Firstindex]
                                                                              .mutualby
                                                                              .length,
                                                                          itemBuilder:
                                                                              (context, index) {
                                                                            return Row(
                                                                              children: [
                                                                                CircleAvatar(
                                                                                  backgroundImage: NetworkImage("${ApiConstants.baseUrlsSocket}${mutualFrdsCubit.mutulfriendd?.data?[Firstindex].mutualby[index].avatar.toString()}"),
                                                                                ),
                                                                                SizedBox(
                                                                                  width: 10,
                                                                                ),
                                                                                Text("${mutualFrdsCubit.mutulfriendd?.data?[Firstindex].mutualby[index].name}"),
                                                                              ],
                                                                            );
                                                                          },
                                                                          separatorBuilder:
                                                                              (BuildContext context, int index) {
                                                                            return Divider(
                                                                              color: Colors.black87,
                                                                            );
                                                                          },
                                                                        ),
                                                                      )),
                                                              actions: <Widget>[
                                                                BasicDialogAction(
                                                                  title: Text(
                                                                      "Cancel"),
                                                                  onPressed:
                                                                      () {
                                                                    Navigator.pop(
                                                                        context);
                                                                  },
                                                                ),
                                                              ],
                                                            ),
                                                          );
                                                        },
                                                        child: Text(
                                                          " +${mutuInt.toString().length}",
                                                          style: TextStyle(
                                                            color: Colors.black,
                                                            fontSize: 12,
                                                            fontWeight:
                                                                FontWeight.w200,
                                                            fontFamily: poppins,
                                                          ),
                                                        ),
                                                      )
                                                    : SizedBox(),
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                      if (isBotton &&
                                          e.contains(mutualFrdsCubit
                                              .mutulfriendd
                                              ?.data?[Firstindex]
                                              .frd
                                              .phoneNumber
                                              .toString()))
                                        Container(
                                          margin: EdgeInsets.only(
                                              left: screenWidth(context,
                                                  dividedBy: 15)),
                                          height: screenHeight(context,
                                              dividedBy: 25),
                                          width: screenWidth(context,
                                              dividedBy: 5.5),
                                          alignment: Alignment.center,
                                          decoration: BoxDecoration(
                                              gradient: coralTealColor,
                                              // border: GradientBoxBorder(
                                              //     gradient: coralTealColor, width: 1),
                                              borderRadius:
                                                  BorderRadius.circular(25)),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Image.asset(
                                                  ImageConstants.askLogo,
                                                  width: 15,
                                                  height: 15),
                                              Text("Asked",
                                                  style: const TextStyle(
                                                    fontSize: 12,
                                                    color: Color(0xffFFFFFF),
                                                  ))
                                            ],
                                          ),
                                          // child: customText('Sending', Colors.black, 10,
                                          //     FontWeight.w100, poppins)
                                        )
                                      else if (f.contains(mutualFrdsCubit
                                          .mutulfriendd
                                          ?.data?[Firstindex]
                                          .frd
                                          .phoneNumber
                                          .toString()))
                                        Container(
                                            margin: EdgeInsets.only(
                                                left: screenWidth(context,
                                                    dividedBy: 16.05),
                                                right: screenWidth(context,
                                                    dividedBy: 100)),
                                            height: screenHeight(context,
                                                dividedBy: 25),
                                            width: screenWidth(context,
                                                dividedBy: 5.5),
                                            alignment: Alignment.center,
                                            decoration: BoxDecoration(
                                                border: GradientBoxBorder(
                                                    gradient: coralTealColor,
                                                    width: 1),
                                                borderRadius:
                                                    BorderRadius.circular(25)),
                                            child: InkWell(
                                              onTap: () {
                                                showDialog(
                                                  context: context,
                                                  builder: (context) {
                                                    return SimpleDialog(
                                                      shape:
                                                          RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          20)),
                                                      children: [
                                                        Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                        .symmetric(
                                                                    horizontal:
                                                                        20,
                                                                    vertical:
                                                                        20),
                                                            child: Center(
                                                                child: Text(
                                                                    "Are you sure ...."))),
                                                        Container(
                                                          width: 200,
                                                          height: 1,
                                                          decoration:
                                                              const BoxDecoration(
                                                                  color: Colors
                                                                      .black12,
                                                                  boxShadow: [
                                                                BoxShadow(
                                                                    color: Colors
                                                                        .black38,
                                                                    blurRadius:
                                                                        5)
                                                              ]),
                                                        ),
                                                        Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceEvenly,
                                                          children: [
                                                            InkWell(
                                                              onTap: () async {
                                                                Navigator.pop(
                                                                    context);
                                                              },
                                                              child: Container(
                                                                margin:
                                                                    const EdgeInsets
                                                                            .only(
                                                                        top: 5),
                                                                height: 20,
                                                                width: 100,
                                                                alignment:
                                                                    Alignment
                                                                        .center,
                                                                child: Padding(
                                                                    padding: const EdgeInsets
                                                                            .only(
                                                                        left:
                                                                            8.0),
                                                                    child: customText(
                                                                        "No",
                                                                        ColorCodes
                                                                            .greyText,
                                                                        14,
                                                                        FontWeight
                                                                            .w400,
                                                                        poppins)),
                                                              ),
                                                            ),
                                                            Container(
                                                              width:
                                                                  screenWidth(
                                                                      context,
                                                                      dividedBy:
                                                                          300),
                                                              height:
                                                                  screenHeight(
                                                                      context,
                                                                      dividedBy:
                                                                          20),
                                                              decoration: const BoxDecoration(
                                                                  color: Colors
                                                                      .black12,
                                                                  boxShadow: [
                                                                    BoxShadow(
                                                                        color: Colors
                                                                            .black38,
                                                                        blurRadius:
                                                                            5)
                                                                  ]),
                                                            ),
                                                            InkWell(
                                                              onTap: () async {
                                                                deleteFriendsCubit.Delete_frdss(
                                                                        context,
                                                                        Numbers:
                                                                            "${mutualFrdsCubit.mutulfriendd?.data?[Firstindex].frd.phoneNumber.toString()}")
                                                                    .then(
                                                                  (value) {
                                                                    mutualFrdsCubit
                                                                        .mutual_frds();
                                                                    groupViewCubit
                                                                        .getGroups();
                                                                    groupViewCubit
                                                                        .uniqueArray;
                                                                    f.remove(
                                                                        "${mutualFrdsCubit.mutulfriendd?.data?[Firstindex].frd.phoneNumber.toString()}");
                                                                    Navigator.pop(
                                                                        context);
                                                                  },
                                                                );
                                                              },
                                                              child: Container(
                                                                  margin: const EdgeInsets
                                                                          .only(
                                                                      top: 5),
                                                                  height: 20,
                                                                  width: 100,
                                                                  alignment:
                                                                      Alignment
                                                                          .center,
                                                                  child: Padding(
                                                                      padding: const EdgeInsets
                                                                              .only(
                                                                          left:
                                                                              8.0),
                                                                      child: customText(
                                                                          "Yes",
                                                                          ColorCodes
                                                                              .greyText,
                                                                          14,
                                                                          FontWeight
                                                                              .w400,
                                                                          poppins))),
                                                            )
                                                          ],
                                                        )
                                                      ],
                                                    );
                                                  },
                                                );
                                                // if(c.contains(_searchbar.text.isNotEmpty? b[index].toString(): usersviewsCubit.viewAllUsers!.data?[index].phoneNumber.toString())){
                                                //   c.remove(_searchbar.text.isNotEmpty? b[index].toString(): usersviewsCubit.viewAllUsers!.data?[index].phoneNumber.toString());
                                                // }else{
                                                //   c.add(_searchbar.text.isNotEmpty? b[index].toString(): usersviewsCubit.viewAllUsers!.data?[index].phoneNumber.toString());
                                                // }

                                                print("hello");
                                              },
                                              child: customText(
                                                  'Remove',
                                                  Colors.black,
                                                  10,
                                                  FontWeight.w100,
                                                  poppins),
                                            ))
                                      else
                                        Container(
                                          margin: EdgeInsets.only(
                                              left: screenWidth(context,
                                                  dividedBy: 15)),
                                          height: screenHeight(context,
                                              dividedBy: 25),
                                          width: screenWidth(context,
                                              dividedBy: 5.5),
                                          alignment: Alignment.center,
                                          decoration: BoxDecoration(
                                              color: ColorCodes.coral,
                                              borderRadius:
                                                  BorderRadius.circular(25)),
                                          child: GestureDetector(
                                            onTap: () {
                                              setState(() {
                                                if (c.contains(mutualFrdsCubit
                                                    .mutulfriendd
                                                    ?.data?[Firstindex]
                                                    .frd
                                                    .phoneNumber
                                                    .toString())) {
                                                  c.remove(mutualFrdsCubit
                                                      .mutulfriendd
                                                      ?.data?[Firstindex]
                                                      .frd
                                                      .phoneNumber
                                                      .toString());
                                                } else {
                                                  c.add(mutualFrdsCubit
                                                      .mutulfriendd
                                                      ?.data?[Firstindex]
                                                      .frd
                                                      .phoneNumber
                                                      .toString());
                                                  buildGroupCubit.getBuilGrop(
                                                      context,
                                                      checkData: c);
                                                }
                                                f = groupViewCubit.uniqueArray;
                                                e.addAll(c);
                                                isBotton = true;
                                                c.clear();
                                              });
                                            },
                                            child: customText(
                                                'Add',
                                                Colors.white,
                                                10,
                                                FontWeight.w100,
                                                poppins),
                                          ),
                                        ),
                                      SizedBox(
                                          width: screenWidth(context,
                                              dividedBy: 30)),
                                      // (d.contains(_searchbar.text.isNotEmpty? b[index].toString(): usersviewsCubit.viewAllUsers!.data?[index].phoneNumber.toString()) ) ?
                                      // InkWell(
                                      //     onTap: () {
                                      //       setState(() {
                                      //         if(d.contains(_searchbar.text.isNotEmpty? b[index].toString(): usersviewsCubit.viewAllUsers!.data?[index].phoneNumber.toString())){
                                      //           d.remove(_searchbar.text.isNotEmpty? b[index].toString(): usersviewsCubit.viewAllUsers!.data?[index].phoneNumber.toString());
                                      //         }else{
                                      //           d.add(_searchbar.text.isNotEmpty? b[index].toString(): usersviewsCubit.viewAllUsers!.data?[index].phoneNumber.toString());
                                      //         }
                                      //         isBotton = false;
                                      //       });
                                      //
                                      //     },
                                      //     child: Icon(Icons.keyboard_arrow_down_sharp)) :
                                      // InkWell(
                                      //     onTap: () {
                                      //       setState(() {
                                      //         if(d.contains(_searchbar.text.isNotEmpty? b[index].toString(): usersviewsCubit.viewAllUsers!.data?[index].phoneNumber.toString())){
                                      //           d.remove(_searchbar.text.isNotEmpty? b[index].toString(): usersviewsCubit.viewAllUsers!.data?[index].phoneNumber.toString());
                                      //         }else{
                                      //           d.add(_searchbar.text.isNotEmpty? b[index].toString(): usersviewsCubit.viewAllUsers!.data?[index].phoneNumber.toString());
                                      //         }
                                      //         isBotton = true;
                                      //       });
                                      //     },
                                      //     child: Icon(Icons.keyboard_arrow_right_rounded))
                                    ],
                                  ),
                                ),
                                // ( isBotton == true && d.contains(_searchbar.text.isNotEmpty? b[index].toString(): usersviewsCubit.viewAllUsers!.data?[index].phoneNumber.toString()))
                                //     ? Container(
                                //     height: screenHeight(context, dividedBy: 8),
                                //     width: screenWidth(context, dividedBy: 1.1),
                                //     alignment: Alignment.center,
                                //     margin: EdgeInsets.only(
                                //         top: screenHeight(context, dividedBy: 60)),
                                //     decoration: BoxDecoration(
                                //         color: Colors.white,
                                //         borderRadius: BorderRadius.circular(8),
                                //         boxShadow: const [
                                //           BoxShadow(
                                //             color: Colors.black12,
                                //             blurRadius: 5,
                                //           )
                                //         ]),
                                //     child: Row(
                                //       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                //       children: [
                                //         Column(
                                //           crossAxisAlignment: CrossAxisAlignment.start,
                                //           mainAxisAlignment: MainAxisAlignment.spaceAround,
                                //           children: [
                                //             (usersviewsCubit.viewAllUsers!.data?[index].birthday.toString() == null) ?
                                //             dateListTile(
                                //                 image: ImageConstants.birthDay,
                                //                 eventName: 'BirthDay',
                                //                 date: '00-00-00')
                                //            : dateListTile(
                                //                 image: ImageConstants.birthDay,
                                //                 eventName: 'BirthDay',
                                //                 date: '${usersviewsCubit.viewAllUsers!.data?[index].birthday.toString().substring(0,10)}'),
                                //             dateListTile(
                                //                 image: ImageConstants.daughters,
                                //                 eventName: "Daughters' Day",
                                //                 date: '24-09-1993'),
                                //           ],
                                //         ),
                                //         Column(
                                //           crossAxisAlignment: CrossAxisAlignment.start,
                                //           mainAxisAlignment: MainAxisAlignment.spaceAround,
                                //           children: [
                                //             dateListTile(
                                //                 image: ImageConstants.anniversary,
                                //                 eventName: 'Anniversary',
                                //                 date: '02-07-2000'),
                                //             dateListTile(
                                //                 image: ImageConstants.womens,
                                //                 eventName: "Women's Day",
                                //                 date: '02-07-2000'),
                                //           ],
                                //         ),
                                //         Column(
                                //           crossAxisAlignment: CrossAxisAlignment.start,
                                //           mainAxisAlignment: MainAxisAlignment.spaceAround,
                                //           children: [
                                //             dateListTile(
                                //                 image: ImageConstants.valentine,
                                //                 eventName: "Valentine's Day",
                                //                 date: '14-02-2023'),
                                //             dateListTile(
                                //                 image: ImageConstants.mothers,
                                //                 eventName: "Mother's Day",
                                //                 date: '14-02-2023'),
                                //           ],
                                //         )
                                //       ],
                                //     )
                                // )
                                //     : SizedBox(),
                              ],
                            );
                          },
                        ),
                      );
                    }
                    return SizedBox();
                  },
                ),
              ),
              //  Center(
              //   child: Container(
              //     // margin: EdgeInsets.only(
              //     //     left: screenWidth(context, dividedBy: 6)),
              //     height: screenHeight(context, dividedBy: 20),
              //     width: screenWidth(context, dividedBy: 3),
              //     alignment: Alignment.center,
              //     decoration: BoxDecoration(
              //      border: GradientBoxBorder(gradient: coralTealColor, width: 1),
              //         color: ColorCodes.coral,
              //         boxShadow: const [
              //           BoxShadow(
              //             color: Colors.black12,
              //             blurRadius: 5,
              //           )
              //         ],
              //         borderRadius: BorderRadius.circular(7)),
              //     child: GestureDetector(
              //       onTap: () {
              //         setState(() {
              //           buildGroupCubit.getBuilGrop(context, checkData: c);
              //           c.clear();
              //         });
              //       },
              //       child: customText('Add GFTRs', Colors.white, 15,
              //           FontWeight.w100, poppins),
              //     ),
              //   ),
              // ),

              SizedBox(
                height: screenHeight(context, dividedBy: 50),
              ),
              customText("Invite New Gftrs", Colors.black, 18, FontWeight.w600,
                  poppins),
              customText("Help Grow The Gftr Family!", Colors.black, 16,
                  FontWeight.w400, poppins),
              SizedBox(height: screenHeight(context, dividedBy: 35)),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () {
                      String message =
                          "Hi! Please Join me on GFTR, the wishlist/gifting/micro-social newtork platform we've all been waiting for. Get Gifting (and get Gifted!) by downloading the app: http://i.diwai.com/nBKqvS";
                      sendSMS(message: message, recipients: smsNumbers);
                      setState(() {});
                    },
                    child: Container(
                      height: screenHeight(context, dividedBy: 20),
                      width: screenWidth(context, dividedBy: 3.5),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          border: GradientBoxBorder(
                              gradient: coralTealColor, width: 1),
                          borderRadius: BorderRadius.circular(25)),
                      child: customText('Invite By Text', ColorCodes.coral, 10,
                          FontWeight.w500, poppins),
                    ),
                  ),
                  SizedBox(width: screenWidth(context, dividedBy: 20)),
                  customText("Or", Colors.black, 11, FontWeight.w400, poppins),
                  SizedBox(width: screenWidth(context, dividedBy: 20)),
                  GestureDetector(
                    onTap: () async {
                      // sendEmail();
                      EmailText = """ 
Hello from The GFTR Group! We’re passing along an invitation from ${viewSettingCubit.viewSetting?.data?.firstname} ${viewSettingCubit.viewSetting?.data?.lastname} who thought you might be interested in joining the GFTR family.

GFTR’s motto is ‘Easy Giving’ - and that pretty much says it all. Our ‘micro-social network’ platform is a simple way to give (and receive) gifts that you and your loved ones actually want. Just save gift ideas to easy-to-use wishlists from anywhere and everywhere, get great ideas from our in-house GFTR Guide, check out what the members of your private GFTR Group are wishing for and… Get Gifting!

With GFTR, you know that every gift you give (and receive!) will be a home-run, without the waste or worry. To get started, come check us out http://i.diwai.com/nBKqvS or email us “hello@gftr.com” and say hello.

It’s great to meet you, we’re looking forward to gifting better together,

The GFTR Group

""";
                      await launchUrl(Uri.parse(
                          "mailto: ?subject=Invite and gifting in gftr&body=$EmailText"));

                      // flutterToast("Check Your Email", true);
                      // final Email email = Email(
                      //   body:
                      //   '${EmailText}',
                      //   subject: 'New Vendor Registed',
                      //   recipients: [''],
                      //   isHTML: true,
                      // );
                      // await FlutterEmailSender.send(email);
                      // String email =
                      //     Uri.encodeComponent("vhcreation2010@gmail.com");

                      // String subject = Uri.encodeComponent("Hello Flutter");

                      // String body =
                      //     Uri.encodeComponent("Hi! I'm Flutter Developer");

                      // Uri mail = Uri.parse(
                      //     "mailto:$email?subject=$subject&body=$body");

                      // await launchUrl(mail);

                      //
                      // flutterToast("Check Your Email", true);

                      setState(() {});
                    },
                    child: Container(
                      height: screenHeight(context, dividedBy: 20),
                      width: screenWidth(context, dividedBy: 3.5),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          border: GradientBoxBorder(
                              gradient: coralTealColor, width: 1),
                          borderRadius: BorderRadius.circular(25)),
                      child: customText('Invite By E-Mail', ColorCodes.coral,
                          10, FontWeight.w500, poppins),
                    ),
                  ),
                ],
              ),
              SizedBox(height: screenHeight(context, dividedBy: 20)),
            ],
          ),
        ),
      ),
    ));
  }
}
