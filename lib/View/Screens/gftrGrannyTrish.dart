import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gftr/Helper/appConfig.dart';
import 'package:gftr/Helper/colorConstants.dart';
import 'package:gftr/Helper/imageConstants.dart';
import 'package:gftr/Model/groups.dart';
import 'package:gftr/View/Screens/ManageBottom/gftrDitailsviewpage.dart';
import 'package:gftr/View/Screens/ManageBottom/ideagranyytrisPageView.dart';
import 'package:gftr/View/Widgets/customButton.dart';
import 'package:gftr/View/Widgets/customText.dart';
import 'package:gradient_borders/box_borders/gradient_box_border.dart';
import 'package:share_plus/share_plus.dart';

import '../Widgets/customLoader.dart';

class GftrGrannyTrish extends StatefulWidget {
  String groupName, Add, groupId;
  List<Myidea> gifts;

  // List<Myidea>? PublicData;

  GftrGrannyTrish(
      {Key? key,
      required this.groupName,
      required this.gifts,
      required this.Add,
      required this.groupId})
      : super(key: key);
  @override
  State<GftrGrannyTrish> createState() => _GftrGrannyTrishState();
}

class _GftrGrannyTrishState extends State<GftrGrannyTrish> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: screenHeight(context),
        width: screenWidth(context),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          SizedBox(
            height: screenHeight(context, dividedBy: 50),
          ),
          Padding(
            padding: EdgeInsets.only(
                left: screenWidth(context, dividedBy: 30),
                right: screenWidth(context, dividedBy: 30)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Icon(Icons.arrow_back_ios_outlined, size: 20)),
                GestureDetector(
                    onTap: () {
                      Clipboard.setData(new ClipboardData(text: widget.Add))
                          .then((_) {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text('Copied to your clipboard !')));
                      });
                    },
                    child: Row(
                      children: [
                        customText("Copy Address", ColorCodes.greyText, 10,
                            FontWeight.w100, poppins),
                        SizedBox(
                            width: screenWidth(
                          context,
                          dividedBy: 100,
                        )),
                        Icon(Icons.copy, size: 20),
                      ],
                    )),
              ],
            ),
          ),
          Container(
            height: screenHeight(context, dividedBy: 20),
            padding: EdgeInsets.only(left: screenWidth(context, dividedBy: 25)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                customText(widget.groupName, Colors.black, 20, FontWeight.w200,
                    madeOuterSans),
              ],
            ),
          ),
          SizedBox(
            height: screenHeight(context, dividedBy: 70),
          ),
          Expanded(
              child: Stack(alignment: Alignment.bottomCenter, children: [
            GridView.builder(
                itemCount: widget.gifts.length,
                physics: const BouncingScrollPhysics(),
                padding: EdgeInsets.only(
                  left: screenWidth(context, dividedBy: 30),
                  right: screenWidth(context, dividedBy: 30),
                ),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: screenWidth(context, dividedBy: 30),
                    mainAxisSpacing: screenWidth(context, dividedBy: 30),
                    childAspectRatio: 0.75),
                itemBuilder: (context, index) {
                  return Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10)),
                    child: Column(
                      children: [
                        Container(
                          height: screenHeight(context, dividedBy: 6),
                          width: screenWidth(context),
                          decoration: BoxDecoration(
                              color: ColorCodes.coral,
                              borderRadius: BorderRadius.circular(10)),
                          child: Column(
                            children: [
                              Stack(
                                children: [
                                  SizedBox(
                                    height: screenHeight(context, dividedBy: 6),
                                    width: screenWidth(context),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(10),
                                      child: CachedNetworkImage(
                                        fit: BoxFit.cover,
                                        imageUrl: widget.gifts[index].image
                                            .toString(),
                                        placeholder: (context, url) =>
                                            customLoader(context),
                                        errorWidget: (context, url, error) =>
                                            Center(
                                                child: Image(
                                          image: AssetImage(
                                              "assets/images/No-image-available.png"),
                                        )),
                                      ),
                                      // Image.network(
                                      //    ?? '',
                                      //   fit: BoxFit.cover,
                                      // )
                                    ),
                                  ),
                                  Container(
                                    height: screenHeight(context, dividedBy: 6),
                                    width: screenWidth(context),
                                    padding: EdgeInsets.all(
                                        screenWidth(context, dividedBy: 50)),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(15),
                                    ),
                                    alignment: Alignment.topRight,
                                    child:
                                        widget.gifts[index].starredGift == true
                                            ? Icon(
                                                Icons.star,
                                                color: ColorCodes.coral,
                                                size: screenWidth(context,
                                                    dividedBy: 20),
                                              )
                                            : SizedBox(),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: screenHeight(context, dividedBy: 100),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                              left: screenWidth(context, dividedBy: 100),
                              right: screenWidth(context, dividedBy: 100)),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                  height: screenHeight(context, dividedBy: 18),
                                  child: Text(
                                    widget.gifts[index].title,
                                    overflow: TextOverflow.ellipsis,
                                    textAlign: TextAlign.left,
                                    maxLines: 2,
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 13,
                                      fontFamily: poppins,
                                    ),
                                  )),
                              // SizedBox(height: screenHeight(context,dividedBy: 100),),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    children: [
                                      customText(
                                          "\$${widget.gifts[index].price}",
                                          ColorCodes.greyText,
                                          10,
                                          FontWeight.w500,
                                          poppins),
                                      Row(
                                        children: [
                                          SizedBox(
                                              height: screenHeight(context,
                                                  dividedBy: 80)),
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
                                            size: screenWidth(context,
                                                dividedBy: 35),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  Row(children: [
                                    GestureDetector(
                                      onTap: () async {
                                        await Share.share(
                                            widget.gifts[index].title,
                                            subject: widget
                                                .gifts[index].webViewLink);
                                        setState(() {});
                                      },
                                      child: SizedBox(
                                          height: screenHeight(context,
                                              dividedBy: 70),
                                          width: screenHeight(context,
                                              dividedBy: 70),
                                          child: Image.asset(
                                              ImageConstants.share)),
                                    ),
                                    const SizedBox(
                                      width: 5,
                                    ),
                                    widget.gifts[index].markGift == 'Gift Me'
                                        ? GestureDetector(
                                            onTap: () {
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          GftrDetailsViewPage(
                                                            id: widget
                                                                .gifts[index]
                                                                .id,
                                                            url: widget
                                                                .gifts[index]
                                                                .webViewLink,
                                                            name: widget
                                                                .groupName,
                                                            title: widget
                                                                .gifts[index]
                                                                .title,
                                                            image: widget
                                                                .gifts[index]
                                                                .image,
                                                            price: widget
                                                                .gifts[index]
                                                                .price,
                                                            nots: widget
                                                                .gifts[index]
                                                                .notes,
                                                          )));
                                            },
                                            child: Container(
                                              height: screenHeight(context,
                                                  dividedBy: 36),
                                              width: screenWidth(context,
                                                  dividedBy: 6),
                                              decoration: BoxDecoration(
                                                color: ColorCodes.coral,
                                                borderRadius:
                                                    BorderRadius.circular(100),
                                              ),
                                              alignment: Alignment.center,
                                              child: Text(
                                                "GIFT ME",
                                                style: const TextStyle(
                                                  fontFamily: "Poppins",
                                                  fontWeight: FontWeight.w600,
                                                  fontSize: 10,
                                                  color: Colors.white,
                                                ),
                                              ),
                                            ),
                                          )
                                        : widget.gifts[index].markGift ==
                                                'Reserved'
                                            ? InkWell(
                                                onTap: () {
                                                  Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                              GftrDetailsViewPage(
                                                                id: widget
                                                                    .gifts[
                                                                        index]
                                                                    .id,
                                                                url: widget
                                                                    .gifts[
                                                                        index]
                                                                    .webViewLink,
                                                                name: widget
                                                                    .groupName,
                                                                title: widget
                                                                    .gifts[
                                                                        index]
                                                                    .title,
                                                                image: widget
                                                                    .gifts[
                                                                        index]
                                                                    .image,
                                                                price: widget
                                                                    .gifts[
                                                                        index]
                                                                    .price,
                                                                nots: widget
                                                                    .gifts[
                                                                        index]
                                                                    .notes,
                                                              )));
                                                },
                                                child: Container(
                                                  height: screenHeight(context,
                                                      dividedBy: 34),
                                                  width: screenWidth(context,
                                                      dividedBy: 6.2),
                                                  decoration: BoxDecoration(
                                                    color: Colors.white,
                                                    border:
                                                        const GradientBoxBorder(
                                                      gradient: LinearGradient(
                                                          colors: [
                                                            ColorCodes.teal,
                                                            ColorCodes.coral,
                                                          ]),
                                                      width: 1,
                                                    ),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            100),
                                                  ),
                                                  alignment: Alignment.center,
                                                  child: const Text(
                                                    "RESERVED",
                                                    style: TextStyle(
                                                        fontFamily: "Poppins",
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        fontSize: 9,
                                                        color:
                                                            Color(0xffF37A5B)),
                                                  ),
                                                ),
                                              )
                                            : InkWell(
                                                onTap: () {
                                                  Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                              GftrDetailsViewPage(
                                                                id: widget
                                                                    .gifts[
                                                                        index]
                                                                    .id,
                                                                url: widget
                                                                    .gifts[
                                                                        index]
                                                                    .webViewLink,
                                                                name: widget
                                                                    .groupName,
                                                                title: widget
                                                                    .gifts[
                                                                        index]
                                                                    .title,
                                                                image: widget
                                                                    .gifts[
                                                                        index]
                                                                    .image,
                                                                price: widget
                                                                    .gifts[
                                                                        index]
                                                                    .price,
                                                                nots: widget
                                                                    .gifts[
                                                                        index]
                                                                    .notes,
                                                              )));
                                                },
                                                child: Container(
                                                  height: screenHeight(context,
                                                      dividedBy: 36),
                                                  width: screenWidth(context,
                                                      dividedBy: 6),
                                                  decoration: BoxDecoration(
                                                    color: Colors.black45,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            100),
                                                  ),
                                                  alignment: Alignment.center,
                                                  child: Text(
                                                    "GIFTED",
                                                    style: const TextStyle(
                                                      fontFamily: "Poppins",
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      fontSize: 10,
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                ),
                                              )
                                  ])
                                ],
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  );
                }),
            Padding(
              padding:
                  EdgeInsets.only(bottom: screenHeight(context, dividedBy: 20)),
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => IdeaGrannyTrishViePage(
                            Groupsname: widget.groupName,
                            groupId: widget.groupId),
                      ));
                },
                child: customButton(
                    context, screenWidth(context, dividedBy: 3.4), "My Ideas"),
              ),
            )
          ]))
        ]));
  }
}
