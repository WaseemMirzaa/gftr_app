import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:gftr/Helper/appConfig.dart';
import 'package:gftr/Helper/colorConstants.dart';
import 'package:gftr/Helper/imageConstants.dart';
import 'package:gftr/Model/contactverfy.dart';
import 'package:gftr/View/Screens/Gftrs.dart';
import 'package:gftr/View/Screens/allAbout.dart';
import 'package:gftr/View/Screens/helpPage.dart';
import 'package:gftr/View/Widgets/customLoader.dart';
import 'package:gftr/View/Widgets/customText.dart';
import 'package:gftr/View/Widgets/flutterToast.dart';
import 'package:gftr/ViewModel/Cubits/contactVerfy.dart';
import 'package:gftr/ViewModel/Cubits/getContact.dart';

class Welcome extends StatefulWidget {
  const Welcome({Key? key}) : super(key: key);

  @override
  State<Welcome> createState() => _WelcomeState();
}

ContactVierfyCubit contactVierfyCubit = ContactVierfyCubit();

class _WelcomeState extends State<Welcome> {
  List<Contact> contacts =    [];
  List<Registered> listdata = [];

  // List smsList=[];
  bool isLoding=false;
  Future<void> getContact() async {
    if (await FlutterContacts.requestPermission()) {
       isLoding = true;
      contacts = await FlutterContacts.getContacts(
          withProperties: true, withPhoto: true);
      contacts.forEach((element) {
        String number =
            (element.phones.isNotEmpty) ? (element.phones.first.number) : " ";
        print(number);
        listdata.add(Registered(
            userName: element.displayName.toString(), phoneNumber: number));
      });
      setState(() {});
    }
    // await contactVierfyCubit.getContactFetch(context, checkData: listdata);
  }

  GetContactViewCubit getContactViewCubit = GetContactViewCubit();


  @override
  void initState() {
    super.initState();
    contactVierfyCubit = BlocProvider.of<ContactVierfyCubit>(context);
    getContactViewCubit = BlocProvider.of<GetContactViewCubit>(context);
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Stack(
        children: [
          SizedBox(
            width: screenWidth(context),
            height: screenHeight(context),
            child: Image.asset(
              ImageConstants.welcomeBackGround,
              fit: BoxFit.fill,
            ),
          ),
          SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: screenHeight(context, dividedBy: 10),
                ),
                customText("Welcome to", Colors.white, 20, FontWeight.w400,
                    madeOuterSans),
                SizedBox(
                  height: screenHeight(context, dividedBy: 90),
                ),
                Center(
                  child: Container(
                    color: Colors.transparent,
                    alignment: Alignment.bottomCenter,
                    height: screenHeight(context, dividedBy: 3.5),
                    width: screenHeight(context, dividedBy: 3.5),
                    child: Image.asset(
                      ImageConstants.gftrLogo,
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
                SizedBox(
                  height: screenHeight(context, dividedBy: 30),
                ),
                GestureDetector(
                    onTap: () => Navigator.push(context,
                        MaterialPageRoute(builder: (context) => AllAbout())),
                    child: customText("What we're all about", Colors.white, 5,
                        FontWeight.w100, poppins,
                        isTextUnderline: true)),
                SizedBox(
                  height: screenHeight(context, dividedBy: 8),
                ),
                customText("Build your Gftr group", Colors.white, 20,
                    FontWeight.w600, poppins),
                SizedBox(
                  height: screenHeight(context, dividedBy: 20),
                ),
                Padding(
                  padding: EdgeInsets.only(
                    left: screenWidth(context, dividedBy: 20),
                    right: screenWidth(context, dividedBy: 20),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: () async {
                          flutterToast(
                              "Please wait, It can take up to a minute depending on contacts",
                              false);
                          await getContact().then((value) => isLoding = false);
                          contactVierfyCubit
                              .getContactFetch(context, checkData: listdata)
                              .then((value) async =>
                                  await getContactViewCubit.getContactsList())
                              .then((value) => Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => Gftrs(),
                                  )));
                          setState(() {});
                        },
                        child: Container(
                            height: screenHeight(context, dividedBy: 20),
                            width: screenWidth(context, dividedBy: 2.5),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50),
                              gradient: const LinearGradient(
                                colors: [Color(0xff4BADB8), Color(0xffF37A5B)],
                              ),
                            ),
                            child: Stack(children: [
                              Center(
                                  child: Container(
                                      height:
                                          screenHeight(context, dividedBy: 22),
                                      width:
                                          screenWidth(context, dividedBy: 2.55),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(20),
                                        color: ColorCodes.backgroundcolor,
                                      ),
                                      child: Center(
                                        child: isLoding == true
                                            ? spinkitLoader(
                                                context, ColorCodes.coral)
                                            : BlocBuilder<ContactVierfyCubit,
                                                    ContactVierfyState>(
                                                builder: (context, state) {
                                                if (state
                                                    is ContactVierfyLoading) {
                                                  return spinkitLoader(context,
                                                      ColorCodes.coral);
                                                }
                                                return BlocBuilder<
                                                        GetContactViewCubit,
                                                        GetContactViewState>(
                                                    builder: (context, state) {
                                                  log(state.toString());
                                                  if (state
                                                      is GetContactViewLoading) {
                                                    return spinkitLoader(
                                                        context,
                                                        ColorCodes.coral);
                                                  }
                                                  return Text(
                                                      "Upload From contacts",
                                                      style: TextStyle(
                                                          color: Colors.white,
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          fontSize: 12));
                                                });
                                              }),
                                      )))
                            ])),
                      ),
                      SizedBox(
                        height: screenHeight(context, dividedBy: 50),
                      ),
                      customText(
                          "OR", Colors.white, 14, FontWeight.w500, poppins),
                      SizedBox(
                        height: screenHeight(context, dividedBy: 50),
                      ),
                      GestureDetector(
                        onTap: () async {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => HelpPage(),));
                        },
                        child: Container(
                          height: screenHeight(context, dividedBy: 20),
                          width: screenWidth(context, dividedBy: 2.5),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50),
                            gradient: const LinearGradient(
                              colors: [ColorCodes.teal, ColorCodes.coral],
                            ),
                          ),
                          child: Stack(
                            children: [
                              Center(
                                child: Container(
                                  height: screenHeight(context, dividedBy: 22),
                                  width: screenWidth(context, dividedBy: 2.55),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    color: ColorCodes.backgroundcolor,
                                  ),
                                  child: Center(
                                      child: Text("Add Gftrs Manually",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.w500,
                                              fontSize: 12))),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
