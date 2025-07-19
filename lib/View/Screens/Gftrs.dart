import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_sms/flutter_sms.dart';
import 'package:gftr/Helper/apiConstants.dart';
import 'package:gftr/Helper/appConfig.dart';
import 'package:gftr/Helper/colorConstants.dart';
import 'package:gftr/Helper/imageConstants.dart';
import 'package:gftr/Model/contactverfy.dart';
import 'package:gftr/Model/decryption.dart';
import 'package:gftr/View/Screens/ManageBottom/gftrStoryViewPage.dart';
import 'package:gftr/View/Screens/helpPage.dart';
import 'package:gftr/View/Widgets/customLoader.dart';
import 'package:gftr/View/Widgets/customText.dart';
import 'package:gftr/View/Widgets/flutterToast.dart';
import 'package:gftr/ViewModel/Cubits/builGroup.dart';
import 'package:gftr/ViewModel/Cubits/contactVerfy.dart';
import 'package:gftr/ViewModel/Cubits/getContact.dart';
import 'package:gftr/ViewModel/Cubits/viewsetting.dart';
import 'package:gftr/ViewModel/apiServices.dart';
import 'package:gradient_borders/gradient_borders.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';
import 'package:url_launcher/url_launcher.dart';

// import 'package:mailer/smtp_server/gmail.dart';
// import 'package:mailer/mailer.dart';
class Gftrs extends StatefulWidget {
  @override
  State<Gftrs> createState() => _GftrsState();

  static const route = "/gftr_group";
}

class _GftrsState extends State<Gftrs> {
  LinearGradient coralTealColor = const LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [ColorCodes.teal, ColorCodes.coral],
  );
  final dio = Dio();
  Future view_all_users() async {
    Decryption? data = await DioClient()
        .decryptDataGetMethod(ApiConstants.verifiedContactList);
    Map<String, dynamic> body = {"encData": data?.data};
    try {
      final userData = await dio.post(ApiConstants.decryptData, data: body);
      Map _map = userData.data;
      setState(() {
        _users = _map['registered'];
        print("Users ===>$_users");
      });
      return null;
    } catch (e) {
      print("view user error ${e.toString()}");
      return null;
    }
  }

  List<Registered> listdata = [];
  List group = [];
  List<String> smsList = [];
  List search_result = [];
  List _users = [];
  void sendSms({required List<String> textinvite}) async {
    String message =
        "Hey there. ${viewSettingCubit.viewSetting?.data?.firstname} ${viewSettingCubit.viewSetting?.data?.lastname} wants you to join them on GFTR. Get gifting (and gifted!) by downloading the app http://i.diwai.com/nBKqvS";
    sendSMS(message: message, recipients: textinvite);
    textinvite.clear();
  }

  GetContactViewCubit getContactViewCubit = GetContactViewCubit();
  BuildGroupCubit buildGroupCubit = BuildGroupCubit();
  ViewSettingCubit viewSettingCubit = ViewSettingCubit();
  TextEditingController _searchbar = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getContactViewCubit = BlocProvider.of<GetContactViewCubit>(context);
    viewSettingCubit = BlocProvider.of<ViewSettingCubit>(context);
    viewSettingCubit.getviewSetting();
    getContactViewCubit.getContactsList();
    buildGroupCubit = BlocProvider.of<BuildGroupCubit>(context);
    view_all_users();
    search_result = _users;
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    getContactViewCubit.emailList.clear();
    getContactViewCubit.smslList.clear();
  }

  void sendEmail() async {
    String EmailText = """
Hello from The GFTR Group! We’re passing along an invitation from ${viewSettingCubit.viewSetting?.data?.firstname} ${viewSettingCubit.viewSetting?.data?.lastname} who thought you might be interested in joining the GFTR family. 

GFTR’s motto is ‘Easy Giving’ - and that pretty much says it all. Our ‘micro-social network’ platform is a simple way to give (and receive) gifts that you and your loved ones actually want. Just save gift ideas to easy-to-use wishlists (for you and them) from anywhere and everywhere, … get great ideas from our in-house GFTR Guide… check out what the members of your private GFTR Group are wishing for and… Get Gifting!

With GFTR, you know that every gift you give (and receive!) will be a home-run, without the waste or worry. To get started, come check us out  http://i.diwai.com/nBKqvS or email us “hello@gftr.com” and say hello. 

It’s great to meet you, we’re looking forward to gifting better together,

GFTR
""";
    await launchUrl(Uri.parse(
        "mailto: ?subject=Invite and gifting in gftr&body=$EmailText"));
    //  //String username = 'tanthetaa.flutter@gmail.com';
//     String username = 'admin@gftr.com';
//     String password = 'Gi5+er23!';
//     // String password = 'yvpulwxqalopiebc';
//     final smtpServer = gmail(username, password);
//     getContactViewCubit.emailList.forEach((element) async {
//       final message = Message()
//         ..from = Address(username)
//         ..recipients.add(element.email)
//         ..subject = 'Hey ${element.name} wants you on GFTR'
//         ..text = """
// Hello from The GFTR Group! We’re passing along an invitation from ${viewSettingCubit.viewSetting?.data?.firstname} ${viewSettingCubit.viewSetting?.data?.lastname} who thought you might be interested in joining the GFTR family.
//
// GFTR’s motto is ‘Easy Giving’ - and that pretty much says it all. Our ‘micro-social network’ platform is a simple way to give (and receive) gifts that you and your loved ones actually want. Just save gift ideas to easy-to-use wishlists (for you and them) from anywhere and everywhere, … get great ideas from our in-house GFTR Guide… check out what the members of your private GFTR Group are wishing for and… Get Gifting!
//
// With GFTR, you know that every gift you give (and receive!) will be a home-run, without the waste or worry. To get started, come check us out  http://i.diwai.com/nBKqvS or email us “hello@gftr.com” and say hello.
//
// It’s great to meet you, we’re looking forward to gifting better together,
//
// GFTR
// """;
//       try {
//         final sendReport = await send(message, smtpServer);
//         print('Message sent: ${sendReport.toString()}');
//       } on MailerException catch (e) {
//         print('Message not sent. ${e.toString()}');
//       }
//     });
//
//     getContactViewCubit.emailList.clear();
  }

  @override
  Widget build(BuildContext context) {
    LinearGradient coralTealColor = const LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [ColorCodes.teal, ColorCodes.coral],
    );
    return Scaffold(
      body: GestureDetector(
        onTap: () {
          FocusManager.instance.primaryFocus?.unfocus();
          setState(() {});
        },
        child: SizedBox(
          height: screenHeight(context),
          width: screenWidth(context),
          child: Stack(
            children: [
              Stack(
                children: [
                  SizedBox(
                    height: screenHeight(context, dividedBy: 3.5),
                    width: screenWidth(context),
                    child: Image.asset(
                      ImageConstants.gftrBack,
                      fit: BoxFit.cover,
                    ),
                  ), //gftr background image
                  Container(
                    alignment: Alignment.center,
                    height: screenHeight(context, dividedBy: 3.9),
                    width: screenWidth(context),
                    child: Image.asset(
                      ImageConstants.gftrLogo,
                      height: screenHeight(context, dividedBy: 5),
                      width: screenWidth(context, dividedBy: 5),
                      fit: BoxFit.contain,
                    ),
                  ),
                ],
              ),
              Container(
                height: screenHeight(context, dividedBy: 1.2),
                width: screenWidth(context),
                padding: EdgeInsets.only(
                    left: screenWidth(context, dividedBy: 15),
                    right: screenWidth(context, dividedBy: 15)),
                margin:
                    EdgeInsets.only(top: screenHeight(context, dividedBy: 4.8)),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(60)),
                ),
                child: Padding(
                  padding: EdgeInsets.only(
                      top: screenHeight(context, dividedBy: 40)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(
                            left: screenWidth(context, dividedBy: 60)),
                        child: Row(
                          children: [
                            customText("Build your", Colors.black, 16,
                                FontWeight.w100, madeOuterSans),
                            Container(
                              height: screenHeight(context, dividedBy: 40),
                              width: screenWidth(context, dividedBy: 8),
                              child: Image.asset(ImageConstants.gftrBlack),
                            ),
                            customText("group...", Colors.black, 16,
                                FontWeight.w100, madeOuterSans),
                            GestureDetector(
                              onTap: () {
                                sendEmail();
                                // flutterToast("Check Your Email", true);
                              },
                              child: Container(
                                margin: EdgeInsets.only(
                                    left: screenWidth(context, dividedBy: 30)),
                                height: screenHeight(context, dividedBy: 25),
                                width: screenWidth(context, dividedBy: 4.2),
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(50),
                                  border: const GradientBoxBorder(
                                    gradient: LinearGradient(
                                      colors: [
                                        Color(0xffF37A5B),
                                        Color(0xff4BADB8)
                                      ],
                                    ),
                                  ),
                                ),
                                child: const Text("invite By E-Mail",
                                    style: TextStyle(
                                        color: ColorCodes.coral,
                                        fontWeight: FontWeight.w400,
                                        fontSize: 11)),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                          alignment: Alignment.center,
                          height: screenHeight(context, dividedBy: 13),
                          width: screenWidth(context),
                          margin: EdgeInsets.only(
                              top: screenHeight(context, dividedBy: 30)),
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
                            onChanged: (value) {
                              setState(() {
                                search_result = _users
                                    .where((element) => element
                                        .toString()
                                        .toLowerCase()
                                        .contains(value.toLowerCase()))
                                    .toList();
                                print("result :$search_result");
                              });
                            },
                            cursorColor: ColorCodes.teal,
                            decoration: InputDecoration(
                                fillColor: ColorCodes.coral,
                                border: GradientOutlineInputBorder(
                                    gradient: coralTealColor),
                                hintText: 'Search for a Gftr',
                                prefixIcon: Padding(
                                  padding: EdgeInsets.all(10),
                                  child: Image.asset(ImageConstants.search,
                                      color: ColorCodes.greyText,
                                      height: 5,
                                      width: 5),
                                )),
                            controller: _searchbar,
                          )),
                      BlocBuilder<ContactVierfyCubit, ContactVierfyState>(
                        builder: (context, state) {
                          if (state is ContactVierfyLoading) {
                            return Expanded(
                                child: Center(
                              child: spinkitLoader(context, ColorCodes.coral),
                            ));
                          }
                          if (state is ContactVierfySuccess) {
                            return Expanded(
                              child: _searchbar.text.isNotEmpty
                                  ? ListView.builder(
                                      physics: const BouncingScrollPhysics(),
                                      itemCount: search_result.length,
                                      itemBuilder: (context, index) {
                                        return Container(
                                          padding: EdgeInsets.only(
                                            left: screenWidth(context,
                                                dividedBy: 80),
                                            right: screenWidth(context,
                                                dividedBy: 80),
                                          ),
                                          height: screenHeight(context,
                                              dividedBy: 13),
                                          width: screenWidth(context,
                                              dividedBy: 1.2),
                                          margin: const EdgeInsets.all(5),
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            boxShadow: const [
                                              BoxShadow(
                                                  color: Colors.black26,
                                                  blurRadius: 5),
                                            ],
                                          ),
                                          child: Padding(
                                            padding:
                                                const EdgeInsets.only(left: 5),
                                            child: Row(
                                              // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                Container(
                                                  decoration: BoxDecoration(
                                                      border: GradientBoxBorder(
                                                          gradient:
                                                              coralTealColor,
                                                          width: 2),
                                                      shape: BoxShape.circle),
                                                  child: const CircleAvatar(
                                                    backgroundImage: AssetImage(
                                                        ImageConstants
                                                            .dummyProfile),
                                                    radius: 20,
                                                  ),
                                                ),
                                                Padding(
                                                  padding: EdgeInsets.only(
                                                    left: screenWidth(context,
                                                        dividedBy: 100),
                                                  ),
                                                  child: Container(
                                                    // color: Colors.red,
                                                    width: screenWidth(context,
                                                        dividedBy: 5),
                                                    child: Text(
                                                      search_result[index]
                                                          ['userName'],
                                                      style: const TextStyle(
                                                          color:
                                                              Color(0xff231F20),
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 12),
                                                    ),
                                                  ),
                                                ),
                                                search_result[index]
                                                            ['isVerified'] ==
                                                        true
                                                    ? Container(
                                                        height: screenHeight(
                                                            context,
                                                            dividedBy: 50),
                                                        width: screenWidth(
                                                            context,
                                                            dividedBy: 28),
                                                        child: Image.asset(
                                                            ImageConstants
                                                                .gIcon),
                                                      )
                                                    : SizedBox(),
                                                search_result[index]
                                                            ['isVerified'] ==
                                                        true
                                                    ? GestureDetector(
                                                        onTap: () {
                                                          if (getContactViewCubit
                                                                  .getContactList
                                                                  ?.registered?[
                                                                      index]
                                                                  .isGroup ==
                                                              false) {
                                                            getContactViewCubit
                                                                .getContactList
                                                                ?.registered?[
                                                                    index]
                                                                .isGroup = true;
                                                          } else {
                                                            getContactViewCubit
                                                                .getContactList
                                                                ?.registered?[
                                                                    index]
                                                                .isGroup = false;
                                                          }
                                                          if (getContactViewCubit
                                                                  .getContactList
                                                                  ?.registered?[
                                                                      index]
                                                                  .isGroup ==
                                                              true) {
                                                            listdata.add(Registered(
                                                                phoneNumber: search_result[
                                                                            index]
                                                                        [
                                                                        'phoneNumber']
                                                                    .toString()));
                                                            group.add(listdata[
                                                                    index]
                                                                .phoneNumber);
                                                          } else {
                                                            group.remove(
                                                                listdata[index]
                                                                    .phoneNumber);
                                                          }

                                                          log(group.toString());
                                                          setState(() {});
                                                        },
                                                        child: Container(
                                                          height: screenHeight(
                                                              context,
                                                              dividedBy: 25),
                                                          width: screenWidth(
                                                              context,
                                                              dividedBy: 5.3),
                                                          margin:
                                                              EdgeInsets.only(
                                                            left: screenWidth(
                                                                context,
                                                                dividedBy: 5.9),
                                                          ),
                                                          decoration:
                                                              BoxDecoration(
                                                            gradient: getContactViewCubit
                                                                        .getContactList
                                                                        ?.registered?[
                                                                            index]
                                                                        .isGroup ==
                                                                    true
                                                                ? coralTealColor
                                                                : const LinearGradient(
                                                                    colors: [
                                                                        ColorCodes
                                                                            .coral,
                                                                        ColorCodes
                                                                            .coral
                                                                      ]),
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        40),
                                                          ),
                                                          child: Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .center,
                                                            children: [
                                                              getContactViewCubit
                                                                          .getContactList
                                                                          ?.registered?[
                                                                              index]
                                                                          .isGroup ==
                                                                      true
                                                                  ? Image.asset(
                                                                      ImageConstants
                                                                          .askLogo,
                                                                      width: 15,
                                                                      height:
                                                                          15)
                                                                  : const SizedBox(),
                                                              Padding(
                                                                padding: EdgeInsets.only(
                                                                    left: screenWidth(
                                                                        context,
                                                                        dividedBy:
                                                                            70)),
                                                                child: Text(
                                                                    getContactViewCubit.getContactList?.registered?[index].isGroup ==
                                                                            true
                                                                        ? "Asked"
                                                                        : 'Add',
                                                                    style:
                                                                        const TextStyle(
                                                                      fontSize:
                                                                          12,
                                                                      color: Color(
                                                                          0xffFFFFFF),
                                                                    )),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      )
                                                    : GestureDetector(
                                                        onTap: () {
                                                          smsList.add(
                                                              search_result[
                                                                      index][
                                                                  'phoneNumber']);
                                                          log(smsList
                                                              .toString());
                                                          sendSms(
                                                              textinvite:
                                                                  smsList);
                                                          smsList.clear();
                                                        },
                                                        child: Container(
                                                          alignment:
                                                              Alignment.center,
                                                          height: screenHeight(
                                                              context,
                                                              dividedBy: 25),
                                                          width: screenWidth(
                                                              context,
                                                              dividedBy: 5.3),
                                                          margin:
                                                              EdgeInsets.only(
                                                            left: screenWidth(
                                                                context,
                                                                dividedBy: 5.1),
                                                          ),
                                                          decoration: BoxDecoration(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          40),
                                                              border: GradientBoxBorder(
                                                                  gradient:
                                                                      coralTealColor)),
                                                          child: customText(
                                                              "invite",
                                                              ColorCodes.coral,
                                                              12,
                                                              FontWeight.w400,
                                                              poppins),
                                                        ),
                                                      ),
                                              ],
                                            ),
                                          ),
                                        );
                                      },
                                    )
                                  : ListView.builder(
                                      physics: const BouncingScrollPhysics(),
                                      itemCount: getContactViewCubit
                                          .getContactList?.registered?.length,
                                      itemBuilder: (context, index) {
                                        return Container(
                                          padding: EdgeInsets.only(
                                            left: screenWidth(context,
                                                dividedBy: 80),
                                            right: screenWidth(context,
                                                dividedBy: 80),
                                          ),
                                          height: screenHeight(context,
                                              dividedBy: 13),
                                          width: screenWidth(context,
                                              dividedBy: 1.2),
                                          margin: const EdgeInsets.all(5),
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            boxShadow: const [
                                              BoxShadow(
                                                  color: Colors.black26,
                                                  blurRadius: 5),
                                            ],
                                          ),
                                          child: Padding(
                                            padding:
                                                const EdgeInsets.only(left: 5),
                                            child: Row(
                                              // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                Container(
                                                  decoration: BoxDecoration(
                                                      border: GradientBoxBorder(
                                                          gradient:
                                                              coralTealColor,
                                                          width: 2),
                                                      shape: BoxShape.circle),
                                                  child: const CircleAvatar(
                                                    backgroundImage: AssetImage(
                                                        ImageConstants
                                                            .dummyProfile),
                                                    radius: 20,
                                                  ),
                                                ),
                                                Padding(
                                                  padding: EdgeInsets.only(
                                                    left: screenWidth(context,
                                                        dividedBy: 100),
                                                  ),
                                                  child: Container(
                                                    // color: Colors.red,
                                                    width: screenWidth(context,
                                                        dividedBy: 5),
                                                    child: Text(
                                                      getContactViewCubit
                                                              .getContactList
                                                              ?.registered?[
                                                                  index]
                                                              .userName ??
                                                          "",
                                                      style: const TextStyle(
                                                          color:
                                                              Color(0xff231F20),
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 12),
                                                    ),
                                                  ),
                                                ),
                                                getContactViewCubit
                                                            .getContactList
                                                            ?.registered?[index]
                                                            .isVerified ==
                                                        true
                                                    ? Container(
                                                        height: screenHeight(
                                                            context,
                                                            dividedBy: 50),
                                                        width: screenWidth(
                                                            context,
                                                            dividedBy: 28),
                                                        child: Image.asset(
                                                            ImageConstants
                                                                .gIcon),
                                                      )
                                                    : SizedBox(),
                                                getContactViewCubit
                                                            .getContactList
                                                            ?.registered?[index]
                                                            .isVerified ==
                                                        true
                                                    ? GestureDetector(
                                                        onTap: () {
                                                          if (getContactViewCubit
                                                                  .getContactList
                                                                  ?.registered?[
                                                                      index]
                                                                  .isGroup ==
                                                              false) {
                                                            getContactViewCubit
                                                                .getContactList
                                                                ?.registered?[
                                                                    index]
                                                                .isGroup = true;
                                                          } else {
                                                            getContactViewCubit
                                                                .getContactList
                                                                ?.registered?[
                                                                    index]
                                                                .isGroup = false;
                                                          }
                                                          if (getContactViewCubit
                                                                  .getContactList
                                                                  ?.registered?[
                                                                      index]
                                                                  .isGroup ==
                                                              true) {
                                                            listdata.add(Registered(
                                                                phoneNumber: getContactViewCubit
                                                                    .getContactList
                                                                    ?.registered?[
                                                                        index]
                                                                    .phoneNumber
                                                                    .toString()));
                                                            group.add(listdata[
                                                                    index]
                                                                .phoneNumber);
                                                          } else {
                                                            group.remove(
                                                                listdata[index]
                                                                    .phoneNumber);
                                                          }

                                                          log(group.toString());
                                                          setState(() {});
                                                        },
                                                        child: Container(
                                                          height: screenHeight(
                                                              context,
                                                              dividedBy: 25),
                                                          width: screenWidth(
                                                              context,
                                                              dividedBy: 5.3),
                                                          margin:
                                                              EdgeInsets.only(
                                                            left: screenWidth(
                                                                context,
                                                                dividedBy: 5.9),
                                                          ),
                                                          decoration:
                                                              BoxDecoration(
                                                            gradient: getContactViewCubit
                                                                        .getContactList
                                                                        ?.registered?[
                                                                            index]
                                                                        .isGroup ==
                                                                    true
                                                                ? coralTealColor
                                                                : const LinearGradient(
                                                                    colors: [
                                                                        ColorCodes
                                                                            .coral,
                                                                        ColorCodes
                                                                            .coral
                                                                      ]),
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        40),
                                                          ),
                                                          child: Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .center,
                                                            children: [
                                                              getContactViewCubit
                                                                          .getContactList
                                                                          ?.registered?[
                                                                              index]
                                                                          .isGroup ==
                                                                      true
                                                                  ? Image.asset(
                                                                      ImageConstants
                                                                          .askLogo,
                                                                      width: 15,
                                                                      height:
                                                                          15)
                                                                  : const SizedBox(),
                                                              Padding(
                                                                padding: EdgeInsets.only(
                                                                    left: screenWidth(
                                                                        context,
                                                                        dividedBy:
                                                                            70)),
                                                                child: Text(
                                                                    getContactViewCubit.getContactList?.registered?[index].isGroup ==
                                                                            true
                                                                        ? "Asked"
                                                                        : 'Add',
                                                                    style:
                                                                        const TextStyle(
                                                                      fontSize:
                                                                          12,
                                                                      color: Color(
                                                                          0xffFFFFFF),
                                                                    )),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      )
                                                    : GestureDetector(
                                                        onTap: () {
                                                          smsList.add(getContactViewCubit
                                                                  .getContactList
                                                                  ?.registered?[
                                                                      index]
                                                                  .phoneNumber
                                                                  .toString() ??
                                                              '');
                                                          log(smsList
                                                              .toString());
                                                          sendSms(
                                                              textinvite:
                                                                  smsList);
                                                          smsList.clear();
                                                        },
                                                        child: Container(
                                                          alignment:
                                                              Alignment.center,
                                                          height: screenHeight(
                                                              context,
                                                              dividedBy: 25),
                                                          width: screenWidth(
                                                              context,
                                                              dividedBy: 5.3),
                                                          margin:
                                                              EdgeInsets.only(
                                                            left: screenWidth(
                                                                context,
                                                                dividedBy: 5.1),
                                                          ),
                                                          decoration: BoxDecoration(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          40),
                                                              border: GradientBoxBorder(
                                                                  gradient:
                                                                      coralTealColor)),
                                                          child: customText(
                                                              "invite",
                                                              ColorCodes.coral,
                                                              12,
                                                              FontWeight.w400,
                                                              poppins),
                                                        ),
                                                      ),
                                              ],
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                            );
                          }
                          log("getContactState : $state");
                          return Expanded(
                              child: Center(
                            child: customText('Not Found Contact',
                                Colors.black38, 14, FontWeight.w400, poppins),
                          ));
                        },
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10),
                child: GestureDetector(
                  onTap: () {
                    buildGroupCubit.getBuilGrop(context, checkData: group);
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const HelpPage()));
                    bottombarblack = false;
                  },
                  child: Container(
                    margin: EdgeInsets.only(
                      top: screenHeight(context, dividedBy: 1.15),
                      left: screenWidth(context, dividedBy: 3.5),
                    ),
                    height: screenHeight(context, dividedBy: 22),
                    width: screenWidth(context, dividedBy: 2.8),
                    decoration: BoxDecoration(
                      color: ColorCodes.coral,
                      borderRadius: BorderRadius.circular(40),
                    ),
                    child: const Center(
                      child: Text("Done!",
                          style: TextStyle(
                              fontSize: 16,
                              color: Color(0xffFFFFFF),
                              fontWeight: FontWeight.w400)),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ), //Main Container
    );
  }
}
