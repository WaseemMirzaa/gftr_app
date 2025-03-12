import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gftr/Helper/appConfig.dart';
import 'package:gftr/Helper/colorConstants.dart';
import 'package:gftr/View/Widgets/customLoader.dart';
import 'package:gftr/View/Widgets/customText.dart';
import 'package:gftr/ViewModel/Cubits/GetGifted/getGiftedDelete_dart.dart';
import 'package:gftr/ViewModel/Cubits/GetGifted/getgifted_rename.dart';
import 'package:gftr/ViewModel/Cubits/GetGifted/getgiftedview_dart.dart';
import 'package:gftr/ViewModel/Cubits/folderSetting.dart';
import 'package:gradient_borders/box_borders/gradient_box_border.dart';

class AddPublicDialog extends StatefulWidget {
  String id;
  bool public,privet;
  AddPublicDialog({required this.id,required this.public,required this.privet});

  @override
  State<AddPublicDialog> createState() => _AddPublicDialogState();
}

class _AddPublicDialogState extends State<AddPublicDialog> {
  TextEditingController reName = TextEditingController();
  bool isPrivate = false;
  bool isPublic = false;
  GetGiftedDeleteCubit getGiftedDeleteCubit = GetGiftedDeleteCubit();
  GetGiftedViewCubit getGiftedViewCubit = GetGiftedViewCubit();
  FolderRenameCubit folderRenameCubit = FolderRenameCubit();
  FolderSettingCubit folderSettingCubit = FolderSettingCubit();
  renameDialog() {
    return SimpleDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      children: [
        Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: TextField(
              onSubmitted: (value) {
                folderRenameCubit
                    .getFolderRename(context,
                        folderName: reName.text, id: widget.id)
                    .then((value) {
                  Navigator.pop(context);
                  Navigator.pop(context);
                  getGiftedViewCubit.getViewGift();
                });
              },
              textInputAction: TextInputAction.done,
              controller: reName,
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
                        folderName: reName.text, id: widget.id)
                    .then((value) {
                  Navigator.pop(context);
                  Navigator.pop(context);
                  getGiftedViewCubit.getViewGift();
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
    getGiftedDeleteCubit = BlocProvider.of<GetGiftedDeleteCubit>(context);
    getGiftedViewCubit = BlocProvider.of<GetGiftedViewCubit>(context);
    folderSettingCubit = BlocProvider.of<FolderSettingCubit>(context);
    isPrivate = widget.privet;
    isPublic = widget.public;
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      actionsAlignment: MainAxisAlignment.start,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      actions: [
        Container(
          height: screenHeight(context, dividedBy: 6),
          width: screenWidth(context, dividedBy: 1.1),
          padding: EdgeInsets.only(left: screenHeight(context, dividedBy: 50)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  //  const SizedBox(width: 10),

                  Container(
                    height: screenHeight(context, dividedBy: 40),
                    width: screenHeight(context, dividedBy: 40),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        border: const GradientBoxBorder(
                            width: 1.5,
                            gradient: LinearGradient(colors: [
                              ColorCodes.coral,
                              ColorCodes.teal,
                            ]))),
                    child: Checkbox(
                      fillColor: MaterialStateProperty.all(Colors.transparent),
                      value: isPublic,
                      checkColor: Colors.black45,
                      onChanged: (value) {
                        if(isPublic == true){
                          folderSettingCubit.getFolderSetting(context,
                              troggle: isPublic, id: widget.id).then((value) {
                            isPublic = !isPublic;
                            Navigator.pop(context);
                            getGiftedViewCubit.getViewGift();
                            setState(() {});
                          });
                        }
                        print("isPrivate :$isPrivate");
                        // log(isPrivate.toString());
                      },
                    ),
                  ),
                  Padding(
                      padding: EdgeInsets.only(
                          left: screenWidth(context, dividedBy: 70)),
                      child: customText("Public", Colors.black, 14,
                          FontWeight.w400, poppins)),
                  Container(
                    margin: EdgeInsets.only(left: screenWidth(context, dividedBy: 40)),
                    height: screenHeight(context, dividedBy: 40),
                    width: screenHeight(context, dividedBy: 40),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        border: const GradientBoxBorder(
                            width: 1.5,
                            gradient: LinearGradient(colors: [
                              ColorCodes.coral,
                              ColorCodes.teal,
                            ]))),
                    child: Checkbox(
                      fillColor: MaterialStateProperty.all(Colors.transparent),
                      value: isPrivate,
                      checkColor: Colors.black45,
                      onChanged: (value) {
                          folderSettingCubit.getFolderSetting(context,
                              troggle: isPrivate, id: widget.id).then((value) {
                            isPrivate = !isPrivate;
                            Navigator.pop(context);
                            getGiftedViewCubit.getViewGift();
                          });
                        setState(() {});
                      },
                    ),
                  ),
                  Padding(
                      padding: EdgeInsets.only(
                          left: screenWidth(context, dividedBy: 70)),
                      child: customText("Private", Colors.black, 14,
                          FontWeight.w400, poppins)),
                  // GestureDetector(
                  //   onTap: isPrivate == true
                  //       ? () {
                  //     isPrivate=false; log(isPrivate.toString());
                  //     folderSettingCubit.getFolderSetting(context,
                  //         troggle: isPrivate, id: widget.id).then((value) {
                  //       Navigator.pop(context);
                  //       getGiftedViewCubit.getViewGift();
                  //     });
                  //         }
                  //       : null,
                  //   child: Container(
                  //     margin: EdgeInsets.only(
                  //         left: screenWidth(context, dividedBy: 4.5)),
                  //     alignment: Alignment.center,
                  //     height: screenWidth(context, dividedBy: 18),
                  //     width: screenHeight(context, dividedBy: 12),
                  //     decoration: BoxDecoration(
                  //         color: isPrivate == true
                  //             ? ColorCodes.coral
                  //             : ColorCodes.coral.withOpacity(0.5),
                  //         borderRadius: BorderRadius.circular(20)),
                  //     child: customText(
                  //         "Save", Colors.white, 12, FontWeight.w300, poppins),
                  //   ),
                  // )
                ],
              ),
              const Divider(),
              GestureDetector(
                  onTap: () {
                    getGiftedDeleteCubit.getDeleteGift(widget.id).then((value) {
                      Navigator.pop(context);
                      getGiftedViewCubit.getViewGift();
                    });
                    setState(() {

                    });
                  },
                  child: Container(
                      alignment: Alignment.centerLeft,
                      child: BlocBuilder<GetGiftedDeleteCubit,
                          GetGiftedDeleteState>(builder: (context, state) {
                        if (state is GetGiftedDeleteLoading) {
                          return spinkitLoader(context, ColorCodes.greyButton);
                        }
                        return customText("Delete", Colors.black, 14,
                            FontWeight.w400, poppins);
                      }))),
              const Divider(),
              InkWell(
                  onTap: () {
                    showDialog(
                        context: context, builder: (_) => renameDialog());
                  },
                  child: customText(
                      "Rename", Colors.black, 14, FontWeight.w400, poppins))
            ],
          ),
        ),
      ],
    );
  }
}
