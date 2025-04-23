import 'dart:developer';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gftr/Helper/appConfig.dart';
import 'package:gftr/Helper/colorConstants.dart';
import 'package:gftr/Model/groups.dart';
import 'package:gftr/View/Widgets/customLoader.dart';
import 'package:gftr/View/Widgets/customText.dart';
import 'package:gftr/ViewModel/Cubits/All_Giftss.dart';
import 'package:share_plus/share_plus.dart';

import '../../Helper/imageConstants.dart';
import '../../ViewModel/Cubits/folderview_cubit.dart';
import 'google.dart';

class IdeaGrannyTrish extends StatefulWidget {
  String name;
  List<Myidea>? PublicData;

  IdeaGrannyTrish({Key? key, required this.name, required this.PublicData})
      : super(key: key);

  @override
  State<IdeaGrannyTrish> createState() => _IdeaGrannyTrishState();
}

class _IdeaGrannyTrishState extends State<IdeaGrannyTrish> {
  late FolderViewDeleteCubit folderViewDeleteCubit;

  @override
  void initState() {
    super.initState();
    folderViewDeleteCubit = BlocProvider.of<FolderViewDeleteCubit>(context);
  }

  // Add BlocListener for handling delete states
  @override
  Widget build(BuildContext context) {
    return BlocListener<FolderViewDeleteCubit, FolderViewDeleteState>(
      listener: (context, state) {
        if (state is FolderViewDeleteSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Item deleted successfully')));
        } else if (state is FolderViewDeleteError) {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text('Failed to delete item')));
        }
      },
      child: Scaffold(
        body: SizedBox(
            height: screenHeight(context),
            width: screenWidth(context),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              SizedBox(
                height: screenHeight(context, dividedBy: 50),
              ),
              Padding(
                padding:
                    EdgeInsets.only(left: screenWidth(context, dividedBy: 30)),
                child: GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Icon(Icons.arrow_back_ios_outlined, size: 20)),
              ),
              Container(
                height: screenHeight(context, dividedBy: 20),
                padding:
                    EdgeInsets.only(left: screenWidth(context, dividedBy: 25)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    customText("My ideas for ${widget.name}", Colors.black, 18,
                        FontWeight.w500, madeOuterSans),
                  ],
                ),
              ),
              SizedBox(
                height: screenHeight(context, dividedBy: 70),
              ),
              BlocBuilder<Fetch_All_GiftsCubit, Fetch_All_GiftsState>(
                builder: (context, state) {
                  log("NoGroupsCubit $state");
                  if (state is Fetch_All_GiftsLoading) {
                    return Center(
                      child: spinkitLoader(context, ColorCodes.coral),
                    );
                  } else if (state is Fetch_All_GiftsError) {
                    return Center(
                      child: customText("Not Data Found!", Colors.black, 15,
                          FontWeight.w500, poppins),
                    );
                  } else if (state is Fetch_All_GiftsSuccess) {
                    return Expanded(
                        child: ListView.builder(
                            itemCount: widget.PublicData?.length,
                            physics: BouncingScrollPhysics(),
                            padding: EdgeInsets.only(
                                left: screenWidth(context, dividedBy: 30),
                                right: screenWidth(context, dividedBy: 30),
                                bottom: screenWidth(context, dividedBy: 6)),
                            itemBuilder: (context, index) {
                              return Dismissible(
                                  key: UniqueKey(),
                                  direction: DismissDirection.endToStart,
                                  background: Container(
                                    padding: EdgeInsets.only(
                                        right: screenWidth(context,
                                            dividedBy: 10)),
                                    decoration: BoxDecoration(
                                      color: Colors.red.shade400,
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    alignment: Alignment.centerRight,
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        Icon(
                                          Icons.delete,
                                          color: Colors.white,
                                          size: 24,
                                        ),
                                        SizedBox(width: 8),
                                        customText("Delete", Colors.white, 16,
                                            FontWeight.w600, poppins),
                                        SizedBox(width: 20),
                                      ],
                                    ),
                                  ),
                                  confirmDismiss: (direction) {
                                    return showDialog(
                                      context: context,
                                      builder: (context) => AlertDialog(
                                        title: Text("Delete Confirmation"),
                                        content: Text(
                                            "Are you sure you want to delete this item?"),
                                        actions: [
                                          TextButton(
                                            onPressed: () =>
                                                Navigator.pop(context, false),
                                            child: Text("Cancel"),
                                          ),
                                          TextButton(
                                            onPressed: () =>
                                                Navigator.pop(context, true),
                                            child: Text(
                                              "Delete",
                                              style:
                                                  TextStyle(color: Colors.red),
                                            ),
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                  onDismissed: (direction) {
                                    // Add your delete functionality here
                                    folderViewDeleteCubit
                                        .folderViewDeleteGift(
                                      folderViewId:
                                          widget.PublicData?[index].id ?? '',
                                      giftfolderId:
                                          widget.PublicData?[index].id ?? '',
                                    )
                                        .then((value) {
                                      // Refresh the list after deletion
                                      setState(() {
                                        widget.PublicData?.removeAt(index);
                                      });
                                    });
                                  },
                                  child: GestureDetector(
                                      onTap: () {
                                        defauilUrl = widget.PublicData?[index]
                                                .webViewLink ??
                                            '';
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    GooglePage()));
                                        setState(() {});
                                      },
                                      child: Container(
                                        margin: EdgeInsets.only(
                                            bottom: screenWidth(context,
                                                dividedBy: 50)),
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                        child: Container(
                                            height: screenHeight(context,
                                                dividedBy: 8),
                                            width: screenWidth(context,
                                                dividedBy: 1.1),
                                            decoration: BoxDecoration(
                                                color: Colors.white,
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                boxShadow: [
                                                  BoxShadow(
                                                    color: Colors.grey.shade300,
                                                    offset:
                                                        const Offset(3.0, 3.0),
                                                    blurRadius: 1,
                                                  )
                                                ]),
                                            child: Row(
                                              children: [
                                                CachedNetworkImage(
                                                  height: 80,
                                                  width: 130,
                                                  imageUrl: widget
                                                          .PublicData?[index]
                                                          .image ??
                                                      '',
                                                  imageBuilder:
                                                      (context, imageProvider) {
                                                    return Container(
                                                      margin: EdgeInsets.only(
                                                          right: 10),
                                                      height: screenHeight(
                                                          context,
                                                          dividedBy: 8.05),
                                                      width: screenWidth(
                                                          context,
                                                          dividedBy: 3.5),
                                                      decoration: BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(10),
                                                          image: DecorationImage(
                                                              image:
                                                                  imageProvider,
                                                              fit:
                                                                  BoxFit.fill)),
                                                    );
                                                  },
                                                  placeholder: (context, url) =>
                                                      customLoader(context),
                                                  errorWidget:
                                                      (context, url, error) =>
                                                          Image(
                                                    image: AssetImage(
                                                        "assets/images/gift.png"),
                                                    fit: BoxFit.fill,
                                                  ),
                                                ),
                                                Expanded(
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .only(
                                                                top: 15.0),
                                                        child: Row(
                                                          children: [
                                                            SizedBox(
                                                              width:
                                                                  screenWidth(
                                                                      context,
                                                                      dividedBy:
                                                                          2),
                                                              child:
                                                                  AutoSizeText(
                                                                widget
                                                                        .PublicData?[
                                                                            index]
                                                                        .title ??
                                                                    '',
                                                                maxLines: 1,
                                                                style:
                                                                    TextStyle(
                                                                  overflow:
                                                                      TextOverflow
                                                                          .ellipsis,
                                                                  color: Colors
                                                                      .black,
                                                                  fontSize: 14,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500,
                                                                  fontFamily:
                                                                      poppins,
                                                                ),
                                                              ),
                                                            ),
                                                            SizedBox(
                                                              width: 10,
                                                            ),
                                                            GestureDetector(
                                                              onTap: () async {
                                                                await Share.share(
                                                                    widget
                                                                            .PublicData?[
                                                                                index]
                                                                            .webViewLink ??
                                                                        '',
                                                                    subject: widget
                                                                            .PublicData?[index]
                                                                            .title ??
                                                                        '');
                                                                setState(() {});
                                                              },
                                                              child: SizedBox(
                                                                  height: screenHeight(
                                                                      context,
                                                                      dividedBy:
                                                                          60),
                                                                  width: screenHeight(
                                                                      context,
                                                                      dividedBy:
                                                                          60),
                                                                  child: Image.asset(
                                                                      ImageConstants
                                                                          .share)),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                      SizedBox(height: 5),
                                                      Container(
                                                        height: screenHeight(
                                                            context,
                                                            dividedBy: 30),
                                                        width: screenWidth(
                                                            context,
                                                            dividedBy: 1.8),
                                                        child: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          children: [
                                                            customText(
                                                                "\$${widget.PublicData?[index].price}",
                                                                Colors.black26,
                                                                10,
                                                                FontWeight.w100,
                                                                poppins),
                                                            Icon(
                                                              Icons.star,
                                                              size: 17,
                                                              color: widget
                                                                          .PublicData?[
                                                                              index]
                                                                          .starredGift ==
                                                                      true
                                                                  ? ColorCodes
                                                                      .coral
                                                                  : Colors
                                                                      .white,
                                                            ),
                                                            SizedBox(width: 8),
                                                          ],
                                                        ),
                                                      ),
                                                      Container(
                                                        height: screenHeight(
                                                            context,
                                                            dividedBy: 30),
                                                        width: screenWidth(
                                                            context,
                                                            dividedBy: 1.8),
                                                        padding: EdgeInsets.only(
                                                            left: screenWidth(
                                                                context,
                                                                dividedBy: 60)),
                                                        alignment: Alignment
                                                            .centerLeft,
                                                        decoration: BoxDecoration(
                                                            color: Colors.white,
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        5),
                                                            border: Border.all(
                                                                width: 1.2,
                                                                color: ColorCodes
                                                                    .greyButton)),
                                                        child: customText(
                                                            "Notes: ${widget.PublicData?[index].notes ?? ""}",
                                                            Colors.black,
                                                            10,
                                                            FontWeight.w100,
                                                            poppins),
                                                      )
                                                    ],
                                                  ),
                                                )
                                              ],
                                            )),
                                      )));
                            }));
                  }
                  return Center(
                    child: spinkitLoader(context, ColorCodes.coral),
                  );
                },
              )
            ])),
      ),
    );
  }
}
