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

class IdeaGrannyTrish extends StatefulWidget {
  String name;
  List<Myidea>? PublicData;

  IdeaGrannyTrish({Key? key, required this.name,required this.PublicData}) : super(key: key);

  @override
  State<IdeaGrannyTrish> createState() => _IdeaGrannyTrishState();
}

class _IdeaGrannyTrishState extends State<IdeaGrannyTrish> {
  Fetch_All_GiftsCubit fetch_all_giftsCubit = Fetch_All_GiftsCubit();
  @override
  void initState() {
    super.initState();
    fetch_all_giftsCubit = BlocProvider.of<Fetch_All_GiftsCubit>(context);
    fetch_all_giftsCubit.Fetch_All_GiftsService();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
            BlocBuilder<Fetch_All_GiftsCubit, Fetch_All_GiftsState>(builder: (context, state) {
              log("NoGroupsCubit $state");
              if (state is Fetch_All_GiftsLoading) {
                return Center(
                  child: spinkitLoader(context, ColorCodes.coral),
                );
              }else if (state is Fetch_All_GiftsError) {
                return Center(
                  child: customText("Not Data Found!", Colors.black, 15,
                      FontWeight.w500, poppins),
                );
              }else if (state is Fetch_All_GiftsSuccess) {
                return Expanded(child: GridView.builder(
                    //itemCount:3,
                    itemCount:widget.PublicData?.length,
                    physics:  BouncingScrollPhysics(),
                    padding: EdgeInsets.only(
                        left: screenWidth(context, dividedBy: 30),
                        right: screenWidth(context, dividedBy: 30),
                        bottom: screenWidth(context, dividedBy: 6)),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2 ,
                         crossAxisSpacing: screenWidth(context, dividedBy: 25),
                         mainAxisSpacing: screenWidth(context, dividedBy: 50),
                       ),
                    itemBuilder: (context, index) {
                      return Container(
                       // height: screenHeight(context,dividedBy: 2.5),
                          width: screenWidth(context, dividedBy: 2.3),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(topLeft: Radius.circular(10),topRight: Radius.circular(10))),
                          child: Column(
                            children: [
                              CachedNetworkImage(
                                imageUrl: widget.PublicData?[index].image ?? '',
                                imageBuilder: (context, imageProvider) {
                                  return  Container(
                                    margin: EdgeInsets.only(bottom: 5),
                                    height: screenHeight(context, dividedBy: 8.05),
                                    width: screenWidth(context, dividedBy: 2.3),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                      image: DecorationImage(image: imageProvider,fit: BoxFit.fill)
                                    ),
                                  );
                                },
                                placeholder: (context, url) => customLoader(context),
                                errorWidget: (context, url, error) => Image(image: AssetImage("assets/images/gift.png"),fit: BoxFit.fill,),
                              ),
                              // Container(
                              //   margin: EdgeInsets.only(bottom: 5),
                              //   height: screenHeight(context, dividedBy: 5.5),
                              //   width: screenWidth(context, dividedBy: 2.3),
                              //   decoration: BoxDecoration(
                              //       color: Colors.red,
                              //       borderRadius: BorderRadius.circular(10)
                              //   ),
                              // ),
                              AutoSizeText(
                                widget.PublicData?[index].title ?? '',maxLines: 2,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  overflow: TextOverflow.ellipsis,
                                  color: Colors.black38,
                                  fontSize: 15,
                                  fontFamily: poppins,
                                  fontWeight: FontWeight.w100,
                                ),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  SizedBox(width: 5,),
                                  customText("\$${ widget.PublicData?[index].price}", Colors.black26, 10,
                                      FontWeight.w100, poppins),
                                  Spacer(),
                                  GestureDetector(
                                    onTap: () async {
                                      await Share.share(
                                          widget.PublicData?[index].webViewLink ?? '',
                                          subject:  widget.PublicData?[index].title ??
                                              '');
                                      setState(() {});
                                    },
                                    child: SizedBox(
                                        height: screenHeight(context,
                                            dividedBy: 60),
                                        width: screenHeight(context,
                                            dividedBy: 60),
                                        child: Image.asset(
                                            ImageConstants.share)),
                                  ),
                                  SizedBox(width: 8,),
                                ],
                              )
                            ],
                          ));
                      //   Container(
                      //   decoration: BoxDecoration(
                      //       color: Colors.white,
                      //       borderRadius: BorderRadius.circular(10)),
                      //   child: Column(
                      //     children: [
                      //       Container(
                      //         height: screenHeight(context, dividedBy: 6),
                      //         width: screenWidth(context),
                      //         decoration: BoxDecoration(
                      //             color: ColorCodes.coral,
                      //             borderRadius: BorderRadius.circular(10)),
                      //         child: Column(
                      //           children: [
                      //             Stack(
                      //               children: [
                      //                 SizedBox(
                      //                   height: screenHeight(context,
                      //                       dividedBy: 6),
                      //                   width: screenWidth(context),
                      //                   child: ClipRRect(
                      //                     borderRadius:
                      //                     BorderRadius.circular(10),
                      //                     child: CachedNetworkImage(
                      //                       fit:  BoxFit.fill,
                      //                       height: 80,
                      //                       width: 180,
                      //                       imageUrl: noGroupsCubit.noGroupData!.data![index].image,
                      //                       placeholder: (context, url) => customLoader(context),
                      //                       errorWidget: (context, url, error) => Image(image: AssetImage("assets/images/gift.png"),fit: BoxFit.fitHeight,),
                      //                     ),
                      //                     // Image.network(
                      //                     //  ,
                      //                     //   fit: BoxFit.fill,
                      //                     //   height: 80,
                      //                     //   width: 180,
                      //                     // )
                      //                   ),
                      //                 ),
                      //                 Container(
                      //                   height: screenHeight(context,
                      //                       dividedBy: 6),
                      //                   width: screenWidth(context),
                      //                   padding: EdgeInsets.all(screenWidth(
                      //                       context,
                      //                       dividedBy: 50)),
                      //                   decoration: BoxDecoration(
                      //                     borderRadius:
                      //                     BorderRadius.circular(10),
                      //                   ),
                      //                 ),
                      //               ],
                      //             ),
                      //           ],
                      //         ),
                      //       ),
                      //       SizedBox(
                      //         height: screenHeight(context, dividedBy: 100),
                      //       ),
                      //       Padding(
                      //         padding: EdgeInsets.only(
                      //             left: screenWidth(context, dividedBy: 100),
                      //             right:
                      //             screenWidth(context, dividedBy: 100)),
                      //         child: Column(
                      //           crossAxisAlignment: CrossAxisAlignment.start,
                      //           children: [
                      //             SizedBox(
                      //                 height: screenHeight(context,
                      //                     dividedBy: 30.5),
                      //                 child: customText(
                      //                     noGroupsCubit.noGroupData!.data![index].title,
                      //                     Colors.black,
                      //                     16,
                      //                     FontWeight.w500,
                      //                     poppins,
                      //                     maxLines: 3)),
                      //             SizedBox(
                      //                 height: screenHeight(context,
                      //                     dividedBy: 15.5),
                      //                 child: customText(
                      //                     noGroupsCubit.noGroupData!.data![index].notes,
                      //                     Colors.black,
                      //                     16,
                      //                     FontWeight.w500,
                      //                     poppins,
                      //                     maxLines:2 )),
                      //
                      //             Row(
                      //               mainAxisAlignment:
                      //               MainAxisAlignment.spaceBetween,
                      //               children: [
                      //                 Column(
                      //                   children: [
                      //                     SizedBox(
                      //                         height: screenHeight(context,
                      //                             dividedBy: 160)),
                      //                     customText(
                      //                         "\$${noGroupsCubit.noGroupData!.data![index].price.toString()}",
                      //                         ColorCodes.greyText,
                      //                         10,
                      //                         FontWeight.w500,
                      //                         poppins),
                      //                     Row(
                      //                       children: [
                      //                         SizedBox(
                      //                             height: screenHeight(
                      //                                 context,
                      //                                 dividedBy: 80)),
                      //                         const Text(
                      //                           "4.5",
                      //                           style: TextStyle(
                      //                               fontFamily: "Poppins",
                      //                               fontWeight:
                      //                               FontWeight.w500,
                      //                               fontSize: 8,
                      //                               color: Color(0xff888888)),
                      //                         ),
                      //                         Icon(
                      //                           Icons.star,
                      //                           color: ColorCodes.orangeFav,
                      //                           size: screenWidth(context,
                      //                               dividedBy: 35),
                      //                         ),
                      //                       ],
                      //                     ),
                      //                   ],
                      //                 ),
                      //                 Container(
                      //                   height: screenHeight(context,
                      //                       dividedBy: 36),
                      //                   width: screenWidth(context,
                      //                       dividedBy: 6),
                      //                   decoration: BoxDecoration(
                      //                     color: ColorCodes.coral,
                      //                     borderRadius:
                      //                     BorderRadius.circular(100),
                      //                   ),
                      //                   alignment: Alignment.center,
                      //                   child: const Text(
                      //                     "GIFT ME",
                      //                     style: TextStyle(
                      //                       fontFamily: "Poppins",
                      //                       fontWeight: FontWeight.w600,
                      //                       fontSize: 10,
                      //                       color: Colors.white,
                      //                     ),
                      //                   ),
                      //                 )
                      //               ],
                      //             )
                      //           ],
                      //         ),
                      //       )
                      //     ],
                      //   ),
                      // );
                    }));
              }
              return Center(
                child: spinkitLoader(context, ColorCodes.coral),
              );
            },)
          ])),
    );
  }
}
