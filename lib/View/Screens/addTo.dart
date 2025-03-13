import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gftr/Helper/appConfig.dart';
import 'package:gftr/Helper/colorConstants.dart';
import 'package:gftr/Helper/imageConstants.dart';
import 'package:gftr/View/Screens/google.dart';
import 'package:gftr/View/Widgets/customLoader.dart';
import 'package:gftr/View/Widgets/customText.dart';
import 'package:gftr/View/Widgets/flutterToast.dart';
import 'package:gftr/ViewModel/Cubits/GetGifted/getgifted_cubit.dart';
import 'package:gftr/ViewModel/Cubits/GetGifted/getgiftedview_dart.dart';
import 'package:gftr/ViewModel/Cubits/addform_cubit.dart';
import 'package:gftr/ViewModel/prefsService.dart';

class AddTo extends StatefulWidget {
  String imageUrl;
  String title;
  String webViewLink;
  String sharedText;
  List imagesList;
  bool isBack;
  AddTo(
      {Key? key,
      required this.imagesList,
      required this.imageUrl,
      this.isBack = false,
      required this.webViewLink,
      required this.sharedText,
      required this.title})
      : super(key: key);

  @override
  State<AddTo> createState() => _AddToState();
}

class _AddToState extends State<AddTo> {
  bool dropDown1 = false;
  bool dropDown2 = false;
  bool isVig = false;
  bool Chang = false;
  String img = "";
  TextEditingController titleC = TextEditingController();
  TextEditingController priceC = TextEditingController();
  TextEditingController noteC = TextEditingController();
  GetGiftedViewCubit getGiftedViewCubit = GetGiftedViewCubit();
  SharedPrefsService prefsService = SharedPrefsService();
  AddToCubit addToCubit = AddToCubit();
  String? dropDownFolderId;
  String? userId;
  String dropDownFolderName = 'Select Folder';
  String userNetwork = 'Choose a Gftr';
  final ScrollController _secondController = ScrollController();
  final ScrollController _firstController = ScrollController();
  TextEditingController folderNameC = TextEditingController();
  GetGiftedCubit getGiftedCubit = GetGiftedCubit();
  bool isPublic = true;

  Future<void> Printe_data() async {
    img = widget.imageUrl;
    titleC.text = widget.title.toString();
    authorization = (await prefsService.getStringData("authToken"))!;
  }

  @override
  void initState() {
    super.initState();
    setState(() {
      widget.imageUrl;
      widget.imagesList;
    });
    Printe_data();
    getGiftedCubit = BlocProvider.of<GetGiftedCubit>(context);
    getGiftedViewCubit = BlocProvider.of<GetGiftedViewCubit>(context);
    addToCubit = BlocProvider.of<AddToCubit>(context);
    getGiftedViewCubit.getViewGift();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: InkWell(
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
                  Padding(
                    padding: EdgeInsets.only(
                        left: screenWidth(context, dividedBy: 30),
                        top: screenHeight(context, dividedBy: 20)),
                    child: GestureDetector(
                        onTap: () {
                          if (widget.isBack) {
                            Navigator.pop(context);
                          } else {
                            defauilUrl = widget.webViewLink;
                            Navigator.pushAndRemoveUntil(context,
                                MaterialPageRoute(
                              builder: (context) {
                                return GooglePage();
                              },
                            ), (route) => false);
                          }
                        },
                        child: Icon(
                          Icons.arrow_back_ios_outlined,
                          size: 20,
                          color: Colors.white,
                        )),
                  ),
                ],
              ),
              Container(
                height: screenHeight(context, dividedBy: 1.1),
                width: screenWidth(context),
                // padding: EdgeInsets.only(
                //     left: screenWidth(context, dividedBy: 15),
                //     right: screenWidth(context, dividedBy: 15)),
                margin:
                    EdgeInsets.only(top: screenHeight(context, dividedBy: 4.8)),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(60)),
                ),
                child: Padding(
                  padding: EdgeInsets.only(
                    left: screenWidth(context, dividedBy: 100),
                    right: screenWidth(context, dividedBy: 100),
                  ),
                  child: SizedBox(
                    height: screenHeight(context),
                    width: screenWidth(context),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: screenHeight(context, dividedBy: 30)),
                        Padding(
                          padding: EdgeInsets.only(
                            left: screenWidth(context, dividedBy: 15),
                          ),
                          child: customText("Add to:", Colors.black, 21,
                              FontWeight.w100, madeOuterSans),
                        ),
                        SizedBox(height: screenHeight(context, dividedBy: 100)),
                        Expanded(
                          child: SingleChildScrollView(
                            child: Column(
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(
                                      left: screenWidth(context, dividedBy: 13),
                                      right:
                                          screenWidth(context, dividedBy: 13)),
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      PopupMenuButton(
                                        offset: Offset(0, 45),
                                        elevation: 4,
                                        //color: Colors.green,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        child: Container(
                                          alignment: Alignment.center,
                                          height: screenHeight(context,
                                              dividedBy: 20),
                                          width: screenWidth(context,
                                              dividedBy: 1.5),
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            color: const Color(0xffFFFFFF),
                                            //color: Colors.green,
                                            boxShadow: const [
                                              BoxShadow(
                                                  offset: Offset(0.5, 1.0),
                                                  spreadRadius: 1,
                                                  color: Colors.black12,
                                                  blurRadius: 1),
                                            ],
                                          ),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Center(
                                                child: Padding(
                                                  padding: EdgeInsets.only(
                                                    left: screenWidth(context,
                                                        dividedBy: 45),
                                                  ),
                                                  child: Container(
                                                    alignment: Alignment.center,
                                                    width: screenWidth(context,
                                                        dividedBy: 3.6),
                                                    child: Text(
                                                        dropDownFolderName,
                                                        maxLines: 1,
                                                        style: const TextStyle(
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                            color:
                                                                Colors.black54,
                                                            fontSize: 14)),
                                                  ),
                                                ),
                                              ),
                                              Padding(
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: screenWidth(
                                                        context,
                                                        dividedBy: 95)),
                                                child: customText(
                                                    "OR",
                                                    ColorCodes.greyText,
                                                    10,
                                                    FontWeight.w100,
                                                    'Poppins'),
                                              ),
                                              Center(
                                                child: Padding(
                                                  padding: EdgeInsets.only(
                                                    right: screenWidth(context,
                                                        dividedBy: 45),
                                                  ),
                                                  child: Container(
                                                    alignment: Alignment.center,
                                                    width: screenWidth(context,
                                                        dividedBy: 3.6),
                                                    child: Text(userNetwork,
                                                        maxLines: 1,
                                                        style: const TextStyle(
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                            color:
                                                                Colors.black54,
                                                            fontSize: 14)),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        itemBuilder: (context) => [
                                          PopupMenuItem(
                                            //padding: EdgeInsets.only(top: 10),
                                            value: 1,
                                            // row with 2 children
                                            child: Container(
                                              // margin: EdgeInsets.only(top: 10),
                                              height: screenHeight(context,
                                                  dividedBy: 3),
                                              width: screenWidth(context,
                                                  dividedBy: 2),
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                //color: Colors.green,
                                                color: const Color(0xffFFFFFF),
                                                //color: Colors.white,
                                                // boxShadow: const [
                                                //   BoxShadow(
                                                //       offset: Offset(0.5, 1.0),
                                                //       spreadRadius: 1,
                                                //       color: Colors.black12,
                                                //       blurRadius: 1),
                                                // ],
                                              ),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Container(
                                                    height: screenHeight(
                                                        context,
                                                        dividedBy: 30),
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .start,
                                                      children: [
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .only(
                                                                  left: 10,
                                                                  right: 7),
                                                          child:
                                                              GestureDetector(
                                                            onTap: () {
                                                              Navigator.pop(
                                                                  context);
                                                              setState(() {
                                                                Chang = true;
                                                                dropDown1 =
                                                                    !dropDown1;
                                                              });
                                                              showDialog(
                                                                context:
                                                                    context,
                                                                builder:
                                                                    (context) {
                                                                  return SimpleDialog(
                                                                    shape: RoundedRectangleBorder(
                                                                        borderRadius:
                                                                            BorderRadius.circular(20)),
                                                                    children: [
                                                                      Padding(
                                                                        padding:
                                                                            const EdgeInsets.symmetric(horizontal: 20),
                                                                        child:
                                                                            TextField(
                                                                          textInputAction:
                                                                              TextInputAction.done,
                                                                          onSubmitted:
                                                                              (value) {
                                                                            if (folderNameC.text.isNotEmpty &&
                                                                                folderNameC.text != null) {
                                                                              getGiftedCubit.getAddFolder(context, folderName: folderNameC.text, isPublic: isPublic).then((value) {
                                                                                Navigator.pop(context);
                                                                                getGiftedViewCubit.getViewGift();
                                                                                folderNameC.clear();
                                                                              });
                                                                            } else {
                                                                              flutterToast('Enter Folder Name', false);
                                                                            }
                                                                          },
                                                                          cursorColor:
                                                                              Colors.black45,
                                                                          controller:
                                                                              folderNameC,
                                                                          decoration: InputDecoration(
                                                                              border: InputBorder.none,
                                                                              hintText: 'Folder name',
                                                                              hintStyle: TextStyle(fontFamily: poppins)),
                                                                        ),
                                                                      ),
                                                                      Container(
                                                                        width:
                                                                            200,
                                                                        height:
                                                                            1,
                                                                        decoration: const BoxDecoration(
                                                                            color:
                                                                                Colors.black12,
                                                                            boxShadow: [
                                                                              BoxShadow(color: Colors.black38, blurRadius: 5)
                                                                            ]),
                                                                      ),
                                                                      Row(
                                                                        mainAxisAlignment:
                                                                            MainAxisAlignment.spaceEvenly,
                                                                        children: [
                                                                          InkWell(
                                                                            onTap:
                                                                                () {
                                                                              setState(() {
                                                                                Chang = false;
                                                                              });
                                                                              Navigator.pop(context);
                                                                            },
                                                                            child:
                                                                                Container(
                                                                              margin: const EdgeInsets.only(top: 5),
                                                                              height: 20,
                                                                              width: 100,
                                                                              alignment: Alignment.center,
                                                                              child: Padding(padding: const EdgeInsets.only(left: 8.0), child: customText("Cancel", ColorCodes.greyText, 14, FontWeight.w400, poppins)),
                                                                            ),
                                                                          ),
                                                                          Container(
                                                                            width:
                                                                                1,
                                                                            height:
                                                                                30,
                                                                            decoration:
                                                                                const BoxDecoration(
                                                                              color: Colors.black12,
                                                                              // boxShadow: [
                                                                              //   BoxShadow(
                                                                              //       color: Colors.black38,
                                                                              //       blurRadius: 5)
                                                                              // ]
                                                                            ),
                                                                          ),
                                                                          InkWell(
                                                                            onTap:
                                                                                () {
                                                                              if (folderNameC.text.isNotEmpty && folderNameC.text != null) {
                                                                                getGiftedCubit.getAddFolder(context, folderName: folderNameC.text, isPublic: isPublic).then((value) {
                                                                                  setState(() {
                                                                                    getGiftedViewCubit.getViewGift();
                                                                                  });
                                                                                  Navigator.pop(context);
                                                                                  folderNameC.clear();
                                                                                });
                                                                              } else {
                                                                                flutterToast('Enter Folder Name', false);
                                                                              }
                                                                              Timer(Duration(milliseconds: 900), () {
                                                                                setState(() {
                                                                                  getGiftedViewCubit.getViewGift();
                                                                                  Chang = false;
                                                                                  dropDown1 = !dropDown1;
                                                                                });
                                                                              });
                                                                              // Chang = false;
                                                                              setState(() {});
                                                                            },
                                                                            child:
                                                                                Container(
                                                                              margin: const EdgeInsets.only(top: 5),
                                                                              height: 20,
                                                                              width: 100,
                                                                              alignment: Alignment.center,
                                                                              child: BlocBuilder<GetGiftedViewCubit, GetGiftedViewState>(builder: (context, state) {
                                                                                if (state is GetGiftedViewLoading) {
                                                                                  return spinkitLoader(context, ColorCodes.greyButton);
                                                                                }
                                                                                return Padding(padding: const EdgeInsets.only(left: 8.0), child: customText("Save", ColorCodes.greyText, 14, FontWeight.w400, poppins));
                                                                              }),
                                                                            ),
                                                                          )
                                                                        ],
                                                                      )
                                                                    ],
                                                                  );
                                                                },
                                                              );
                                                            },
                                                            child: Image.asset(
                                                                ImageConstants
                                                                    .addDate,
                                                                height:
                                                                    screenHeight(
                                                                        context,
                                                                        dividedBy:
                                                                            25),
                                                                width:
                                                                    screenWidth(
                                                                        context,
                                                                        dividedBy:
                                                                            25),
                                                                fit: BoxFit
                                                                    .contain),
                                                          ),
                                                        ),
                                                        customText(
                                                            "Add Folder",
                                                            ColorCodes.greyText,
                                                            15,
                                                            FontWeight.w100,
                                                            "Poppins"),
                                                      ],
                                                    ),
                                                  ),
                                                  Divider(
                                                    color: ColorCodes
                                                        .greyDetailBox,
                                                    thickness: 1,
                                                    height: 0,
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 8.0, top: 5),
                                                    child: customText(
                                                        "Wishlist",
                                                        ColorCodes.greyText,
                                                        15,
                                                        FontWeight.w100,
                                                        "Poppins"),
                                                  ),
                                                  Container(
                                                    height: screenHeight(
                                                        context,
                                                        dividedBy: 10),
                                                    width: screenWidth(context),
                                                    child: Chang == false
                                                        ? Scrollbar(
                                                            thickness: 8,
                                                            radius:
                                                                Radius.circular(
                                                                    16),
                                                            //--------------------------------CLOSED BY ME------------------------------------------------
                                                            // isAlwaysShown: true,
                                                            thumbVisibility: true,

                                                            //--------------------------------CLOSED BY ME------------------------------------------------
                                                            controller:
                                                                _secondController,
                                                            child: ListView
                                                                .builder(
                                                              controller:
                                                                  _secondController,
                                                              padding: EdgeInsets
                                                                  .only(
                                                                      bottom:
                                                                          30,
                                                                      left: 10),
                                                              itemCount:
                                                                  getGiftedViewCubit
                                                                      .viewGift
                                                                      ?.allData
                                                                      ?.length,
                                                              itemBuilder:
                                                                  (context,
                                                                      index) {
                                                                return GestureDetector(
                                                                  onTap: () {
                                                                    dropDownFolderId = getGiftedViewCubit
                                                                            .viewGift
                                                                            ?.allData?[index]
                                                                            .id ??
                                                                        '';

                                                                    dropDownFolderName = getGiftedViewCubit
                                                                            .viewGift
                                                                            ?.allData?[index]
                                                                            .folderName ??
                                                                        '';
                                                                    userId =
                                                                        null;
                                                                    userNetwork =
                                                                        'Choose a Gftr';
                                                                    Navigator.pop(
                                                                        context);
                                                                    setState(
                                                                        () {});
                                                                  },
                                                                  child:
                                                                      Container(
                                                                    margin: EdgeInsets.only(
                                                                        bottom:
                                                                            8),
                                                                    child: customText(
                                                                        getGiftedViewCubit.viewGift?.allData?[index].folderName ??
                                                                            '',
                                                                        Colors
                                                                            .black,
                                                                        15,
                                                                        FontWeight
                                                                            .w100,
                                                                        poppins),
                                                                  ),
                                                                );
                                                              },
                                                            ),
                                                          )
                                                        : customLoader(context),
                                                  ),
                                                  Divider(
                                                    color: ColorCodes
                                                        .greyDetailBox,
                                                    thickness: 1,
                                                    height: 0,
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 8.0, top: 5),
                                                    child: customText(
                                                        "Gftr Group",
                                                        ColorCodes.greyText,
                                                        15,
                                                        FontWeight.w100,
                                                        "Poppins"),
                                                  ),
                                                  SizedBox(
                                                    height: screenHeight(
                                                        context,
                                                        dividedBy: 10),
                                                    width: screenWidth(context),
                                                    child: Scrollbar(
                                                      thickness: 8,
                                                      radius:
                                                          Radius.circular(16),
                                                      //--------------------------------CLOSED BY ME------------------------------------------------
                                                      // isAlwaysShown: true,
                                                       thumbVisibility: true,
                                                      //--------------------------------CLOSED BY ME------------------------------------------------
                                                      controller:
                                                          _firstController,
                                                      child: ListView.builder(
                                                        controller:
                                                            _firstController,
                                                        padding:
                                                            EdgeInsets.only(
                                                                left: 10,
                                                                bottom: 20),
                                                        itemCount:
                                                            getGiftedViewCubit
                                                                .viewGift
                                                                ?.groupsData
                                                                ?.length,
                                                        itemBuilder:
                                                            (context, index) =>
                                                                GestureDetector(
                                                          onTap: () {
                                                            userId =
                                                                getGiftedViewCubit
                                                                    .viewGift
                                                                    ?.groupsData?[
                                                                        index]
                                                                    .id;

                                                            userNetwork =
                                                                getGiftedViewCubit
                                                                        .viewGift
                                                                        ?.groupsData?[
                                                                            index]
                                                                        .name ??
                                                                    '';
                                                            dropDownFolderName =
                                                                'Select Folder';
                                                            dropDownFolderId =
                                                                null;
                                                            Navigator.pop(
                                                                context);
                                                            setState(() {});
                                                          },
                                                          child: Container(
                                                            margin:
                                                                EdgeInsets.only(
                                                                    bottom: 10),
                                                            child: Text(
                                                              getGiftedViewCubit
                                                                      .viewGift
                                                                      ?.groupsData?[
                                                                          index]
                                                                      .name ??
                                                                  '',
                                                              style: TextStyle(
                                                                  overflow:
                                                                      TextOverflow
                                                                          .ellipsis,
                                                                  color: Colors
                                                                      .black,
                                                                  fontFamily:
                                                                      poppins,
                                                                  fontSize: 14,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w100),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          )
                                        ],
                                      ),

                                      // if (dropDown1)
                                      //
                                      //
                                      // else
                                      //   SizedBox(),

                                      // Column(
                                      //   mainAxisAlignment: MainAxisAlignment.start,
                                      //   crossAxisAlignment: CrossAxisAlignment.start,
                                      //   children: [
                                      //     Container(
                                      //       height: screenHeight(context,
                                      //           dividedBy: 25),
                                      //       width: screenWidth(context,
                                      //           dividedBy: 2.75),
                                      //       decoration: BoxDecoration(
                                      //         borderRadius:
                                      //             BorderRadius.circular(10),
                                      //         color: const Color(0xffFFFFFF),
                                      //         boxShadow: const [
                                      //           BoxShadow(
                                      //               offset: Offset(0.5, 1.0),
                                      //               spreadRadius: 1,
                                      //               color: Colors.black12,
                                      //               blurRadius: 1),
                                      //         ],
                                      //       ),
                                      //       child: Padding(
                                      //         padding: EdgeInsets.only(
                                      //           left: screenWidth(context,
                                      //               dividedBy: 60),
                                      //           right: screenWidth(context,
                                      //               dividedBy: 40),
                                      //         ),
                                      //         child: GestureDetector(
                                      //           onTap: () {
                                      //             dropDown1 = !dropDown1;
                                      //             setState(() {});
                                      //             // dropDown = !dropDown;
                                      //           },
                                      //           child: Center(
                                      //             child: Text(dropDownFolderName,
                                      //                 style: const TextStyle(
                                      //                     color: Colors.black54,
                                      //                     fontSize: 14)),
                                      //           ),
                                      //         ),
                                      //       ),
                                      //     ),
                                      //    if (dropDown1)
                                      //      Column(
                                      //        children: [
                                      //          SizedBox(
                                      //              height: screenHeight(context, dividedBy: 90)),
                                      //          Container(
                                      //            height: screenHeight(
                                      //                context,
                                      //                dividedBy: 4),
                                      //            width: screenWidth(context,
                                      //                dividedBy: 2.5),
                                      //            decoration: BoxDecoration(
                                      //              borderRadius:
                                      //              BorderRadius.circular(
                                      //                  10),
                                      //              //color: Colors.green,
                                      //              color: const Color(0xffFFFFFF),
                                      //              //  color: Colors.white,
                                      //              boxShadow: const [
                                      //                BoxShadow(
                                      //                    offset: Offset(
                                      //                        0.5, 1.0),
                                      //                    spreadRadius: 1,
                                      //                    color:
                                      //                    Colors.black12,
                                      //                    blurRadius: 1),
                                      //              ],
                                      //            ),
                                      //            child: Column(
                                      //              children: [
                                      //                Container(
                                      //                  height: screenHeight(context,dividedBy: 30),
                                      //                  child: Row(
                                      //                    mainAxisAlignment: MainAxisAlignment.start,
                                      //                    children: [
                                      //                      Padding(
                                      //                        padding: const EdgeInsets.only(left: 10,right: 7),
                                      //                        child: GestureDetector(
                                      //                          onTap: () {
                                      //                            setState(() {
                                      //                              Chang = true;
                                      //                              dropDown1 = !dropDown1;
                                      //                            });
                                      //                            showDialog(context: context, builder: (context) {
                                      //                              return SimpleDialog(
                                      //                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                                      //                                children: [
                                      //                                  Padding(
                                      //                                    padding: const EdgeInsets.symmetric(horizontal: 20),
                                      //                                    child: TextField(
                                      //                                      textInputAction: TextInputAction.done,
                                      //                                      onSubmitted: (value) {
                                      //                                        if (folderNameC.text.isNotEmpty && folderNameC.text != null) {
                                      //                                          getGiftedCubit
                                      //                                              .getAddFolder(context,
                                      //                                              folderName: folderNameC.text, isPublic: isPublic)
                                      //                                              .then((value) {
                                      //                                            Navigator.pop(context);
                                      //                                            getGiftedViewCubit.getViewGift();
                                      //                                            folderNameC.clear();
                                      //                                          });
                                      //                                        } else {
                                      //                                          flutterToast('Enter Folder Name', false);
                                      //                                        }
                                      //                                      },
                                      //                                      cursorColor: Colors.black45,
                                      //                                      controller: folderNameC,
                                      //                                      decoration: InputDecoration(
                                      //                                          border: InputBorder.none,
                                      //                                          hintText: 'Folder name',
                                      //                                          hintStyle: TextStyle(fontFamily: poppins)),
                                      //                                    ),
                                      //                                  ),
                                      //                                  Container(
                                      //                                    width: 200,
                                      //                                    height: 1,
                                      //                                    decoration: const BoxDecoration(
                                      //                                        color: Colors.black12,
                                      //                                        boxShadow: [BoxShadow(color: Colors.black38, blurRadius: 5)]),
                                      //                                  ),
                                      //                                  Row(
                                      //                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                      //                                    children: [
                                      //                                      InkWell(
                                      //                                        onTap: () {
                                      //                                          setState(() {
                                      //                                            Chang = false;
                                      //                                          });
                                      //                                          Navigator.pop(context);
                                      //                                        },
                                      //                                        child: Container(
                                      //                                          margin: const EdgeInsets.only(top: 5),
                                      //                                          height: 20,
                                      //                                          width: 100,
                                      //                                          alignment: Alignment.center,
                                      //                                          child: Padding(
                                      //                                              padding: const EdgeInsets.only(left: 8.0),
                                      //                                              child: customText("Cancel", ColorCodes.greyText, 14,
                                      //                                                  FontWeight.w400, poppins)),
                                      //                                        ),
                                      //                                      ),
                                      //                                      Container(
                                      //                                        width: 1,
                                      //                                        height: 30,
                                      //                                        decoration: const BoxDecoration(
                                      //                                            color: Colors.black12,
                                      //                                            boxShadow: [BoxShadow(color: Colors.black38, blurRadius: 5)]),
                                      //                                      ),
                                      //                                      InkWell(
                                      //                                        onTap: () {
                                      //                                          if (folderNameC.text.isNotEmpty && folderNameC.text != null) {
                                      //                                            getGiftedCubit
                                      //                                                .getAddFolder(context,
                                      //                                                folderName: folderNameC.text, isPublic: isPublic)
                                      //                                                .then((value) {
                                      //                                              setState(() {
                                      //                                                getGiftedViewCubit.getViewGift();
                                      //                                              });
                                      //                                              Navigator.pop(context);
                                      //                                              folderNameC.clear();
                                      //                                            });
                                      //                                          } else {
                                      //                                            flutterToast('Enter Folder Name', false);
                                      //                                          }
                                      //                                          Timer(Duration(milliseconds: 900), () {
                                      //                                            setState(() {
                                      //                                              getGiftedViewCubit.getViewGift();
                                      //                                              Chang = false;
                                      //                                              dropDown1 = !dropDown1;
                                      //                                            });
                                      //                                          });
                                      //                                          // Chang = false;
                                      //                                          setState(() {});
                                      //
                                      //                                        },
                                      //                                        child: Container(
                                      //                                          margin: const EdgeInsets.only(top: 5),
                                      //                                          height: 20,
                                      //                                          width: 100,
                                      //                                          alignment: Alignment.center,
                                      //                                          child: BlocBuilder<GetGiftedViewCubit, GetGiftedViewState>(
                                      //                                              builder: (context, state) {
                                      //                                                if (state is GetGiftedViewLoading) {
                                      //                                                  return spinkitLoader(context, ColorCodes.greyButton);
                                      //                                                }
                                      //                                                return Padding(
                                      //                                                    padding: const EdgeInsets.only(left: 8.0),
                                      //                                                    child: customText("Save", ColorCodes.greyText, 14,
                                      //                                                        FontWeight.w400, poppins));
                                      //                                              }),
                                      //                                        ),
                                      //                                      )
                                      //                                    ],
                                      //                                  )
                                      //                                ],
                                      //                              );
                                      //                            },);
                                      //                          },
                                      //                          child: Image.asset(ImageConstants.addDate,
                                      //                              height: screenHeight(context, dividedBy: 30),
                                      //                              width: screenWidth(context, dividedBy: 30),
                                      //                              fit: BoxFit.contain),
                                      //                        ),
                                      //                      ),
                                      //                      customText("Add Folder", ColorCodes.greyText, 15, FontWeight.w100, "Poppins"),
                                      //                    ],
                                      //                  ),
                                      //                ),
                                      //                customText("Wishlist", ColorCodes.greyText, 15, FontWeight.w100, "Poppins"),
                                      //                Container(
                                      //                  height: screenHeight(
                                      //                      context,
                                      //                      dividedBy: 15),
                                      //                  width: screenWidth(context,
                                      //                      dividedBy: 2.75),
                                      //                   color: Colors.green,
                                      //                  child: Chang == false ?
                                      //                  Scrollbar(
                                      //                    thickness: 8,
                                      //                    radius: Radius.circular(16),
                                      //                    isAlwaysShown: true,
                                      //                    controller: _secondController,
                                      //                    child: ListView.builder(
                                      //                      controller: _secondController,
                                      //                      padding: EdgeInsets.only(bottom: 10,left: 10),
                                      //                      itemCount:
                                      //                      getGiftedViewCubit
                                      //                          .viewGift
                                      //                          ?.allData
                                      //                          ?.length,
                                      //                      itemBuilder: (context, index) {
                                      //                        return   GestureDetector(
                                      //                          onTap: () {
                                      //                            dropDownFolderId =
                                      //                                getGiftedViewCubit
                                      //                                    .viewGift
                                      //                                    ?.allData?[
                                      //                                index]
                                      //                                    .id ??
                                      //                                    '';
                                      //
                                      //                            dropDownFolderName =
                                      //                                getGiftedViewCubit
                                      //                                    .viewGift
                                      //                                    ?.allData?[
                                      //                                index]
                                      //                                    .folderName ??
                                      //                                    '';
                                      //                            dropDown1 = false;
                                      //                            setState(() {});
                                      //                          },
                                      //                          child: customText(
                                      //                              getGiftedViewCubit
                                      //                                  .viewGift
                                      //                                  ?.allData?[
                                      //                              index]
                                      //                                  .folderName ??
                                      //                                  '',
                                      //                              Colors.black,
                                      //                              14,
                                      //                              FontWeight.w100,
                                      //                              poppins),
                                      //                        );
                                      //                      },
                                      //
                                      //                    ),
                                      //                  ) : customLoader(context),
                                      //                ),
                                      //                customText("Gftr Groups", ColorCodes.greyText, 15, FontWeight.w100, "Poppins"),
                                      //                Container(
                                      //                  height: screenHeight(
                                      //                      context,
                                      //                      dividedBy: 15),
                                      //                  width: screenWidth(context,
                                      //                      dividedBy: 2.75),
                                      //                  color: Colors.green,
                                      //                  child: Chang == false ?
                                      //                  Scrollbar(
                                      //                    thickness: 8,
                                      //                    radius: Radius.circular(16),
                                      //                    isAlwaysShown: true,
                                      //                    controller: _secondController,
                                      //                    child: ListView.builder(
                                      //                      controller: _secondController,
                                      //                      padding: EdgeInsets.only(bottom: 10,left: 10),
                                      //                      itemCount:
                                      //                      getGiftedViewCubit
                                      //                          .viewGift
                                      //                          ?.allData
                                      //                          ?.length,
                                      //                      itemBuilder: (context, index) {
                                      //                        return   GestureDetector(
                                      //                          onTap: () {
                                      //                            dropDownFolderId =
                                      //                                getGiftedViewCubit
                                      //                                    .viewGift
                                      //                                    ?.allData?[
                                      //                                index]
                                      //                                    .id ??
                                      //                                    '';
                                      //
                                      //                            dropDownFolderName =
                                      //                                getGiftedViewCubit
                                      //                                    .viewGift
                                      //                                    ?.allData?[
                                      //                                index]
                                      //                                    .folderName ??
                                      //                                    '';
                                      //                            dropDown1 = false;
                                      //                            setState(() {});
                                      //                          },
                                      //                          child: customText(
                                      //                              getGiftedViewCubit
                                      //                                  .viewGift
                                      //                                  ?.allData?[
                                      //                              index]
                                      //                                  .folderName ??
                                      //                                  '',
                                      //                              Colors.black,
                                      //                              14,
                                      //                              FontWeight.w100,
                                      //                              poppins),
                                      //                        );
                                      //                      },
                                      //
                                      //                    ),
                                      //                  ) : customLoader(context),
                                      //                ),
                                      //              ],
                                      //            ),
                                      //          ),
                                      //        ],
                                      //      )
                                      //      else if(dropDown2 == true)
                                      //      SizedBox(
                                      //      height: screenHeight(context,dividedBy: 9))
                                      //     else
                                      //      SizedBox()
                                      //
                                      //   ],
                                      // ),
                                      // Padding(
                                      //   padding: EdgeInsets.symmetric(
                                      //       horizontal: screenWidth(context,
                                      //           dividedBy: 50)),
                                      //   child: customText(
                                      //     "Or",
                                      //     Colors.black,
                                      //     14,
                                      //     FontWeight.w100,
                                      //     poppins,
                                      //   ),
                                      // ),
                                      // // (dropDown1 == true || dropDown2 == true ) ?SizedBox(
                                      // //     height: screenHeight(
                                      // //         context,
                                      // //         dividedBy: 9)) :SizedBox(),
                                      // Column(
                                      //   children: [
                                      //     Container(
                                      //       height: screenHeight(context,
                                      //           dividedBy: 25),
                                      //       width: screenWidth(context,
                                      //           dividedBy: 2.60),
                                      //       decoration: BoxDecoration(
                                      //         borderRadius:
                                      //             BorderRadius.circular(10),
                                      //         color: const Color(0xffFFFFFF),
                                      //         boxShadow: const [
                                      //           BoxShadow(
                                      //               offset: Offset(0.5, 1.0),
                                      //               spreadRadius: 1,
                                      //               color: Colors.black12,
                                      //               blurRadius: 1),
                                      //         ],
                                      //       ),
                                      //       child: Padding(
                                      //         padding: EdgeInsets.only(
                                      //           left: screenWidth(context,
                                      //               dividedBy: 60),
                                      //           right: screenWidth(context,
                                      //               dividedBy: 40),
                                      //         ),
                                      //         child: Container(
                                      //           width: screenWidth(context,dividedBy: 3),
                                      //           child: GestureDetector(
                                      //             onTap: () {
                                      //               dropDown1 = !dropDown1;
                                      //               setState(() {});
                                      //             },
                                      //             child: Center(
                                      //               child: Text(userNetwork,
                                      //                   style: TextStyle(
                                      //                     overflow: TextOverflow.ellipsis,
                                      //                     fontSize: 15,
                                      //                     color: Colors.black54,
                                      //                   )),
                                      //             ),
                                      //           ),
                                      //         ),
                                      //       ),
                                      //     ),
                                      //     if(dropDown1)
                                      //       Column(
                                      //         children: [
                                      //           SizedBox(
                                      //               height: screenHeight(context, dividedBy: 90)),
                                      //           Container(
                                      //             height: screenHeight(
                                      //                 context,
                                      //                 dividedBy: 4),
                                      //             width: screenWidth(context,
                                      //                 dividedBy: 2.5),
                                      //             decoration: BoxDecoration(
                                      //               borderRadius:
                                      //               BorderRadius.circular(
                                      //                   10),
                                      //               //color: Colors.green,
                                      //               color: const Color(0xffFFFFFF),
                                      //               //  color: Colors.white,
                                      //               boxShadow: const [
                                      //                 BoxShadow(
                                      //                     offset: Offset(
                                      //                         0.5, 1.0),
                                      //                     spreadRadius: 1,
                                      //                     color:
                                      //                     Colors.black12,
                                      //                     blurRadius: 1),
                                      //               ],
                                      //             ),
                                      //             child: Column(
                                      //               children: [
                                      //                 Container(
                                      //                   height: screenHeight(context,dividedBy: 30),
                                      //                   child: Row(
                                      //                     mainAxisAlignment: MainAxisAlignment.start,
                                      //                     children: [
                                      //                       Padding(
                                      //                         padding: const EdgeInsets.only(left: 10,right: 7),
                                      //                         child: GestureDetector(
                                      //                           onTap: () {
                                      //                             setState(() {
                                      //                               Chang = true;
                                      //                               dropDown1 = !dropDown1;
                                      //                             });
                                      //                             showDialog(context: context, builder: (context) {
                                      //                               return SimpleDialog(
                                      //                                 shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                                      //                                 children: [
                                      //                                   Padding(
                                      //                                     padding: const EdgeInsets.symmetric(horizontal: 20),
                                      //                                     child: TextField(
                                      //                                       textInputAction: TextInputAction.done,
                                      //                                       onSubmitted: (value) {
                                      //                                         if (folderNameC.text.isNotEmpty && folderNameC.text != null) {
                                      //                                           getGiftedCubit
                                      //                                               .getAddFolder(context,
                                      //                                               folderName: folderNameC.text, isPublic: isPublic)
                                      //                                               .then((value) {
                                      //                                             Navigator.pop(context);
                                      //                                             getGiftedViewCubit.getViewGift();
                                      //                                             folderNameC.clear();
                                      //                                           });
                                      //                                         } else {
                                      //                                           flutterToast('Enter Folder Name', false);
                                      //                                         }
                                      //                                       },
                                      //                                       cursorColor: Colors.black45,
                                      //                                       controller: folderNameC,
                                      //                                       decoration: InputDecoration(
                                      //                                           border: InputBorder.none,
                                      //                                           hintText: 'Folder name',
                                      //                                           hintStyle: TextStyle(fontFamily: poppins)),
                                      //                                     ),
                                      //                                   ),
                                      //                                   Container(
                                      //                                     width: 200,
                                      //                                     height: 1,
                                      //                                     decoration: const BoxDecoration(
                                      //                                         color: Colors.black12,
                                      //                                         boxShadow: [BoxShadow(color: Colors.black38, blurRadius: 5)]),
                                      //                                   ),
                                      //                                   Row(
                                      //                                     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                      //                                     children: [
                                      //                                       InkWell(
                                      //                                         onTap: () {
                                      //                                           setState(() {
                                      //                                             Chang = false;
                                      //                                           });
                                      //                                           Navigator.pop(context);
                                      //                                         },
                                      //                                         child: Container(
                                      //                                           margin: const EdgeInsets.only(top: 5),
                                      //                                           height: 20,
                                      //                                           width: 100,
                                      //                                           alignment: Alignment.center,
                                      //                                           child: Padding(
                                      //                                               padding: const EdgeInsets.only(left: 8.0),
                                      //                                               child: customText("Cancel", ColorCodes.greyText, 14,
                                      //                                                   FontWeight.w400, poppins)),
                                      //                                         ),
                                      //                                       ),
                                      //                                       Container(
                                      //                                         width: 1,
                                      //                                         height: 30,
                                      //                                         decoration: const BoxDecoration(
                                      //                                             color: Colors.black12,
                                      //                                             boxShadow: [BoxShadow(color: Colors.black38, blurRadius: 5)]),
                                      //                                       ),
                                      //                                       InkWell(
                                      //                                         onTap: () {
                                      //                                           if (folderNameC.text.isNotEmpty && folderNameC.text != null) {
                                      //                                             getGiftedCubit
                                      //                                                 .getAddFolder(context,
                                      //                                                 folderName: folderNameC.text, isPublic: isPublic)
                                      //                                                 .then((value) {
                                      //                                               setState(() {
                                      //                                                 getGiftedViewCubit.getViewGift();
                                      //                                               });
                                      //                                               Navigator.pop(context);
                                      //                                               folderNameC.clear();
                                      //                                             });
                                      //                                           } else {
                                      //                                             flutterToast('Enter Folder Name', false);
                                      //                                           }
                                      //                                           Timer(Duration(milliseconds: 900), () {
                                      //                                             setState(() {
                                      //                                               getGiftedViewCubit.getViewGift();
                                      //                                               Chang = false;
                                      //                                               dropDown1 = !dropDown1;
                                      //                                             });
                                      //                                           });
                                      //                                           // Chang = false;
                                      //                                           setState(() {});
                                      //
                                      //                                         },
                                      //                                         child: Container(
                                      //                                           margin: const EdgeInsets.only(top: 5),
                                      //                                           height: 20,
                                      //                                           width: 100,
                                      //                                           alignment: Alignment.center,
                                      //                                           child: BlocBuilder<GetGiftedViewCubit, GetGiftedViewState>(
                                      //                                               builder: (context, state) {
                                      //                                                 if (state is GetGiftedViewLoading) {
                                      //                                                   return spinkitLoader(context, ColorCodes.greyButton);
                                      //                                                 }
                                      //                                                 return Padding(
                                      //                                                     padding: const EdgeInsets.only(left: 8.0),
                                      //                                                     child: customText("Save", ColorCodes.greyText, 14,
                                      //                                                         FontWeight.w400, poppins));
                                      //                                               }),
                                      //                                         ),
                                      //                                       )
                                      //                                     ],
                                      //                                   )
                                      //                                 ],
                                      //                               );
                                      //                             },);
                                      //                           },
                                      //                           child: Image.asset(ImageConstants.addDate,
                                      //                               height: screenHeight(context, dividedBy: 30),
                                      //                               width: screenWidth(context, dividedBy: 30),
                                      //                               fit: BoxFit.contain),
                                      //                         ),
                                      //                       ),
                                      //                       customText("Add Folder", ColorCodes.greyText, 15, FontWeight.w100, "Poppins"),
                                      //                     ],
                                      //                   ),
                                      //                 ),
                                      //                 customText("Wishlist", ColorCodes.greyText, 15, FontWeight.w100, "Poppins"),
                                      //                 Container(
                                      //                   height: screenHeight(
                                      //                       context,
                                      //                       dividedBy: 15),
                                      //                   width: screenWidth(context,
                                      //                       dividedBy: 2.75),
                                      //                   color: Colors.green,
                                      //                   child: Chang == false ?
                                      //                   Scrollbar(
                                      //                     thickness: 8,
                                      //                     radius: Radius.circular(16),
                                      //                     isAlwaysShown: true,
                                      //                     controller: _secondController,
                                      //                     child: ListView.builder(
                                      //                       controller: _secondController,
                                      //                       padding: EdgeInsets.only(bottom: 10,left: 10),
                                      //                       itemCount:
                                      //                       getGiftedViewCubit
                                      //                           .viewGift
                                      //                           ?.allData
                                      //                           ?.length,
                                      //                       itemBuilder: (context, index) {
                                      //                         return   GestureDetector(
                                      //                           onTap: () {
                                      //                             dropDownFolderId =
                                      //                                 getGiftedViewCubit
                                      //                                     .viewGift
                                      //                                     ?.allData?[
                                      //                                 index]
                                      //                                     .id ??
                                      //                                     '';
                                      //
                                      //                             dropDownFolderName =
                                      //                                 getGiftedViewCubit
                                      //                                     .viewGift
                                      //                                     ?.allData?[
                                      //                                 index]
                                      //                                     .folderName ??
                                      //                                     '';
                                      //                             dropDown1 = false;
                                      //                             setState(() {});
                                      //                           },
                                      //                           child: customText(
                                      //                               getGiftedViewCubit
                                      //                                   .viewGift
                                      //                                   ?.allData?[
                                      //                               index]
                                      //                                   .folderName ??
                                      //                                   '',
                                      //                               Colors.black,
                                      //                               14,
                                      //                               FontWeight.w100,
                                      //                               poppins),
                                      //                         );
                                      //                       },
                                      //
                                      //                     ),
                                      //                   ) : customLoader(context),
                                      //                 ),
                                      //                 customText("Gftr Groups", ColorCodes.greyText, 15, FontWeight.w100, "Poppins"),
                                      //                 Container(
                                      //                   height: screenHeight(
                                      //                       context,
                                      //                       dividedBy: 15),
                                      //                   width: screenWidth(context,
                                      //                       dividedBy: 2.75),
                                      //                   color: Colors.green,
                                      //                   child: Chang == false ?
                                      //                   Scrollbar(
                                      //                     thickness: 8,
                                      //                     radius: Radius.circular(16),
                                      //                     isAlwaysShown: true,
                                      //                     controller: _secondController,
                                      //                     child: ListView.builder(
                                      //                       controller: _secondController,
                                      //                       padding: EdgeInsets.only(bottom: 10,left: 10),
                                      //                       itemCount:
                                      //                       getGiftedViewCubit
                                      //                           .viewGift
                                      //                           ?.allData
                                      //                           ?.length,
                                      //                       itemBuilder: (context, index) {
                                      //                         return   GestureDetector(
                                      //                           onTap: () {
                                      //                             dropDownFolderId =
                                      //                                 getGiftedViewCubit
                                      //                                     .viewGift
                                      //                                     ?.allData?[
                                      //                                 index]
                                      //                                     .id ??
                                      //                                     '';
                                      //
                                      //                             dropDownFolderName =
                                      //                                 getGiftedViewCubit
                                      //                                     .viewGift
                                      //                                     ?.allData?[
                                      //                                 index]
                                      //                                     .folderName ??
                                      //                                     '';
                                      //                             dropDown1 = false;
                                      //                             setState(() {});
                                      //                           },
                                      //                           child: customText(
                                      //                               getGiftedViewCubit
                                      //                                   .viewGift
                                      //                                   ?.allData?[
                                      //                               index]
                                      //                                   .folderName ??
                                      //                                   '',
                                      //                               Colors.black,
                                      //                               14,
                                      //                               FontWeight.w100,
                                      //                               poppins),
                                      //                         );
                                      //                       },
                                      //
                                      //                     ),
                                      //                   ) : customLoader(context),
                                      //                 ),
                                      //               ],
                                      //             ),
                                      //           ),
                                      //         ],
                                      //       )
                                      //          Column(
                                      //             children: [
                                      //               SizedBox(
                                      //                   height: screenHeight(
                                      //                       context,
                                      //                       dividedBy: 90)),
                                      //               Container(
                                      //                 height: screenHeight(
                                      //                     context,
                                      //                     dividedBy: 10),
                                      //                 width: screenWidth(context,
                                      //                     dividedBy: 2.75),
                                      //                 decoration: BoxDecoration(
                                      //                   borderRadius:
                                      //                       BorderRadius.circular(
                                      //                           10),
                                      //                   color: const Color(
                                      //                       0xffFFFFFF),
                                      //                   boxShadow: const [
                                      //                     BoxShadow(
                                      //                         offset: Offset(
                                      //                             0.5, 1.0),
                                      //                         spreadRadius: 1,
                                      //                         color:
                                      //                             Colors.black12,
                                      //                         blurRadius: 1),
                                      //                   ],
                                      //                 ),
                                      //                 child: Scrollbar(
                                      //                   thickness: 8,
                                      //                   radius: Radius.circular(16),
                                      //                   isAlwaysShown: true,
                                      //                   controller: _firstController,
                                      //                   child: ListView.builder(
                                      //                     controller: _firstController,
                                      //                     padding:
                                      //                         EdgeInsets.all(10),
                                      //                     itemCount:
                                      //                         getGiftedViewCubit
                                      //                             .viewGift
                                      //                             ?.groupsData
                                      //                             ?.length,
                                      //                     itemBuilder:
                                      //                         (context, index) =>
                                      //                             GestureDetector(
                                      //                       onTap: () {
                                      //                         userId =
                                      //                             getGiftedViewCubit
                                      //                                     .viewGift
                                      //                                     ?.groupsData?[
                                      //                                         index]
                                      //                                     .id;
                                      //
                                      //                         userNetwork =
                                      //                             getGiftedViewCubit
                                      //                                     .viewGift
                                      //                                     ?.groupsData?[
                                      //                                         index]
                                      //                                     .name ??
                                      //                                 '';
                                      //                         dropDown2 = false;
                                      //                         setState(() {});
                                      //                       },
                                      //                       child: Container(
                                      //                         child: Text(
                                      //                             getGiftedViewCubit
                                      //                                     .viewGift
                                      //                                     ?.groupsData?[
                                      //                                         index]
                                      //                                     .name ??
                                      //                                 '',style: TextStyle(
                                      //
                                      //                           overflow: TextOverflow.ellipsis,
                                      //                             color: Colors.black,
                                      //                             fontFamily: poppins,
                                      //                           fontSize: 14,
                                      //                           fontWeight: FontWeight.w100
                                      //                         ),
                                      //                            ),
                                      //                       ),
                                      //                     ),
                                      //                   ),
                                      //                 ),
                                      //               ),
                                      //             ],
                                      //           )
                                      //     else
                                      //          const SizedBox(),
                                      //   ],
                                      // ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                    height:
                                        screenHeight(context, dividedBy: 50)),
                                Padding(
                                  padding: EdgeInsets.only(
                                      right: screenWidth(context,
                                          dividedBy: 1.32)),
                                  child: Text("Title",
                                      style: TextStyle(
                                          fontSize: 14,
                                          fontFamily: poppins,
                                          color: ColorCodes.greyText)),
                                ),
                                Container(
                                  // height: screenHeight(context, dividedBy: 20),
                                  // width: screenWidth(context, dividedBy: 1.1),
                                  margin: EdgeInsets.symmetric(
                                      horizontal:
                                          screenWidth(context, dividedBy: 15)),
                                  padding: EdgeInsets.symmetric(
                                      horizontal:
                                          screenWidth(context, dividedBy: 30)),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: const Color(0xffFFFFFF),
                                      boxShadow: const [
                                        BoxShadow(
                                            offset: Offset(0.5, 1.0),
                                            spreadRadius: 1,
                                            color: Colors.black12,
                                            blurRadius: 1),
                                      ]),
                                  child: getCustomTextFild(
                                      hintText: 'Enter your Title',
                                      controller: titleC),
                                ),
                                SizedBox(
                                    height:
                                        screenHeight(context, dividedBy: 50)),
                                Padding(
                                  padding: EdgeInsets.only(
                                      left: screenWidth(context, dividedBy: 15),
                                      right:
                                          screenWidth(context, dividedBy: 15)),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(
                                        height: screenHeight(context,
                                            dividedBy: 4.7),
                                        width: screenWidth(context,
                                            dividedBy: 2.1),
                                        padding: const EdgeInsets.all(8.0),
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          color: const Color(0xffFFFFFF),
                                          boxShadow: const [
                                            BoxShadow(
                                                // offset: Offset(0.5, 1.0),
                                                spreadRadius: 1,
                                                color: Colors.black12,
                                                blurRadius: 1),
                                          ],
                                        ),
                                        child: Stack(
                                          children: [
                                            ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              child: CachedNetworkImage(
                                                imageUrl: img,
                                                placeholder: (context, url) =>
                                                    spinkitLoader(context,
                                                        ColorCodes.coral),
                                                imageBuilder:
                                                    (context, imageProvider) {
                                                  return Container(
                                                    height: screenHeight(
                                                        context,
                                                        dividedBy: 5.3),
                                                    width: screenWidth(context,
                                                        dividedBy: 2.3),
                                                    decoration: BoxDecoration(
                                                        image: DecorationImage(
                                                            image:
                                                                imageProvider,
                                                            fit: BoxFit.fill)),
                                                  );
                                                },
                                                errorWidget:
                                                    (context, url, error) =>
                                                        Center(
                                                            child: Image(
                                                  image: AssetImage(
                                                      "assets/images/NoImages.png"),
                                                  fit: BoxFit.fill,
                                                )),
                                              ),
                                            ),
                                            Positioned(
                                              left: 20.0,
                                              bottom: 7.0,
                                              child: InkWell(
                                                onTap: () {
                                                  showModalBottomSheet(
                                                    context: context,
                                                    builder: (context) {
                                                      return SizedBox(
                                                        height: screenHeight(
                                                            context,
                                                            dividedBy: 1.9),
                                                        child: Center(
                                                          child: Column(
                                                            children: [
                                                              SizedBox(
                                                                height:
                                                                    screenHeight(
                                                                        context,
                                                                        dividedBy:
                                                                            15),
                                                                child: Row(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .center,
                                                                  children: [
                                                                    Padding(
                                                                      padding: const EdgeInsets
                                                                              .only(
                                                                          left:
                                                                              15),
                                                                      child:
                                                                          Container(
                                                                        alignment:
                                                                            Alignment.centerLeft,
                                                                        height: screenHeight(
                                                                            context,
                                                                            dividedBy:
                                                                                17),
                                                                        width: screenWidth(
                                                                            context,
                                                                            dividedBy:
                                                                                2),
                                                                        child:
                                                                            Text(
                                                                          "Select Images",
                                                                          style:
                                                                              TextStyle(fontSize: 20),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                    Spacer(),
                                                                    IconButton(
                                                                        onPressed:
                                                                            () {
                                                                          Navigator.pop(
                                                                              context);
                                                                        },
                                                                        icon: Icon(
                                                                            Icons.close))
                                                                  ],
                                                                ),
                                                              ),
                                                              Divider(
                                                                height: 1,
                                                                color: Colors
                                                                    .black38,
                                                              ),
                                                              SizedBox(
                                                                height:
                                                                    screenHeight(
                                                                        context,
                                                                        dividedBy:
                                                                            60),
                                                              ),
                                                              SizedBox(
                                                                height:
                                                                    screenHeight(
                                                                        context,
                                                                        dividedBy:
                                                                            2.3),
                                                                child: widget
                                                                        .imagesList
                                                                        .isEmpty
                                                                    ? Center(
                                                                        child: Text(
                                                                            "No images found"))
                                                                    : GridView
                                                                        .builder(
                                                                        itemCount: widget
                                                                            .imagesList
                                                                            .length,
                                                                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                                                            crossAxisCount:
                                                                                3,
                                                                            mainAxisSpacing:
                                                                                7,
                                                                            crossAxisSpacing:
                                                                                7),
                                                                        itemBuilder:
                                                                            (context,
                                                                                index) {
                                                                          return InkWell(
                                                                            onTap:
                                                                                () {
                                                                              print(widget.imagesList[index]);
                                                                              setState(() {
                                                                                img = widget.imagesList[index];
                                                                                Navigator.pop(context);
                                                                              });
                                                                            },
                                                                            child: Container(
                                                                                height: screenHeight(context, dividedBy: 7.5),
                                                                                width: screenWidth(context, dividedBy: 3.7),
                                                                                decoration: BoxDecoration(border: Border.all(width: 0.8, color: ColorCodes.greyButton), borderRadius: BorderRadius.circular(7)),
                                                                                child: CachedNetworkImage(
                                                                                  // imageUrl: rootBundle.loadString(widget.imagesList[index]),
                                                                                  imageUrl: widget.imagesList[index],
                                                                                  placeholder: (context, url) => spinkitLoader(context, ColorCodes.coral),
                                                                                  imageBuilder: (context, imageProvider) {
                                                                                    return Container(
                                                                                      height: screenHeight(context, dividedBy: 5.3),
                                                                                      width: screenWidth(context, dividedBy: 2.3),
                                                                                      decoration: BoxDecoration(image: DecorationImage(image: imageProvider)),
                                                                                    );
                                                                                  },
                                                                                  errorWidget: (context, url, error) => Image(
                                                                                    image: AssetImage("assets/images/gift.png"),
                                                                                  ),
                                                                                )
                                                                                // decoration: BoxDecoration(
                                                                                //     image: DecorationImage(image: NetworkImage(widget.imagesList[index]))
                                                                                // ),
                                                                                ),
                                                                          );
                                                                        },
                                                                      ),
                                                              )
                                                            ],
                                                          ),
                                                        ),
                                                      );
                                                    },
                                                  );
                                                },
                                                child: Container(
                                                  alignment: Alignment.center,
                                                  height: screenHeight(context,
                                                      dividedBy: 25),
                                                  width: screenWidth(context,
                                                      dividedBy: 3),
                                                  decoration: BoxDecoration(
                                                    color: ColorCodes.coral,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                  ),
                                                  child: customText(
                                                      "Edit",
                                                      Colors.white,
                                                      13,
                                                      FontWeight.w500,
                                                      poppins),
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Padding(
                                            padding: EdgeInsets.only(
                                              left: screenWidth(context,
                                                  dividedBy: 50),
                                            ),
                                            child: Text(
                                              "Price",
                                              style: TextStyle(
                                                fontSize: 14,
                                                color: ColorCodes.greyText,
                                                fontFamily: poppins,
                                              ),
                                            ),
                                          ),
                                          Container(
                                              width: screenWidth(context,
                                                  dividedBy: 3),
                                              padding: EdgeInsets.only(
                                                  left: screenWidth(context,
                                                      dividedBy: 60)),
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                  color:
                                                      const Color(0xffFFFFFF),
                                                  boxShadow: const [
                                                    BoxShadow(
                                                        offset:
                                                            Offset(0.5, 1.0),
                                                        spreadRadius: 1,
                                                        color: Colors.black12,
                                                        blurRadius: 1),
                                                  ]),
                                              child: getCustomTextFild(
                                                  numberKeybord: true,
                                                  hintText: 'Various',
                                                  controller: priceC)),
                                          Padding(
                                            padding: EdgeInsets.only(
                                                left: screenWidth(context,
                                                    dividedBy: 50),
                                                top: screenHeight(context,
                                                    dividedBy: 90)),
                                            child: Row(
                                              children: [
                                                Text("VIG?",
                                                    style: TextStyle(
                                                        color: Colors.black,
                                                        fontSize: 13,
                                                        fontFamily: poppins)),
                                                Text("(Very Important Gift)",
                                                    style: TextStyle(
                                                        color:
                                                            ColorCodes.greyText,
                                                        fontSize: 9,
                                                        fontFamily: poppins)),
                                              ],
                                            ),
                                          ),
                                          GestureDetector(
                                              onTap: () {
                                                isVig = !isVig;
                                                setState(() {});
                                              },
                                              child: isVig == true
                                                  ? Icon(
                                                      Icons.star,
                                                      color: ColorCodes.coral,
                                                    )
                                                  : Icon(
                                                      Icons.star_border_sharp,
                                                      color: Colors.black54,
                                                    ))
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                    height:
                                        screenHeight(context, dividedBy: 60)),
                                Padding(
                                  padding: EdgeInsets.only(
                                      right: screenWidth(context,
                                          dividedBy: 1.56)),
                                  child: Text(
                                    "Size/color",
                                    style: TextStyle(
                                      color: ColorCodes.greyText,
                                      fontFamily: poppins,
                                      fontSize: 14,
                                    ),
                                  ),
                                ),
                                Container(
                                  // height: screenHeight(context, dividedBy: 20),
                                  // width: screenWidth(context, dividedBy: 1.1),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: const Color(0xffFFFFFF),
                                    boxShadow: const [
                                      BoxShadow(
                                          offset: Offset(0.5, 1.0),
                                          spreadRadius: 1,
                                          color: Colors.black12,
                                          blurRadius: 1),
                                    ],
                                  ),
                                  padding: EdgeInsets.symmetric(
                                      horizontal:
                                          screenWidth(context, dividedBy: 30)),
                                  margin: EdgeInsets.symmetric(
                                      horizontal:
                                          screenWidth(context, dividedBy: 15)),

                                  child: getCustomTextFild(
                                      hintText: 'Size/color of Products ',
                                      controller: noteC),
                                ),
                                SizedBox(
                                    height:
                                        screenHeight(context, dividedBy: 18)),
                                Center(
                                  child: GestureDetector(
                                    onTap: () {
                                      if (titleC.text.isEmpty) {
                                        titleC.text =
                                            widget.title.toString().length <= 12
                                                ? widget.title.toString()
                                                : widget.title
                                                    .toString()
                                                    .substring(0, 23);
                                      }
                                      addToCubit.getAddForm(context,
                                          title: titleC.text.isEmpty
                                              ? widget.title
                                              : titleC.text,
                                          price: priceC.text,
                                          notes: noteC.text,
                                          image: img,
                                          id: dropDownFolderId ?? '',
                                          starredGift: isVig,
                                          webViewLink: widget.webViewLink,
                                          userId: (userId == null)
                                              ? null
                                              : (userId));
                                      print(
                                          "Hello :${titleC == null ? widget.title : titleC.text}");
                                    },
                                    child: Container(
                                      alignment: Alignment.center,
                                      height:
                                          screenHeight(context, dividedBy: 18),
                                      width:
                                          screenWidth(context, dividedBy: 2.4),
                                      decoration: BoxDecoration(
                                        color: ColorCodes.coral,
                                        borderRadius:
                                            BorderRadius.circular(100),
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.grey,
                                            blurRadius: 5.0,
                                            // spreadRadius: 0.0,
                                            offset: Offset(
                                              1.0,
                                              2.0,
                                            ),
                                          )
                                        ],
                                      ),
                                      child:
                                          BlocBuilder<AddToCubit, AddToState>(
                                              builder: (context, state) {
                                        if (state is AddToStateLoading) {
                                          return spinkitLoader(
                                              context, Colors.white);
                                        }
                                        return customText(
                                            "Save",
                                            const Color(0xffFFFFFF),
                                            15,
                                            FontWeight.bold,
                                            poppins);
                                      }),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: screenHeight(context, dividedBy: 20),
                                )
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
