import 'dart:developer';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gftr/Helper/appConfig.dart';
import 'package:gftr/Helper/colorConstants.dart';
import 'package:gftr/Helper/imageConstants.dart';
import 'package:gftr/View/Screens/ManageBottom/folderViewPage.dart';
import 'package:gftr/View/Screens/ManageBottom/getGiftedPublicView.dart';
import 'package:gftr/View/Widgets/PrivateFolderDaillog.dart';
import 'package:gftr/View/Widgets/customLoader.dart';
import 'package:gftr/View/Widgets/customText.dart';
import 'package:gftr/View/Widgets/flutterToast.dart';
import 'package:gftr/ViewModel/Cubits/GetGifted/getGiftedDelete_dart.dart';
import 'package:gftr/ViewModel/Cubits/GetGifted/getgifted_cubit.dart';
import 'package:gftr/ViewModel/Cubits/GetGifted/getgifted_rename.dart';
import 'package:gftr/ViewModel/Cubits/GetGifted/getgiftedview_dart.dart';
import 'package:gftr/ViewModel/Cubits/folderSetting.dart';

class GetGiftedPrivatePage extends StatefulWidget {
  const GetGiftedPrivatePage({Key? key}) : super(key: key);

  @override
  State<GetGiftedPrivatePage> createState() => _GetGiftedPrivatePageState();
}

class _GetGiftedPrivatePageState extends State<GetGiftedPrivatePage> {
  GetGiftedDeleteCubit getGiftedDeleteCubit = GetGiftedDeleteCubit();
  GetGiftedCubit getGiftedCubit = GetGiftedCubit();
  GetGiftedViewCubit getGiftedViewCubit = GetGiftedViewCubit();
  FolderRenameCubit folderRenameCubit = FolderRenameCubit();
  TextEditingController folderNameC = TextEditingController();
  TextEditingController folderRenameC = TextEditingController();
  FolderSettingCubit folderSettingCubit = FolderSettingCubit();
  List loader =  [];

  bool isPrivat=false;
  addFolderNameDialog() {
    return SimpleDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: TextField(
            textInputAction: TextInputAction.done,
            cursorColor: Colors.black45,
            controller: folderNameC,
            decoration: InputDecoration(
                border: InputBorder.none,
                hintText: 'Folder name',
                hintStyle: TextStyle(fontFamily: poppins)),
          ),
        ),
        Container(
          width: 200,
          height: 1,
          decoration: const BoxDecoration(
              color: Colors.black12,
              boxShadow: [BoxShadow(color: Colors.black38, blurRadius: 5)]),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            InkWell(
              onTap: () {
                Navigator.pop(context);
              },
              child: Container(
                margin: const EdgeInsets.only(top: 5),
                height: 20,
                width: 100,
                alignment: Alignment.center,
                child: Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: customText("Cancel", ColorCodes.greyText, 14,
                        FontWeight.w400, poppins)),
              ),
            ),
            Container(
              width: 1,
              height: 30,
              decoration: const BoxDecoration(
                  color: Colors.black12,
                  boxShadow: [BoxShadow(color: Colors.black38, blurRadius: 5)]),
            ),
            InkWell(
              onTap: () {
                if (folderNameC.text.isNotEmpty && folderNameC.text != null) {
                  getGiftedCubit
                      .getAddFolder(context, folderName: folderNameC.text,isPublic: isPrivat)
                      .then((value) {
                    Navigator.pop(context);
                    getGiftedViewCubit.getViewGift();
                    folderNameC.clear();
                  });
                } else {
                  flutterToast('Enter Folder Name', false);
                }
              },
              child: Container(
                margin: const EdgeInsets.only(top: 5),
                height: 20,
                width: 100,
                alignment: Alignment.center,
                child: BlocBuilder<GetGiftedCubit, GetGiftedState>(
                    builder: (context, state) {
                  if (state is GetGiftedLoading) {
                    return spinkitLoader(context, ColorCodes.greyButton);
                  }
                  return Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: customText("Save", ColorCodes.greyText, 14,
                          FontWeight.w400, poppins));
                }),
              ),
            )
          ],
        )
      ],
    );
  }
  renameDialog(String id,String Fname) {
    folderRenameC.text = Fname;
    return SimpleDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      children: [
        Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: TextField(
              textInputAction: TextInputAction.done,
              controller: folderRenameC,
              cursorColor: Colors.black45,
              decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Rename',
                  hintStyle: TextStyle(fontFamily: poppins)),
            )),
        Container(
          width: 200,
          height: 1,
          decoration: const BoxDecoration(
              color: Colors.black12,
              boxShadow: [BoxShadow(color: Colors.black38, blurRadius: 5)]),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            InkWell(
              onTap: () {
                Navigator.pop(context);
              },
              child: Container(
                margin: const EdgeInsets.only(top: 5),
                height: 20,
                width: 100,
                alignment: Alignment.center,
                child: Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: customText("Cancel", ColorCodes.greyText, 14,
                        FontWeight.w400, poppins)),
              ),
            ),
            Container(
              width: 1,
              height: 30,
              decoration: const BoxDecoration(
                  color: Colors.black12,
                  boxShadow: [BoxShadow(color: Colors.black38, blurRadius: 5)]),
            ),
            InkWell(
              onTap: () {
                // folderRenameCubit.getFolderRename(context, folderName: reName.text, id: widget.id);
                folderRenameCubit
                    .getFolderRename(context,
                    folderName: folderRenameC.text, id: id)
                    .then((value) {
                  Navigator.pop(context);
                  getGiftedViewCubit.getViewGift();
                  setState(() {});
                });
              },
              child: Container(
                margin: const EdgeInsets.only(top: 5),
                height: 20,
                width: 100,
                alignment: Alignment.center,
                child: BlocBuilder<FolderRenameCubit, FolderRenameState>(
                    builder: (context, state) {
                      if (state is FolderRenameLoading) {
                        return spinkitLoader(context, ColorCodes.greyText);
                      }
                      return Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: customText("Save", ColorCodes.greyText, 14,
                              FontWeight.w400, poppins));
                    }),
              ),
            )
          ],
        )
      ],
    );
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getGiftedCubit = BlocProvider.of<GetGiftedCubit>(context);
    getGiftedDeleteCubit = BlocProvider.of<GetGiftedDeleteCubit>(context);
    getGiftedViewCubit = BlocProvider.of<GetGiftedViewCubit>(context);
    folderSettingCubit = BlocProvider.of<FolderSettingCubit>(context);
    folderRenameCubit = BlocProvider.of<FolderRenameCubit>(context);
    getGiftedViewCubit.getViewGift();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
            height: screenHeight(context),
            width: screenWidth(context),
            // padding: EdgeInsets.symmetric(
            //     horizontal: screenWidth(context, dividedBy: 20)),
            child: Column(mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: screenHeight(context, dividedBy: 50),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                 horizontal:     screenWidth(context, dividedBy: 20)),
                  child: Row(crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      customText("Get Gifted", Colors.black, 20, FontWeight.w300,
                          madeOuterSans),
                      customText("Private Folders", Colors.black, 14, FontWeight.w500,
                          poppins),

                    ],
                  ),
                ),
                SizedBox(
                  height: screenHeight(context, dividedBy: 50),
                ),
                Padding(padding:
                  EdgeInsets.only(
                      left : screenWidth(context, dividedBy: 20)),
                  child: GestureDetector(
                    onTap: () {
                      showDialog(
                          context: context,
                          builder: (_) => addFolderNameDialog());
                    },
                    child: SizedBox(
                      height: screenHeight(context, dividedBy: 30),
                      child: Row(
                        children: [
                          Image.asset(ImageConstants.addFolder),
                          const SizedBox(
                            width: 5,
                          ),
                          customText("Add a folder", ColorCodes.greyText, 16,
                              FontWeight.w400, poppins)
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: screenHeight(context, dividedBy: 50),
                ),
                BlocBuilder<GetGiftedViewCubit, GetGiftedViewState>(
                  builder: (context, state) {
                    log('GetGifed : $state');
                    if (state is GetGiftedViewLoading) {
                      return Expanded(
                          child: Center(
                              child: spinkitLoader(context, ColorCodes.coral)));
// return Center(child: CircularProgressIndicator());
                    } else if (state is GetGiftedViewError) {
                      return Expanded(
                        child: Center(
                          child: customText("No data found!", Colors.black, 22,
                              FontWeight.w500, poppins),
                        ),
                      );
                    } else if (state is GetGiftedViewSuccess) {
                      return Expanded(
                        child: ListView.builder(
                            physics: const BouncingScrollPhysics(),
                            itemCount:
                                getGiftedViewCubit.viewGift?.privateData?.length,
                            itemBuilder: (context, index) {
                              final image = getGiftedViewCubit
                                  .viewGift?.privateData?[index].formdata;
                              final valuess = getGiftedViewCubit.viewGift?.privateData?[index].folderName?.length;
                              return Column(children: [
                                GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                FolderViewPage(isPrivate: true,
                                                    imageIndex: index,folderName: getGiftedViewCubit.viewGift?.privateData?[index].folderName??'',)));
                                  },
                                  child: SizedBox(
                                    height:
                                        screenHeight(context, dividedBy: 4.5),
                                    width: screenWidth(context, dividedBy: 1.1),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                            padding: EdgeInsets.only(
                                                left: screenWidth(context,
                                                    dividedBy: 50),
                                                right: screenWidth(context,
                                                    dividedBy: 50)),
                                            child: Row(
                                                children: [
                                                  valuess! >= 25 ?
                                                  Container(
                                                    width: screenWidth(context,dividedBy: 3),
                                                    child: customText(
                                                        getGiftedViewCubit
                                                            .viewGift
                                                            ?.privateData?[
                                                        index]
                                                            .folderName ??
                                                            '',
                                                        ColorCodes.greyText,
                                                        16,
                                                        FontWeight.w400,
                                                        poppins,
                                                        overflowText: true,
                                                        maxLines: 1
                                                    ),
                                                  ) :customText(
                                                      getGiftedViewCubit
                                                          .viewGift
                                                          ?.privateData?[
                                                      index]
                                                          .folderName ??
                                                          '',
                                                      ColorCodes.greyText,
                                                      16,
                                                      FontWeight.w400,
                                                      poppins,
                                                      overflowText: true,
                                                      maxLines: 1
                                                  ),
                                                  SizedBox(width: screenWidth(context,dividedBy: 50),),
                                                  InkWell(
                                                    onTap: () {
                                                      showDialog(
                                                          context: context, builder: (_) => renameDialog(getGiftedViewCubit.viewGift?.privateData?[index].id ?? '','${getGiftedViewCubit.viewGift?.privateData![index].folderName}'));
                                                    },
                                                    child: Image.asset(
                                                      ImageConstants.edit,
                                                      color: Colors.black,
                                                      height: screenHeight(context, dividedBy: 45),
                                                      width: screenHeight(context, dividedBy: 45),
                                                    ),
                                                  ),
                                                  Spacer(),
                                                  // customText(
                                                  //     getGiftedViewCubit
                                                  //             .viewGift
                                                  //             ?.privateData?[index]
                                                  //             .folderName ??
                                                  //         '',
                                                  //     ColorCodes.greyText,
                                                  //     16,
                                                  //     FontWeight.w400,
                                                  //     poppins),
                                                  // GestureDetector(
                                                  //   onTap: () {
                                                  //     showDialog(
                                                  //         context: context,
                                                  //         builder: (context) =>
                                                  //             AddPrivateDialog(
                                                  //               id: getGiftedViewCubit
                                                  //                       .viewGift
                                                  //                       ?.privateData?[
                                                  //                           index]
                                                  //                       .id ??
                                                  //                   '',
                                                  //               public: false,
                                                  //               privet: true,
                                                  //             ));
                                                  //   },
                                                  //   child: Image.asset(
                                                  //     ImageConstants.editFolder,
                                                  //     height: screenHeight(
                                                  //         context,
                                                  //         dividedBy: 40),
                                                  //     width: screenHeight(
                                                  //         context,
                                                  //         dividedBy: 40),
                                                  //   ),
                                                  // ),
                                                  GestureDetector(
                                                      onTap: () {
                                                        final id = getGiftedViewCubit.viewGift?.privateData?[index].id ?? '';
                                                        loader.add(id);
                                                        folderSettingCubit.getFolderSetting(context,
                                                            troggle: true, id: id).then((value) {
                                                          getGiftedViewCubit.getViewGift();
                                                        });
                                                        setState(() {});
                                                        // showDialog(
                                                        //     context: context,
                                                        //     builder: (context) =>
                                                        //         AddPublicDialog(
                                                        //           id: getGiftedViewCubit
                                                        //                   .viewGift
                                                        //                   ?.publicData?[
                                                        //                       index]
                                                        //                   .id ??
                                                        //               '',
                                                        //           privet: false,
                                                        //           public: true,
                                                        //         ));
                                                      },
                                                      child: BlocBuilder<FolderSettingCubit,FolderSettingState>(
                                                          builder: (context, state) {
                                                            if(state is FolderSettingLoading){
                                                              return loader.contains(getGiftedViewCubit.viewGift?.privateData?[index].id) ? spinkitLoader(context, ColorCodes.backgroundcolor) : customText("Make Public", Colors.black, 15, FontWeight.w100, poppins);
                                                            }
                                                          return customText("Make Public", Colors.black, 15, FontWeight.w100, poppins);
                                                        }
                                                      )
                                                    // Image.asset(
                                                    //   ImageConstants
                                                    //       .editFolder,
                                                    //   height: screenHeight(
                                                    //       context,
                                                    //       dividedBy: 40),
                                                    //   width: screenHeight(
                                                    //       context,
                                                    //       dividedBy: 40),
                                                    // ),
                                                  )
                                                ])),
                                        Dismissible(
                                          key: UniqueKey(),
                                          direction:
                                          DismissDirection.endToStart,
                                          confirmDismiss: (direction) {
                                            return
                                              showDialog(
                                                context: context,
                                                builder: (context) {
                                                  return SimpleDialog(
                                                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                                                    children: [
                                                      Padding(
                                                          padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 20),
                                                          child: Center(child: Text("Are you sure to delete ${getGiftedViewCubit.viewGift?.privateData?[index].folderName}"))
                                                      ),
                                                      Container(
                                                        width: 200,
                                                        height: 1,
                                                        decoration: const BoxDecoration(
                                                            color: Colors.black12,
                                                            boxShadow: [BoxShadow(color: Colors.black38, blurRadius: 5)]),
                                                      ),
                                                      Row(
                                                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                        children: [
                                                          InkWell(
                                                            onTap: () async {
                                                              setState(() {

                                                                Navigator.pop(context);
                                                              });
                                                            },
                                                            child: Container(
                                                              margin: const EdgeInsets.only(top: 5),
                                                              height: 20,
                                                              width: 100,
                                                              alignment: Alignment.center,
                                                              child: Padding(
                                                                  padding: const EdgeInsets.only(left: 8.0),
                                                                  child: customText("No", ColorCodes.greyText, 14,
                                                                      FontWeight.w400, poppins)),
                                                            ),
                                                          ),
                                                          Container(
                                                            width: screenWidth(context,dividedBy: 300),
                                                            height: screenHeight(context,dividedBy: 20),
                                                            decoration: const BoxDecoration(
                                                                color: Colors.black12,
                                                                boxShadow: [BoxShadow(color: Colors.black38, blurRadius: 5)]),
                                                          ),
                                                          InkWell(
                                                            onTap: () async {
                                                              getGiftedDeleteCubit
                                                                  .getDeleteGift(
                                                                  getGiftedViewCubit
                                                                      .viewGift
                                                                      ?.privateData?[index]
                                                                      .id ??
                                                                      '')
                                                                  .then((value) {
                                                                getGiftedViewCubit.getViewGift();
                                                                setState(() {});
                                                              });
                                                              Navigator.pop(context);

                                                            },
                                                            child: Container(
                                                                margin: const EdgeInsets.only(top: 5),
                                                                height: 20,
                                                                width: 100,
                                                                alignment: Alignment.center,
                                                                child: Padding(
                                                                    padding: const EdgeInsets.only(left: 8.0),
                                                                    child: customText("Yes", ColorCodes.greyText, 14,
                                                                        FontWeight.w400, poppins))
                                                            ),
                                                          )
                                                        ],
                                                      )
                                                    ],
                                                  );
                                                },);

                                          },
                                          // onDismissed: (direction) {
                                          //   getGiftedDeleteCubit
                                          //       .getDeleteGift(
                                          //       getGiftedViewCubit
                                          //           .viewGift
                                          //           ?.privateData?[index]
                                          //           .id ??
                                          //           '')
                                          //       .then((value) {
                                          //     getGiftedViewCubit.getViewGift();
                                          //     setState(() {});
                                          //   });
                                          //
                                          //   print("Abcd");
                                          // },
                                          background: Container(
                                            padding: EdgeInsets.only(
                                                right: screenWidth(context,
                                                    dividedBy: 10)),
                                            decoration: BoxDecoration(
                                                color: Colors.red,
                                                borderRadius:
                                                BorderRadius.circular(10),
                                                boxShadow: [
                                                  BoxShadow(
                                                    color: Colors.grey.shade300,
                                                    blurRadius: 1,
                                                  )
                                                ]),
                                            alignment: Alignment.centerRight,
                                            child: customText(
                                                "Delete",
                                                Colors.white,
                                                18,
                                                FontWeight.w700,
                                                poppins),
                                          ),
                                          child: Container(
                                              height: screenHeight(context,
                                                  dividedBy: 5.5),
                                              width: screenWidth(context,
                                                  dividedBy: 1.112),
                                              child: ClipRRect(
                                                  borderRadius:
                                                  BorderRadius.circular(10),
                                                  child: Row(
                                                    children: [
                                                      if (image?.length == 0) ...[
                                                        Expanded(
                                                          child: Container(
                                                            height: screenHeight(
                                                                context,
                                                                dividedBy: 5.5),
                                                            alignment:
                                                            Alignment.center,
                                                            decoration:
                                                            const BoxDecoration(
                                                                image:
                                                                DecorationImage(
                                                                  image: AssetImage(
                                                                    ImageConstants
                                                                        .giftBackGround,
                                                                  ),
                                                                  fit: BoxFit.fill,
                                                                )),
                                                            child: Image.asset(
                                                              ImageConstants
                                                                  .gftrLogo,
                                                              fit: BoxFit.contain,
                                                              height:
                                                              screenHeight(
                                                                  context,
                                                                  dividedBy:
                                                                  20),
                                                              width: screenWidth(
                                                                  context,
                                                                  dividedBy: 4.5),
                                                            ),
                                                          ),
                                                        ),
                                                      ] else if (image?.length ==
                                                          1) ...[
                                                        Expanded(
                                                          child:  CachedNetworkImage(
                                                            height: screenHeight(context, dividedBy: 5.5),
                                                            imageUrl: getGiftedViewCubit.viewGift?.privateData?[index].formdata![0].image ?? '',
                                                            placeholder: (context, url) => customLoader(context),
                                                            errorWidget: (context, url, error) => Center(child: Image(image: AssetImage("assets/images/No-image-available.png"),)),
                                                          ),
                                                          // Image.network(
                                                          //   getGiftedViewCubit
                                                          //       .viewGift
                                                          //       ?.privateData?[index]
                                                          //       .formdata![0]
                                                          //       .image ??
                                                          //       '',  errorBuilder: (context, object, stacktrace) {
                                                          //   debugPrint("object : ${object.toString()}");
                                                          //   debugPrint( "stacktrace : ${stacktrace.toString()}");
                                                          //   return Image(image: AssetImage("assets/images/gift.png"));
                                                          // },
                                                          //   fit: BoxFit.fill,
                                                          //   height: screenHeight(
                                                          //       context,
                                                          //       dividedBy: 5.5),
                                                          // ),
                                                        ),
                                                      ] else if (image?.length ==
                                                          2) ...[
                                                        Expanded(
                                                          child: CachedNetworkImage(
                                                            fit:  BoxFit.fill,
                                                            height: screenHeight(context, dividedBy: 5.5),
                                                            imageUrl: getGiftedViewCubit.viewGift?.privateData?[index].formdata![0].image ?? '',
                                                            placeholder: (context, url) => customLoader(context),
                                                            errorWidget: (context, url, error) => Center(child: Image(image: AssetImage("assets/images/No-image-available.png"),)),
                                                          ),
                                                          // Image.network(
                                                          //   getGiftedViewCubit
                                                          //       .viewGift
                                                          //       ?.privateData?[index]
                                                          //       .formdata![0]
                                                          //       .image ??
                                                          //       '',  errorBuilder: (context, object, stacktrace) {
                                                          //   debugPrint("object : ${object.toString()}");
                                                          //   debugPrint( "stacktrace : ${stacktrace.toString()}");
                                                          //   return Image(image: AssetImage("assets/images/gift.png"));
                                                          // },
                                                          //   fit: BoxFit.fill,
                                                          //   height: screenHeight(
                                                          //       context,
                                                          //       dividedBy: 5.5),
                                                          // ),
                                                        ),
                                                        Expanded(
                                                          child:  CachedNetworkImage(
                                                            fit:  BoxFit.fill,
                                                            height: screenHeight(context, dividedBy: 5.5),
                                                            imageUrl: getGiftedViewCubit.viewGift?.privateData?[index].formdata![1].image ?? '',
                                                            placeholder: (context, url) => customLoader(context),
                                                            errorWidget: (context, url, error) => Center(child: Image(image: AssetImage("assets/images/No-image-available.png"),)),
                                                          ),
                                                          // Image.network(
                                                          //   getGiftedViewCubit
                                                          //       .viewGift
                                                          //       ?.privateData?[index]
                                                          //       .formdata![1]
                                                          //       .image ??
                                                          //       '',  errorBuilder: (context, object, stacktrace) {
                                                          //   debugPrint("object : ${object.toString()}");
                                                          //   debugPrint( "stacktrace : ${stacktrace.toString()}");
                                                          //   return Image(image: AssetImage("assets/images/gift.png"));
                                                          // },
                                                          //   fit: BoxFit.fill,
                                                          //   height: screenHeight(
                                                          //       context,
                                                          //       dividedBy: 5.5),
                                                          // ),
                                                        ),
                                                      ] else if (image?.length ==
                                                          3) ...[
                                                        Expanded(
                                                          child:  CachedNetworkImage(
                                                            fit:  BoxFit.fill,
                                                            height: screenHeight(context, dividedBy: 5.5),
                                                            imageUrl: getGiftedViewCubit.viewGift?.privateData?[index].formdata![0].image ?? '',
                                                            placeholder: (context, url) => customLoader(context),
                                                            errorWidget: (context, url, error) => Center(child: Image(image: AssetImage("assets/images/No-image-available.png"),)),
                                                          ),
                                                          // Image.network(
                                                          //   getGiftedViewCubit
                                                          //       .viewGift
                                                          //       ?.privateData?[index]
                                                          //       .formdata![0]
                                                          //       .image ??
                                                          //       '',  errorBuilder: (context, object, stacktrace) {
                                                          //   debugPrint("object : ${object.toString()}");
                                                          //   debugPrint( "stacktrace : ${stacktrace.toString()}");
                                                          //   return Image(image: AssetImage("assets/images/gift.png"));
                                                          // },
                                                          //   fit: BoxFit.fill,
                                                          //   height: screenHeight(
                                                          //       context,
                                                          //       dividedBy: 5.5),
                                                          // ),
                                                        ),
                                                        Expanded(
                                                          child:  CachedNetworkImage(
                                                            fit:  BoxFit.fill,
                                                            height: screenHeight(context, dividedBy: 5.5),
                                                            imageUrl: getGiftedViewCubit.viewGift?.privateData?[index].formdata![1].image ?? '',
                                                            placeholder: (context, url) => customLoader(context),
                                                            errorWidget: (context, url, error) => Center(child: Image(image: AssetImage("assets/images/No-image-available.png"),)),
                                                          ),
                                                          // Image.network(
                                                          //   getGiftedViewCubit
                                                          //       .viewGift
                                                          //       ?.privateData?[index]
                                                          //       .formdata![1]
                                                          //       .image ??
                                                          //       '',  errorBuilder: (context, object, stacktrace) {
                                                          //   debugPrint("object : ${object.toString()}");
                                                          //   debugPrint( "stacktrace : ${stacktrace.toString()}");
                                                          //   return Image(image: AssetImage("assets/images/gift.png"));
                                                          // },
                                                          //   fit: BoxFit.fill,
                                                          //   height: screenHeight(
                                                          //       context,
                                                          //       dividedBy: 5.5),
                                                          // ),
                                                        ),
                                                        Expanded(
                                                          child:
                                                          CachedNetworkImage(
                                                            fit:  BoxFit.fill,
                                                            height: screenHeight(context, dividedBy: 5.5),
                                                            imageUrl: getGiftedViewCubit.viewGift?.privateData?[index].formdata![2].image ?? '',
                                                            placeholder: (context, url) => customLoader(context),
                                                            errorWidget: (context, url, error) => Center(child: Image(image: AssetImage("assets/images/No-image-available.png"),)),
                                                          ),
                                                          // Image.network(
                                                          //   getGiftedViewCubit
                                                          //       .viewGift
                                                          //       ?.privateData?[index]
                                                          //       .formdata![2]
                                                          //       .image ??
                                                          //       '',  errorBuilder: (context, object, stacktrace) {
                                                          //   debugPrint("object : ${object.toString()}");
                                                          //   debugPrint( "stacktrace : ${stacktrace.toString()}");
                                                          //   return Image(image: AssetImage("assets/images/gift.png"));
                                                          // },
                                                          //   fit: BoxFit.fill,
                                                          //   height: screenHeight(
                                                          //       context,
                                                          //       dividedBy: 5.5),
                                                          // ),
                                                        ),
                                                      ] else ...[
                                                        Expanded(
                                                          child:  CachedNetworkImage(
                                                            fit:  BoxFit.fill,
                                                            height: screenHeight(context, dividedBy: 5.5),
                                                            imageUrl: getGiftedViewCubit.viewGift?.privateData?[index].formdata![0].image ?? '',
                                                            placeholder: (context, url) => customLoader(context),
                                                            errorWidget: (context, url, error) => Center(child: Image(image: AssetImage("assets/images/No-image-available.png"),)),
                                                          ),
                                                          // Image.network(
                                                          //   getGiftedViewCubit
                                                          //       .viewGift
                                                          //       ?.privateData?[index]
                                                          //       .formdata![0]
                                                          //       .image ??
                                                          //       '',  errorBuilder: (context, object, stacktrace) {
                                                          //   debugPrint("object : ${object.toString()}");
                                                          //   debugPrint( "stacktrace : ${stacktrace.toString()}");
                                                          //   return Image(image: AssetImage("assets/images/gift.png"));
                                                          // },
                                                          //   fit: BoxFit.fill,
                                                          //   height: screenHeight(
                                                          //       context,
                                                          //       dividedBy: 5.5),
                                                          // ),
                                                        ),
                                                        Expanded(
                                                          child:  CachedNetworkImage(
                                                            fit:  BoxFit.fill,
                                                            height: screenHeight(context, dividedBy: 5.5),
                                                            imageUrl: getGiftedViewCubit.viewGift?.privateData?[index].formdata![1].image ?? '',
                                                            placeholder: (context, url) => customLoader(context),
                                                            errorWidget: (context, url, error) => Center(child: Image(image: AssetImage("assets/images/No-image-available.png"),)),
                                                          ),
                                                          // Image.network(
                                                          //   getGiftedViewCubit
                                                          //       .viewGift
                                                          //       ?.privateData?[index]
                                                          //       .formdata![1]
                                                          //       .image ??
                                                          //       '',  errorBuilder: (context, object, stacktrace) {
                                                          //   debugPrint("object : ${object.toString()}");
                                                          //   debugPrint( "stacktrace : ${stacktrace.toString()}");
                                                          //   return Image(image: AssetImage("assets/images/gift.png"));
                                                          // },
                                                          //   fit: BoxFit.fill,
                                                          //   height: screenHeight(
                                                          //       context,
                                                          //       dividedBy: 5.5),
                                                          // ),
                                                        ),
                                                        Expanded(
                                                          child:  CachedNetworkImage(
                                                            fit:  BoxFit.fill,
                                                            height: screenHeight(context, dividedBy: 5.5),
                                                            imageUrl: getGiftedViewCubit.viewGift?.privateData?[index].formdata![2].image ?? '',
                                                            placeholder: (context, url) => customLoader(context),
                                                            errorWidget: (context, url, error) => Center(child: Image(image: AssetImage("assets/images/No-image-available.png"),)),
                                                          ),
                                                          // Image.network(
                                                          //   getGiftedViewCubit
                                                          //       .viewGift
                                                          //       ?.privateData?[index]
                                                          //       .formdata![2]
                                                          //       .image ??
                                                          //       '',  errorBuilder: (context, object, stacktrace) {
                                                          //   debugPrint("object : ${object.toString()}");
                                                          //   debugPrint( "stacktrace : ${stacktrace.toString()}");
                                                          //   return Image(image: AssetImage("assets/images/gift.png"));
                                                          // },
                                                          //   fit: BoxFit.fill,
                                                          //   height: screenHeight(
                                                          //       context,
                                                          //       dividedBy: 5.5),
                                                          // ),
                                                        ),
                                                        Expanded(
                                                          child:  CachedNetworkImage(
                                                            fit:  BoxFit.fill,
                                                            height: screenHeight(context, dividedBy: 5.5),
                                                            imageUrl: getGiftedViewCubit.viewGift?.privateData?[index].formdata![3].image ?? '',
                                                            placeholder: (context, url) => customLoader(context),
                                                            errorWidget: (context, url, error) => Center(child: Image(image: AssetImage("assets/images/No-image-available.png"),)),
                                                          ),
                                                          // Image.network(
                                                          //   getGiftedViewCubit
                                                          //       .viewGift
                                                          //       ?.privateData?[index]
                                                          //       .formdata![3]
                                                          //       .image ??
                                                          //       '',  errorBuilder: (context, object, stacktrace) {
                                                          //   debugPrint("object : ${object.toString()}");
                                                          //   debugPrint( "stacktrace : ${stacktrace.toString()}");
                                                          //   return Image(image: AssetImage("assets/images/gift.png"));
                                                          // },
                                                          //   fit: BoxFit.fill,
                                                          //   height: screenHeight(
                                                          //       context,
                                                          //       dividedBy: 5.5),
                                                          // ),
                                                        ),
                                                      ]
                                                    ],
                                                  ))),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: screenHeight(context, dividedBy: 80),
                                )
                              ]);
                            }),
                      );
                    }
                    return Container();
                  },
                )
              ],
            )),
        GestureDetector(
          onTap: () {
            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        GetGiftedPublicViewPage(indexdata: 0)),(route) => false);
          },
          child: Padding(
            padding:
            EdgeInsets.only(bottom: screenHeight(context, dividedBy: 17)),
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                alignment: Alignment.center,
                height: screenHeight(context, dividedBy: 20),
                width: screenWidth(context, dividedBy: 2.8),
                decoration: BoxDecoration(
                    color: ColorCodes.coral,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey,
                        blurRadius: 5.0,
                        offset: Offset(
                          1.0,
                          2.0,
                        ),
                      )
                    ],
                    borderRadius: BorderRadius.circular(20)),
                child: customText("Public Folders", Colors.white, 14,
                    FontWeight.w300, poppins),
              ),
            ),
          ),
        )
      ],
    );
  }
}
