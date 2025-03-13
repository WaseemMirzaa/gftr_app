import 'dart:developer';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gftr/Helper/appConfig.dart';
import 'package:gftr/Helper/colorConstants.dart';
import 'package:gftr/View/Widgets/customLoader.dart';
import 'package:gftr/View/Widgets/customText.dart';
import 'package:gftr/ViewModel/Cubits/groupscubit.dart';
import 'package:gftr/ViewModel/Cubits/markgifed_cubit.dart';
import 'package:gradient_borders/box_borders/gradient_box_border.dart';

import 'google.dart';

class GftrDetails extends StatefulWidget {
  String image;
  String name;
  String nots;
  String title;
  String price;
  String id,weburl;
  GftrDetails(
      {Key? key,
      required this.image,
      required this.name,
      required this.nots,
      required this.id,
      required this.price,
      required this.weburl,
      required this.title})
      : super(key: key);

  @override
  State<GftrDetails> createState() => _GftrDetailsState();
}

class _GftrDetailsState extends State<GftrDetails> {
  bool isReserved = false;
  bool isGifted = false;
  bool notSure = true;
  String? markGifted;
  MarkGiftCubit markGiftCubit = MarkGiftCubit();
  GroupViewCubit groupViewCubit = GroupViewCubit();
  Widget selectOptions(
      String text, Color boxColor, Color borderColor, bool checkFlag) {
    return SizedBox(
      height: screenHeight(context, dividedBy: 40),
      child: Row(
        children: [
          Container(
            height: screenHeight(context, dividedBy: 60),
            width: screenHeight(context, dividedBy: 60),
            decoration: BoxDecoration(
                color: boxColor,
                borderRadius: BorderRadius.circular(3),
                border: !checkFlag ? Border.all(color: borderColor) : null),
          ),
          const SizedBox(
            width: 7,
          ),
          Text(text,
              style: const TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w400,
                  fontSize: 11,
                  fontFamily: "Poppins")),
          // customText(text, Colors.black, 10, FontWeight.w400, poppins),
        ],
      ),
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    markGiftCubit = BlocProvider.of<MarkGiftCubit>(context);
    groupViewCubit = BlocProvider.of<GroupViewCubit>(context);
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: screenHeight(context),
      width: screenWidth(context),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
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
            SizedBox(
              height: screenHeight(context, dividedBy: 70),
            ),
            Container(
              height: screenHeight(context, dividedBy: 1.2),
              child: Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      height: screenHeight(context, dividedBy: 3.2),
                      width: screenWidth(context, dividedBy: 1.1),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10)),
                      child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child:
                          CachedNetworkImage(
                            imageUrl: widget.image,
                            placeholder: (context, url) => customLoader(context),
                            errorWidget: (context, url, error) => Center(child: Image(image: AssetImage("assets/images/No-image-available.png"),)),
                          )
                          // Image.network(
                          //   widget.image,
                          //   fit: BoxFit.cover,
                          // )
                      ),
                    ),
                    SizedBox(
                      height: screenHeight(context, dividedBy: 100),
                    ),
                    Container(
                      height: screenHeight(context, dividedBy: 20),
                      width: screenWidth(context, dividedBy: 1.1),
                      padding: EdgeInsets.symmetric(
                          horizontal: screenWidth(context, dividedBy: 70)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            width: screenWidth(context, dividedBy: 1.6),
                            child: customText(widget.title, Colors.black, 12,
                                FontWeight.w500, poppins,
                                maxLines: 2),
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              customText(
                                  "\$${widget.price}",
                                  ColorCodes.greyText,
                                  12,
                                  FontWeight.w500,
                                  poppins),
                              Row(
                                children: [
                                  const Text(
                                    "4.5",
                                    style: TextStyle(
                                        fontFamily: "Poppins",
                                        fontWeight: FontWeight.w500,
                                        fontSize: 8,
                                        color: Color(0xff888888)),
                                  ),
                                  Icon(
                                    Icons.star,
                                    color: ColorCodes.orangeFav,
                                    size: screenWidth(context, dividedBy: 35),
                                  )
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: screenHeight(context, dividedBy: 50),
                    ),
                    Container(
                      height: screenHeight(context, dividedBy: 12),
                      width: screenWidth(context, dividedBy: 1.1),
                      decoration: BoxDecoration(
                          color: ColorCodes.greyDetailBox,
                          borderRadius: BorderRadius.circular(7)),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          customText("Granny's Notes:", Colors.black, 13,
                              FontWeight.w500, poppins),
                          SizedBox(
                              height: screenHeight(context, dividedBy: 130)),
                          Text(
                            widget.nots,
                            textAlign: TextAlign.center,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                fontFamily: "Poppins",
                                fontWeight: FontWeight.w400,
                                fontSize: 10,
                                color: Colors.black),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: screenHeight(context, dividedBy: 50),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          left: screenWidth(context, dividedBy: 26)),
                      child: SizedBox(
                          width: screenWidth(context, dividedBy: 1.1),
                          child: customText(
                              "Before you leave, should we mark this gift as:",
                              Colors.black,
                              12,
                              FontWeight.w500,
                              poppins)),
                    ),
                    SizedBox(
                      height: screenHeight(context, dividedBy: 80),
                    ),
                    SizedBox(
                        width: screenWidth(context, dividedBy: 1.2),
                        child: Column(children: [
                          GestureDetector(
                              onTap: () {
                                setState(() {
                                  isReserved = true;
                                  isGifted = false;
                                  notSure = false;
                                });
                              },
                              child: selectOptions(
                                  "Reserved",
                                  isReserved ? ColorCodes.coral : Colors.white,
                                  isReserved
                                      ? Colors.transparent
                                      : Colors.black,
                                  isReserved)),
                          GestureDetector(
                              onTap: () {
                                setState(() {
                                  isReserved = false;
                                  isGifted = true;
                                  notSure = false;
                                });
                              },
                              child: selectOptions(
                                  "Gifted",
                                  isGifted ? ColorCodes.coral : Colors.white,
                                  isGifted ? Colors.transparent : Colors.black,
                                  isGifted)),
                          GestureDetector(
                              onTap: () {
                                setState(() {
                                  isReserved = false;
                                  isGifted = false;
                                  notSure = true;
                                });
                              },
                              child: selectOptions(
                                  "Not sure yet - I'll be back!",
                                  notSure ? ColorCodes.coral : Colors.white,
                                  notSure ? Colors.transparent : Colors.black,
                                  notSure)),
                        ])),
                    SizedBox(height: screenHeight(context, dividedBy: 100)),
                    Padding(
                      padding: EdgeInsets.only(
                          left: screenWidth(context, dividedBy: 26)),
                      child: SizedBox(
                          width: screenWidth(context, dividedBy: 1.1),
                          child: customText(
                              "(Don't worry, we won’t tell ${widget.name}!)",
                              ColorCodes.greyText,
                              12,
                              FontWeight.w500,
                              poppins)),
                    ),
                    SizedBox(height: screenHeight(context, dividedBy: 20)),
                    GestureDetector(
                      onTap: () {
                        if (isReserved == true) {
                          markGifted = 'Reserved';
                        } else if (isGifted == true) {
                          markGifted = 'Gifted';
                        } else if (notSure == true) {
                          markGifted = 'Gift Me';
                        }
                        log(markGifted.toString());
                        markGiftCubit
                            .getMarkGift(context,
                                markGift: markGifted.toString(), id: widget.id)
                            .then((value) {
                          defauilUrl = widget.weburl ?? '';
                          Navigator.push(context, MaterialPageRoute(builder: (context) => GooglePage()));
                          groupViewCubit.getGroups();
                        });
                      },
                      child: Container(
                        height: screenHeight(context, dividedBy: 23),
                        width: screenWidth(context, dividedBy: 1.8),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          border: const GradientBoxBorder(
                            gradient: LinearGradient(
                              colors: [
                                Color(0xff4BADB8),
                                Color(0xffF37A5B),
                              ],
                            ),
                          ),
                        ),
                        child: BlocBuilder<MarkGiftCubit, MarkGiftState>(
                            builder: (context, state) {
                          if (state is MarkGiftLoading) {
                            return spinkitLoader(context, ColorCodes.coral);
                          }
                          return Text("Get Gifting",
                              style: TextStyle(
                                  color: ColorCodes.coral,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 14));
                        }),
                      ),
                    ),
                    SizedBox(
                      height: screenHeight(context, dividedBy: 20),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
