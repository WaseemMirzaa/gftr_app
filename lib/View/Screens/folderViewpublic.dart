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
import 'package:gftr/ViewModel/Cubits/editgiftnotes_cubit.dart';
import 'package:share_plus/share_plus.dart';
import 'ManageBottom/gftrStoryViewPage.dart';

class FolderPublicView extends StatefulWidget {
  final int imageIndex;
  final String folderName;

  const FolderPublicView(
      {Key? key, required this.imageIndex, required this.folderName})
      : super(key: key);

  @override
  State<FolderPublicView> createState() => _FolderPublicViewState();
}

class _FolderPublicViewState extends State<FolderPublicView> {
  FolderViewDeleteCubit folderViewDeleteCubit = FolderViewDeleteCubit();
  GetGiftedViewCubit getGiftedViewCubit = GetGiftedViewCubit();
  EditGiftNotesCubit editGiftNotesCubit = EditGiftNotesCubit();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    folderViewDeleteCubit = BlocProvider.of<FolderViewDeleteCubit>(context);
    getGiftedViewCubit = BlocProvider.of<GetGiftedViewCubit>(context);
    editGiftNotesCubit = BlocProvider.of<EditGiftNotesCubit>(context);
    getGiftedViewCubit.getViewGift();
  }

  void _showEditNotesDialog(
      String currentNotes, String formDataId, String folderId) {
    TextEditingController notesController =
        TextEditingController(text: currentNotes);

    showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          title: Text('Edit Notes'),
          content: TextField(
            controller: notesController,
            decoration: InputDecoration(
              hintText: 'Enter your notes...',
              border: OutlineInputBorder(),
            ),
            maxLines: 3,
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(dialogContext).pop(),
              child: Text('Cancel'),
            ),
            BlocConsumer<EditGiftNotesCubit, EditGiftNotesState>(
              bloc: editGiftNotesCubit,
              listener: (context, state) {
                if (state is EditGiftNotesSuccess) {
                  Navigator.of(dialogContext).pop();
                  // Refresh the data - BlocBuilder will automatically rebuild the UI
                  getGiftedViewCubit.getViewGift();
                } else if (state is EditGiftNotesError) {
                  // Error toast is already shown in the cubit
                }
              },
              builder: (context, state) {
                return TextButton(
                  onPressed: state is EditGiftNotesLoading
                      ? null
                      : () {
                          editGiftNotesCubit.editGiftNotes(
                            folderId: folderId,
                            formDataId: formDataId,
                            notes: notesController.text,
                          );
                        },
                  child: state is EditGiftNotesLoading
                      ? SizedBox(
                          width: 20,
                          height: 20,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        )
                      : Text('Save'),
                );
              },
            ),
          ],
        );
      },
    );
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
            BlocBuilder<GetGiftedViewCubit, GetGiftedViewState>(
              bloc: getGiftedViewCubit,
              builder: (context, state) {
                if (state is GetGiftedViewLoading) {
                  return Expanded(
                    child: Center(
                      child: spinkitLoader(context, ColorCodes.coral),
                    ),
                  );
                } else if (state is GetGiftedViewError) {
                  return Expanded(
                    child: Center(
                      child: customText("Error loading gifts", Colors.black, 16,
                          FontWeight.w300, poppins),
                    ),
                  );
                } else if (state is GetGiftedViewSuccess &&
                    getGiftedViewCubit.viewGift != null &&
                    getGiftedViewCubit.viewGift!.publicData != null &&
                    widget.imageIndex <
                        getGiftedViewCubit.viewGift!.publicData!.length &&
                    getGiftedViewCubit.viewGift!.publicData![widget.imageIndex]
                            .formdata !=
                        null &&
                    getGiftedViewCubit.viewGift!.publicData![widget.imageIndex]
                        .formdata!.isNotEmpty) {
                  return Expanded(
                    child: ListView.builder(
                        itemCount: getGiftedViewCubit.viewGift
                            ?.publicData?[widget.imageIndex].formdata?.length,
                        padding: EdgeInsets.only(
                            top: screenHeight(context, dividedBy: 100)),
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () {},
                            child: Column(children: [
                              Dismissible(
                                  key: UniqueKey(),
                                  direction: DismissDirection.endToStart,
                                  onDismissed: (direction) {
                                    folderViewDeleteCubit
                                        .folderViewDeleteGift(
                                          folderViewId: getGiftedViewCubit
                                                  .viewGift
                                                  ?.publicData?[
                                                      widget.imageIndex]
                                                  .formdata?[index]
                                                  .id ??
                                              '',
                                          giftfolderId: getGiftedViewCubit
                                                  .viewGift
                                                  ?.publicData?[
                                                      widget.imageIndex]
                                                  .id ??
                                              '',
                                        )
                                        .then((value) =>
                                            getGiftedViewCubit.getViewGift());
                                    print("Abcd");
                                  },
                                  background: Container(
                                    padding: EdgeInsets.only(
                                        right: screenWidth(context,
                                            dividedBy: 10)),
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
                                    child: customText("Delete", Colors.white,
                                        18, FontWeight.w700, poppins),
                                  ),
                                  child: Container(
                                      height:
                                          screenHeight(context, dividedBy: 8),
                                      width:
                                          screenWidth(context, dividedBy: 1.1),
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(10),
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
                                                    ?.publicData?[
                                                        widget.imageIndex]
                                                    .formdata?[index]
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
                                                child: CachedNetworkImage(
                                                  fit: BoxFit.fill,
                                                  height: 80,
                                                  width: 180,
                                                  imageUrl: getGiftedViewCubit
                                                          .viewGift
                                                          ?.publicData?[
                                                              widget.imageIndex]
                                                          .formdata?[index]
                                                          .image ??
                                                      '',
                                                  placeholder: (context, url) =>
                                                      spinkitLoader(context,
                                                          ColorCodes.coral),
                                                  errorWidget:
                                                      (context, url, error) =>
                                                          Center(
                                                              child: Image(
                                                    image: AssetImage(
                                                        "assets/images/No-image-available.png"),
                                                  )),
                                                ),
                                              )),
                                        ),
                                        SizedBox(
                                          width: screenWidth(context,
                                              dividedBy: 30),
                                        ),
                                        Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              SizedBox(
                                                height: screenHeight(context,
                                                    dividedBy: 25),
                                                width: screenWidth(context,
                                                    dividedBy: 1.8),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    SizedBox(
                                                      width: screenWidth(
                                                          context,
                                                          dividedBy: 2),
                                                      child: customText(
                                                          getGiftedViewCubit
                                                                  .viewGift
                                                                  ?.publicData?[
                                                                      widget
                                                                          .imageIndex]
                                                                  .formdata?[
                                                                      index]
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
                                                        await Share.share(
                                                            getGiftedViewCubit
                                                                    .viewGift
                                                                    ?.publicData?[
                                                                        widget
                                                                            .imageIndex]
                                                                    .formdata?[
                                                                        index]
                                                                    .webViewLink ??
                                                                '');
                                                        setState(() {});
                                                      },
                                                      child: Image.asset(
                                                          height: screenHeight(
                                                              context,
                                                              dividedBy: 50),
                                                          width: screenHeight(
                                                              context,
                                                              dividedBy: 50),
                                                          ImageConstants.share),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Container(
                                                height: screenHeight(context,
                                                    dividedBy: 30),
                                                width: screenWidth(context,
                                                    dividedBy: 1.8),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    customText(
                                                        "\$${getGiftedViewCubit.viewGift?.publicData?[widget.imageIndex].formdata?[index].price ?? ""}",
                                                        ColorCodes.greyText,
                                                        12,
                                                        FontWeight.w400,
                                                        poppins),
                                                    Icon(
                                                      Icons.star,
                                                      size: 17,
                                                      color: getGiftedViewCubit
                                                                  .viewGift
                                                                  ?.publicData?[
                                                                      widget
                                                                          .imageIndex]
                                                                  .formdata?[
                                                                      index]
                                                                  .starredGift ==
                                                              true
                                                          ? ColorCodes.coral
                                                          : Colors.white,
                                                    )
                                                  ],
                                                ),
                                              ),
                                              GestureDetector(
                                                onTap: () {
                                                  String folderId =
                                                      getGiftedViewCubit
                                                              .viewGift
                                                              ?.publicData?[widget
                                                                  .imageIndex]
                                                              .id ??
                                                          '';
                                                  String formDataId =
                                                      getGiftedViewCubit
                                                              .viewGift
                                                              ?.publicData?[widget
                                                                  .imageIndex]
                                                              .formdata?[index]
                                                              .id ??
                                                          '';
                                                  String currentNotes =
                                                      getGiftedViewCubit
                                                              .viewGift
                                                              ?.publicData?[widget
                                                                  .imageIndex]
                                                              .formdata?[index]
                                                              .notes ??
                                                          '';

                                                  _showEditNotesDialog(
                                                      currentNotes,
                                                      formDataId,
                                                      folderId);
                                                },
                                                child: Container(
                                                  height: screenHeight(context,
                                                      dividedBy: 30),
                                                  width: screenWidth(context,
                                                      dividedBy: 1.8),
                                                  padding: EdgeInsets.only(
                                                      left: screenWidth(context,
                                                          dividedBy: 60)),
                                                  alignment:
                                                      Alignment.centerLeft,
                                                  decoration: BoxDecoration(
                                                      color: Colors.white,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              5),
                                                      border: Border.all(
                                                          width: 1.2,
                                                          color: ColorCodes
                                                              .greyButton)),
                                                  child: Row(
                                                    children: [
                                                      Expanded(
                                                        child: customText(
                                                            "Notes: ${getGiftedViewCubit.viewGift?.publicData?[widget.imageIndex].formdata?[index].notes ?? ""}",
                                                            Colors.black,
                                                            10,
                                                            FontWeight.w100,
                                                            poppins),
                                                      ),
                                                      Icon(
                                                        Icons.edit,
                                                        size: 16,
                                                        color: ColorCodes
                                                            .greyButton,
                                                      ),
                                                      SizedBox(width: 8),
                                                    ],
                                                  ),
                                                ),
                                              )
                                            ])
                                      ]))),
                              SizedBox(
                                height: screenHeight(context, dividedBy: 50),
                              )
                            ]),
                          );
                        }),
                  );
                } else {
                  return Expanded(
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
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => GooglePage(),
                                  ));
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
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => GfterStoryViewPage(),
                                  ));
                              bottombarblack = true;
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
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
