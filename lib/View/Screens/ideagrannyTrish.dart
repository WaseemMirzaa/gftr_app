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
import 'package:gftr/View/Widgets/expandableNotesWidget.dart';
import 'package:gftr/ViewModel/Cubits/All_Giftss.dart';
import 'package:gftr/ViewModel/Cubits/editgiftnotes_cubit.dart';
import 'package:share_plus/share_plus.dart';

import '../../Helper/imageConstants.dart';
import '../../ViewModel/Cubits/folderview_cubit.dart';
import '../../ViewModel/Cubits/groupscubit.dart';
import 'google.dart';

class IdeaGrannyTrish extends StatefulWidget {
  final String name;
  final String groupId;
  // final List<Myidea>? PublicData;

  const IdeaGrannyTrish({
    Key? key,
    required this.name,
    required this.groupId,
    // required this.PublicData
  }) : super(key: key);

  @override
  State<IdeaGrannyTrish> createState() => _IdeaGrannyTrishState();
}

class _IdeaGrannyTrishState extends State<IdeaGrannyTrish> {
  late FolderViewDeleteCubit folderViewDeleteCubit;
  late GroupViewCubit groupViewCubit;
  EditGiftNotesCubit editGiftNotesCubit = EditGiftNotesCubit();

  // Get the specific group's gift ideas based on groupId
  List<Myidea> get currentGroupGiftIdeas {
    if (groupViewCubit.groups?.groupDetails != null) {
      for (var group in groupViewCubit.groups!.groupDetails!) {
        if (group.id == widget.groupId) {
          return group.myideas;
        }
      }
    }
    return [];
  }

  @override
  void initState() {
    super.initState();
    folderViewDeleteCubit = BlocProvider.of<FolderViewDeleteCubit>(context);
    groupViewCubit = BlocProvider.of<GroupViewCubit>(context);

    // Fetch fresh data when screen loads
    groupViewCubit.getGroups();
  }

  // Add BlocListener for handling delete states
  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<FolderViewDeleteCubit, FolderViewDeleteState>(
          listener: (context, state) {
            if (state is FolderViewDeleteSuccess) {
              ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Item deleted successfully')));
              // Refresh data after successful delete
              groupViewCubit.getGroups();
            } else if (state is FolderViewDeleteError) {
              ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Failed to delete item')));
            }
          },
        ),
        BlocListener<EditGiftNotesCubit, EditGiftNotesState>(
          bloc: editGiftNotesCubit,
          listener: (context, state) {
            if (state is EditGiftNotesSuccess) {
              // Refresh data after successful note update
              groupViewCubit.getGroups();
            }
          },
        ),
      ],
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
              // Use BlocBuilder to fetch and display data from GroupViewCubit
              Expanded(
                child: BlocBuilder<GroupViewCubit, GroupViewState>(
                  bloc: groupViewCubit,
                  builder: (context, state) {
                    if (state is GroupViewLoading) {
                      return Center(
                        child: spinkitLoader(context, ColorCodes.coral),
                      );
                    } else if (state is GroupViewError) {
                      return Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            customText("Failed to load data!", Colors.black, 15,
                                FontWeight.w500, poppins),
                            SizedBox(height: 20),
                            ElevatedButton(
                              onPressed: () => groupViewCubit.getGroups(),
                              child: Text('Retry'),
                            ),
                          ],
                        ),
                      );
                    } else if (state is GroupViewSuccess) {
                      final giftIdeas = currentGroupGiftIdeas;

                      if (giftIdeas.isEmpty) {
                        return Center(
                          child: customText("No ideas found!", Colors.black, 15,
                              FontWeight.w500, poppins),
                        );
                      }

                      return RefreshIndicator(
                        onRefresh: () async {
                          groupViewCubit.getGroups();
                        },
                        child: ListView.builder(
                            itemCount: giftIdeas.length,
                            physics: BouncingScrollPhysics(),
                            padding: EdgeInsets.only(
                                left: screenWidth(context, dividedBy: 30),
                                right: screenWidth(context, dividedBy: 30),
                                bottom: screenWidth(context, dividedBy: 6)),
                            itemBuilder: (context, index) {
                              final giftIdea = giftIdeas[index];
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
                                    // Delete functionality using cubit
                                    folderViewDeleteCubit.folderViewDeleteGift(
                                      folderViewId: giftIdea.id,
                                      giftfolderId: giftIdea.id,
                                    );
                                  },
                                  child: GestureDetector(
                                      onTap: () {},
                                      child: Container(
                                        margin: EdgeInsets.only(
                                            bottom: screenWidth(context,
                                                dividedBy: 50)),
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                        child: Container(
                                            height: screenHeight(context,
                                                dividedBy: 7),
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
                                                InkWell(
                                                  onTap: () {
                                                    defauilUrl =
                                                        giftIdea.webViewLink;
                                                    Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                            builder: (context) =>
                                                                GooglePage()));
                                                    setState(() {});
                                                  },
                                                  child: CachedNetworkImage(
                                                    height: 80,
                                                    width: 130,
                                                    imageUrl: giftIdea.image,
                                                    imageBuilder: (context,
                                                        imageProvider) {
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
                                                                    .circular(
                                                                        10),
                                                            image: DecorationImage(
                                                                image:
                                                                    imageProvider,
                                                                fit: BoxFit
                                                                    .fill)),
                                                      );
                                                    },
                                                    placeholder: (context,
                                                            url) =>
                                                        customLoader(context),
                                                    errorWidget:
                                                        (context, url, error) =>
                                                            Image(
                                                      image: AssetImage(
                                                          "assets/images/gift.png"),
                                                      fit: BoxFit.fill,
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: screenWidth(context,
                                                      dividedBy: 49),
                                                ),
                                                Expanded(
                                                  child: Padding(
                                                    padding:
                                                        EdgeInsets.all(8.0),
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Row(
                                                          children: [
                                                            Expanded(
                                                              child: SizedBox(
                                                                width:
                                                                    screenWidth(
                                                                        context,
                                                                        dividedBy:
                                                                            2),
                                                                child:
                                                                    AutoSizeText(
                                                                  giftIdea
                                                                      .title,
                                                                  maxLines: 1,
                                                                  style:
                                                                      TextStyle(
                                                                    overflow:
                                                                        TextOverflow
                                                                            .ellipsis,
                                                                    color: Colors
                                                                        .black,
                                                                    fontSize:
                                                                        14,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w500,
                                                                    fontFamily:
                                                                        poppins,
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                            SizedBox(
                                                              width: 10,
                                                            ),
                                                            GestureDetector(
                                                              onTap: () async {
                                                                await Share.share(
                                                                    giftIdea
                                                                        .webViewLink,
                                                                    subject:
                                                                        giftIdea
                                                                            .title);
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
                                                                  "\$${giftIdea.price}",
                                                                  Colors
                                                                      .black26,
                                                                  10,
                                                                  FontWeight
                                                                      .w100,
                                                                  poppins),
                                                              Icon(
                                                                Icons.star,
                                                                size: 17,
                                                                color: giftIdea
                                                                        .starredGift
                                                                    ? ColorCodes
                                                                        .coral
                                                                    : Colors
                                                                        .white,
                                                              ),
                                                              SizedBox(
                                                                  width: 8),
                                                            ],
                                                          ),
                                                        ),
                                                        Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            ExpandableNotesWidget(
                                                              notes: giftIdea
                                                                  .notes,
                                                              onEdit: () {
                                                                String
                                                                    folderId =
                                                                    giftIdea.id;
                                                                String
                                                                    currentNotes =
                                                                    giftIdea
                                                                        .notes;

                                                                _showEditNotesDialog(
                                                                    currentNotes,
                                                                    giftIdea
                                                                        .giftFolderId,
                                                                    folderId);
                                                              },
                                                            ),
                                                          ],
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                )
                                              ],
                                            )),
                                      )));
                            }),
                      );
                    }

                    return Center(
                      child: customText("Loading...", Colors.black, 15,
                          FontWeight.w500, poppins),
                    );
                  },
                ),
              )
            ])),
      ),
    );
  }

  void _showEditNotesDialog(
      String currentNotes, String folderId, String giftIdeaId) {
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
                  // Data refresh is handled by the BlocListener in the main build method
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Notes updated successfully!'),
                      backgroundColor: Colors.green,
                    ),
                  );
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
                              folderId:
                                  folderId, // Use the group ID from widget
                              formDataId: giftIdeaId,
                              // This is the gift idea ID
                              notes: notesController.text,
                              isForIdeas: true);
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
}
