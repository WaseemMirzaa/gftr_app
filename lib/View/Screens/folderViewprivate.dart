import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gftr/Helper/appConfig.dart';
import 'package:gftr/Helper/colorConstants.dart';
import 'package:gftr/Helper/imageConstants.dart';
import 'package:gftr/View/Screens/google.dart';
import 'package:gftr/View/Widgets/customLoader.dart';
import 'package:gftr/View/Widgets/customText.dart';
import 'package:gftr/ViewModel/Cubits/GetGifted/getgiftedview_dart.dart';
import 'package:gftr/ViewModel/Cubits/folderview_cubit.dart';
import 'package:share_plus/share_plus.dart';
import 'ManageBottom/gftrStoryViewPage.dart';

class FolderPrivateView extends StatefulWidget {
  int imageIndex;
  String folderName;


  FolderPrivateView({required this.imageIndex,required this.folderName});

  @override
  State<FolderPrivateView> createState() => _FolderPrivateViewState();
}

class _FolderPrivateViewState extends State<FolderPrivateView> {
  FolderViewDeleteCubit folderViewDeleteCubit = FolderViewDeleteCubit();
  GetGiftedViewCubit getGiftedViewCubit = GetGiftedViewCubit();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    folderViewDeleteCubit = BlocProvider.of<FolderViewDeleteCubit>(context);
    getGiftedViewCubit = BlocProvider.of<GetGiftedViewCubit>(context);
    getGiftedViewCubit.getViewGift();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        height: screenHeight(context),
        width: screenWidth(context),
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
              height: screenHeight(context, dividedBy: 100),
            ),
            Padding(
              padding:
                  EdgeInsets.only(left: screenWidth(context, dividedBy: 30)),
              child: SizedBox(
                  width: screenWidth(context, dividedBy: 1.1),
                  child: customText(widget.folderName, Colors.black, 18,
                      FontWeight.w300, madeOuterSans)),
            ),
            SizedBox(
              height: screenHeight(context, dividedBy: 50),
            ),
            getGiftedViewCubit.viewGift!.privateData![widget.imageIndex].formdata!.isNotEmpty
                ? Expanded(
                    child: ListView.builder(
                        itemCount: getGiftedViewCubit.viewGift
                            ?.privateData?[widget.imageIndex].formdata?.length,
                        padding: EdgeInsets.only(
                            top: screenHeight(context, dividedBy: 100)),
                        itemBuilder: (context, index) {
                          return GestureDetector(onTap: (){

                          },
                            child: Column(children: [
                              Dismissible(
                                  key: UniqueKey(),
                                  direction: DismissDirection.endToStart,
                                  onDismissed: (direction) {
                                    folderViewDeleteCubit
                                        .folderViewDeleteGift(
                                          folderViewId: getGiftedViewCubit
                                                  .viewGift
                                                  ?.privateData?[widget.imageIndex]
                                                  .formdata?[index]
                                                  .id ??
                                              '',
                                          giftfolderId: getGiftedViewCubit
                                                  .viewGift
                                                  ?.privateData?[widget.imageIndex]
                                                  .id ??
                                              '',
                                        )
                                        .then((value) =>
                                            getGiftedViewCubit.getViewGift());
                                    print("Abcd");
                                  },
                                  background: Container(
                                    padding: EdgeInsets.only(
                                        right:
                                            screenWidth(context, dividedBy: 10)),
                                    decoration: BoxDecoration(
                                        color: Colors.red,
                                        borderRadius: BorderRadius.circular(10),
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.grey.shade300,
                                            blurRadius: 1,
                                          )
                                        ]),
                                    alignment: Alignment.centerRight,
                                    child: customText("Delete", Colors.white, 18,
                                        FontWeight.w700, poppins),
                                  ),
                                  child: Container(
                                      height: screenHeight(context, dividedBy: 8),
                                      width: screenWidth(context, dividedBy: 1.1),
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.circular(10),
                                          boxShadow: [
                                            BoxShadow(
                                              color: Colors.grey.shade300,
                                              offset: const Offset(3.0, 3.0),
                                              blurRadius: 1,
                                            )
                                          ]),
                                      child: Row(children: [
                                        InkWell(
                                          onTap: () {
                                            defauilUrl = getGiftedViewCubit
                                                .viewGift
                                                ?.privateData?[widget.imageIndex]
                                                .formdata?[index]
                                                .webViewLink ??
                                                '';
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) => GooglePage()));
                                            setState(() {});
                                          },
                                          child: Container(
                                              alignment: Alignment.centerLeft,
                                              width: screenWidth(context,
                                                  dividedBy: 3.4),
                                              height: screenHeight(context,
                                                  dividedBy: 7),
                                              child: ClipRRect(
                                                  borderRadius:
                                                      const BorderRadius.only(
                                                          topLeft:
                                                              Radius.circular(10),
                                                          bottomLeft:
                                                              Radius.circular(
                                                                  10)),
                                                  child:  CachedNetworkImage(
                                                    fit:  BoxFit.fill,
                                                    height: 80,
                                                    width: 180,
                                                    imageUrl:   getGiftedViewCubit.viewGift?.privateData?[widget.imageIndex].formdata?[index].image ?? '',
                                                    placeholder: (context, url) => spinkitLoader(context, ColorCodes.coral),
                                                    errorWidget: (context, url, error) => Center(child: Image(image: AssetImage("assets/images/No-image-available.png"),)),
                                                  ),
                                                  // Image.network(

                                                //       errorBuilder: (context, object, stacktrace) {
                                                  //   debugPrint("object : ${object.toString()}");
                                                  //   debugPrint( "stacktrace : ${stacktrace.toString()}");
                                                  //   return Center(child: Image(image: AssetImage("assets/images/gift.png")));
                                                  // },
                                                  //   fit: BoxFit.fill,
                                                  //   height: 80,
                                                  //   width: 180,
                                                  // )
                                              )),
                                        ),
                                        SizedBox(
                                          width:
                                              screenWidth(context, dividedBy: 30),
                                        ),
                                        Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              SizedBox(
                                                height: screenHeight(context,dividedBy: 25),
                                                width: screenWidth(context,dividedBy: 1.8),
                                                child: Row(
                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                  children: [
                                                    SizedBox(
                                                      width: screenWidth(context,dividedBy: 2),
                                                      child: customText(
                                                          getGiftedViewCubit
                                                              .viewGift
                                                              ?.privateData?[
                                                          widget.imageIndex]
                                                              .formdata?[index]
                                                              .title ??
                                                              "",
                                                          overflowText: true,
                                                          Colors.black,
                                                          14,
                                                          FontWeight.w500,
                                                          poppins,
                                                          maxLines: 1),
                                                    ),
                                                    GestureDetector(
                                                      onTap: () async {
                                                        await Share.share(getGiftedViewCubit
                                                            .viewGift
                                                            ?.privateData?[widget.imageIndex]
                                                            .formdata?[index]
                                                            .webViewLink ??
                                                            '');
                                                        setState(() {});
                                                      },
                                                      child: SizedBox(
                                                          height: screenHeight(context,
                                                              dividedBy: 50),
                                                          width: screenHeight(context,
                                                              dividedBy: 50),
                                                          child: Image.asset(
                                                              ImageConstants.share)),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Container(
                                                height: screenHeight(context,dividedBy: 30),
                                                width: screenWidth(context,dividedBy: 1.8),
                                                child: Row(
                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                  children: [
                                                    customText(
                                                        "\$${getGiftedViewCubit.viewGift?.privateData?[widget.imageIndex].formdata?[index].price ?? ""}",
                                                        ColorCodes.greyText,
                                                        12,
                                                        FontWeight.w400,
                                                        poppins),
                                                    Icon(Icons.star,size: 17,color: getGiftedViewCubit.viewGift?.privateData?[widget.imageIndex].formdata?[index].starredGift == true ?ColorCodes.coral:Colors.white,)
                                                  ],
                                                ),
                                              ),

                                              Container(
                                                height: screenHeight(context,
                                                    dividedBy: 30),
                                                width: screenWidth(context,
                                                    dividedBy: 1.8),
                                                padding: EdgeInsets.only(
                                                    left: screenWidth(context,
                                                        dividedBy: 60)),
                                                alignment: Alignment.centerLeft,
                                                decoration: BoxDecoration(
                                                    color: Colors.white,
                                                    borderRadius:
                                                        BorderRadius.circular(5),
                                                    border: Border.all(
                                                        width: 1.2,
                                                        color: ColorCodes
                                                            .greyButton)),
                                                child: customText(
                                                    "Notes: ${getGiftedViewCubit.viewGift?.privateData?[widget.imageIndex].formdata?[index].notes ?? ""}",
                                                    Colors.black,
                                                    10,
                                                    FontWeight.w100,
                                                    poppins),
                                              )
                                            ])
                                      ]))),
                              SizedBox(
                                height: screenHeight(context, dividedBy: 50),
                              )
                            ]),
                          );
                        }),
                  )
                : Expanded(
                    child: Container(
                      width: screenWidth(context, dividedBy: 1),
                      child: Column(
                        children: [
                          Padding(
                            padding: EdgeInsets.only(top: 10),
                            child: Container(
                              child: customText(
                                  "Add a Gift",
                                  ColorCodes.greyText,
                                  22,
                                  FontWeight.w100,
                                  poppins),
                            ),
                          ),
                          // SizedBox(
                          //     height: screenHeight(context, dividedBy: 200)),
                          Padding(
                            padding: EdgeInsets.only(bottom: 5),
                            child: customText("with:", ColorCodes.greyText, 18,
                                FontWeight.normal, poppins),
                          ),
                          SizedBox(
                              height: screenHeight(context, dividedBy: 35)),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(context, MaterialPageRoute(builder: (context) {
                                return GooglePage();
                              },));
                            },
                            child: Container(
                              width: screenWidth(context, dividedBy: 3.2),
                              height: screenHeight(context, dividedBy: 7),
                              child: Image.asset(ImageConstants.googlephoto),
                            ),
                          ),
                          SizedBox(
                              height: screenHeight(context, dividedBy: 35)),
                          customText("or", ColorCodes.greyText, 18,
                              FontWeight.w100, poppins),
                          SizedBox(
                              height: screenHeight(context, dividedBy: 35)),
                          GestureDetector(onTap: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context) => GfterStoryViewPage(),));
                            bottombarblack=true;
                          },
                            child: Container(
                              width: screenWidth(context, dividedBy: 3.8),
                              height: screenHeight(context, dividedBy: 7.5),
                              child: Image.asset(ImageConstants.bottomNavFloat),
                            ),
                          ),
                          SizedBox(
                              height: screenHeight(context, dividedBy: 95)),
                          Container(
                            width: screenWidth(context, dividedBy: 10),
                            height: screenHeight(context, dividedBy: 25),
                            child: Image.asset(ImageConstants.gftrBlack),
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
