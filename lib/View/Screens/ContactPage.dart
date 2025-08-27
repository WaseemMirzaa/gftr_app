import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gftr/Helper/appConfig.dart';
import 'package:gftr/Helper/imageConstants.dart';
import 'package:gftr/View/Widgets/customLoader.dart';
import 'package:gftr/View/Widgets/flutterToast.dart';
import 'package:gftr/ViewModel/Cubits/contactGftr.dart';
import '../../Helper/colorConstants.dart';
import '../Widgets/commonAuthenticationtextField.dart';
import '../Widgets/customText.dart';

class ContactPage extends StatefulWidget {
  const ContactPage({Key? key}) : super(key: key);

  @override
  State<ContactPage> createState() => _ContactPageState();
}

class _ContactPageState extends State<ContactPage> {
  TextEditingController yourName = TextEditingController();
  TextEditingController yourEmail = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController yourText = TextEditingController();

  late ContactGftrCubit contactGftrCubit = ContactGftrCubit();

  FocusNode nameNode = FocusNode();
  FocusNode phoneNode = FocusNode();
  FocusNode emailNode = FocusNode();
  FocusNode textNode = FocusNode();

  @override
  void initState() {
    super.initState();
    contactGftrCubit = BlocProvider.of<ContactGftrCubit>(context);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
          backgroundColor: Colors.white10,
          body: SizedBox(
              height: screenHeight(context),
              width: screenWidth(context),
              child: Stack(children: [
                Stack(children: [
                  SizedBox(
                      height: screenHeight(context, dividedBy: 3.2),
                      width: screenWidth(context),
                      child: Image.asset(
                        ImageConstants.gftrBack,
                        fit: BoxFit.cover,
                      )),
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
                  Padding(
                    padding: EdgeInsets.only(
                        left: screenWidth(context, dividedBy: 25),
                        top: screenHeight(context, dividedBy: 15)),
                    child: GestureDetector(
                        onTap: () => Navigator.pop(context),
                        child: Icon(Icons.arrow_back_ios_outlined,
                            size: 20, color: Colors.white)),
                  ),
                ]),
                Container(
                    height: screenHeight(context, dividedBy: 1.2),
                    width: screenWidth(context),
                    margin: EdgeInsets.only(
                        top: screenHeight(context, dividedBy: 4.8)),
                    decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius:
                            BorderRadius.only(topLeft: Radius.circular(60))),
                    child: Column(children: [
                      Container(
                          margin: EdgeInsets.only(
                            top: screenHeight(context, dividedBy: 40),
                            left: screenWidth(context, dividedBy: 11),
                          ),
                          alignment: Alignment.center,
                          height: screenHeight(context, dividedBy: 20),
                          child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                customText("Contact us!", Colors.black, 25,
                                    FontWeight.w200, madeOuterSans),
                                SizedBox(
                                  width: screenWidth(context, dividedBy: 50),
                                ),
                                // Padding(
                                //   padding: EdgeInsets.only(
                                //       top: screenWidth(context, dividedBy: 50)),
                                //   child: SizedBox(
                                //       height:
                                //           screenHeight(context, dividedBy: 22),
                                //       width:
                                //           screenHeight(context, dividedBy: 22),
                                //       child: Image.asset(
                                //           ImageConstants.gftrBlack,
                                //           color: Colors.black)),
                                // )
                              ])),
                      Padding(
                        padding: EdgeInsets.only(
                          left: screenWidth(context, dividedBy: 10),
                        ),
                        child: customText(
                            "Drop us a line with any questions, comments or concerns and we’ll get right back to you!",
                            ColorCodes.greyText,
                            14,
                            FontWeight.w400,
                            poppins),
                      ),
                      Expanded(
                        child: SingleChildScrollView(
                          physics: const BouncingScrollPhysics(),
                          child: Column(
                            children: [
                              SizedBox(
                                height: screenHeight(context, dividedBy: 40),
                              ),
                              Container(
                                  padding: EdgeInsets.only(
                                      top: MediaQuery.of(context).size.height *
                                          .00001,
                                      right: 15),
                                  child: Center(
                                      child: Column(children: [
                                    Padding(
                                        padding: EdgeInsets.only(
                                          left: screenWidth(context,
                                              dividedBy: 12),
                                        ),
                                        child: Container(
                                            // height: screenHeight(context, dividedBy: 19),
                                            width: screenWidth(context),
                                            decoration: BoxDecoration(
                                                color: Colors.white,
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                boxShadow: [
                                                  BoxShadow(
                                                      offset: const Offset(
                                                          1.0, 1.0),
                                                      spreadRadius: 1,
                                                      color:
                                                          Colors.grey.shade300,
                                                      blurRadius: 3)
                                                ]),
                                            child: Padding(
                                                padding: EdgeInsets.only(
                                                    left: screenWidth(context,
                                                        dividedBy: 25)),
                                                child: TextField(
                                                    controller: yourName,
                                                    focusNode: nameNode,
                                                    textInputAction:
                                                        TextInputAction.next,
                                                    maxLines: 17,
                                                    decoration: InputDecoration(
                                                        border:
                                                            InputBorder.none,
                                                        hintText:
                                                            "What’s on your mind...?",
                                                        hintStyle: const TextStyle(
                                                            color: ColorCodes
                                                                .greyText)))))
                                        //ContectAuthTextField(context, yourName, "Your Name", nameNode),
                                        ),
                                  ]))),
                              SizedBox(
                                  height: screenHeight(context, dividedBy: 15)),
                              Center(
                                  child: GestureDetector(
                                onTap: () {
                                  if (!contactGftrCubit.isButtonClicked) {
                                    if (yourName.text.isEmpty) {
                                      flutterToast(
                                          "Please enter What’s on your mind...?",
                                          false);
                                    } else {
                                      contactGftrCubit.contactGftrService(
                                          context, yourName.text);
                                    }
                                  }
                                },
                                child: Container(
                                    alignment: Alignment.center,
                                    height:
                                        screenHeight(context, dividedBy: 20),
                                    width: screenWidth(context, dividedBy: 2.4),
                                    decoration: BoxDecoration(
                                        color: ColorCodes.coral,
                                        borderRadius:
                                            BorderRadius.circular(100)),
                                    child: BlocBuilder<ContactGftrCubit,
                                            ContactGftrState>(
                                        builder: (context, state) {
                                      if (state is ContactGftrLoading) {
                                        return spinkitLoader(
                                            context, Colors.white);
                                      }
                                      return customText("Submit", Colors.white,
                                          16, FontWeight.w100, poppins);
                                    })),
                              )),
                            ],
                          ),
                        ),
                      )
                    ]))
              ]))),
    );
  }
}
