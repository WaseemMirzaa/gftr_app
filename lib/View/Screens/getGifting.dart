import 'dart:async';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gftr/Helper/apiConstants.dart';
import 'package:gftr/Helper/appConfig.dart';
import 'package:gftr/Helper/colorConstants.dart';
import 'package:gftr/View/Screens/ManageBottom/gfteNetworkPage.dart';
import 'package:gftr/View/Screens/ManageBottom/granyytrisPageView.dart';
import 'package:gftr/View/Widgets/customButton.dart';
import 'package:gftr/View/Widgets/customLoader.dart';
import 'package:gftr/View/Widgets/customText.dart';
import 'package:gftr/ViewModel/Cubits/Delete_frds.dart';
import 'package:gftr/ViewModel/Cubits/builGroup.dart';
import 'package:gftr/ViewModel/Cubits/groupscubit.dart';
import 'package:timezone/data/latest.dart' as tz;

class GetGiftingPage extends StatefulWidget {
  const GetGiftingPage({Key? key}) : super(key: key);

  @override
  State<GetGiftingPage> createState() => _GetGiftingState();
}

class _GetGiftingState extends State<GetGiftingPage> {
  GroupViewCubit groupViewCubit = GroupViewCubit();
  BuildGroupCubit buildGroupCubit =BuildGroupCubit();
  DeleteFriendsCubit deleteFriendsCubit =DeleteFriendsCubit();
  bool _group=true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    groupViewCubit = BlocProvider.of<GroupViewCubit>(context);
    deleteFriendsCubit = BlocProvider.of<DeleteFriendsCubit>(context);
    groupViewCubit.getGroups();
    groupViewCubit.uniqueArray;
   tz.initializeTimeZones();
  }
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    groupViewCubit.uniqueArray.clear();
  }
  @override
  Widget build(BuildContext context) {
    return _group == true ?SizedBox(
        height: screenHeight(context),
        width: screenWidth(context),
        child: Column(
          children: [
            SizedBox(
              height: screenHeight(context, dividedBy: 50),
            ),
            Container(
              alignment: Alignment.centerLeft,
              height: screenHeight(context, dividedBy: 20),
              padding: EdgeInsets.symmetric(
                  horizontal: screenWidth(context, dividedBy: 30)),
              child: customText("Get Gifting", Colors.black, 20, FontWeight.w300, madeOuterSans),
            ),
            Expanded(
              child: BlocBuilder<GroupViewCubit, GroupViewState>(builder: (context, state) {
                log("GroupViewCubit $state");
                if (state is GroupViewLoading) {
                  return Center(
                    child: spinkitLoader(context, ColorCodes.coral),
                  );
                } else if (state is GroupViewError) {
                  return Center(
                    child: customText("Not Data Found!", Colors.black, 15,
                        FontWeight.w500, poppins),
                  );
                } else if (state is GroupViewSuccess) {
                  return Stack(
                    alignment: Alignment.bottomCenter,
                    children: [
                      groupViewCubit.groups!.groupDetails!.isNotEmpty
                          ? GridView.builder(
                              physics: const BouncingScrollPhysics(),
                              itemCount:
                                  groupViewCubit.groups?.groupDetails?.length,
                              padding: EdgeInsets.only(
                                  left: screenWidth(context, dividedBy: 30),
                                  right: screenWidth(context, dividedBy: 30),
                                  bottom: screenWidth(context, dividedBy: 6)),
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 2,
                                      crossAxisSpacing:
                                          screenWidth(context, dividedBy: 30),
                                      mainAxisSpacing: 5.0,
                                      childAspectRatio: 0.9),
                              itemBuilder: (context, index) {
                                return GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              GrannyTrishViePage(
                                                  groupName: groupViewCubit
                                                          .groups
                                                          ?.groupDetails?[index]
                                                          .name ??
                                                      '',
                                                  gifts: groupViewCubit
                                                          .groups
                                                          ?.groupDetails?[index]
                                                          .publicDatas ??
                                                      [],
                                                PublicData:groupViewCubit
                                                    .groups
                                                    ?.groupDetails?[index]
                                                    .myideas ?? [],
                                                Adress: "${groupViewCubit.groups?.groupDetails?[index].address.street?? ''}, ${groupViewCubit.groups?.groupDetails?[index].address.unit?? ''}, ${groupViewCubit.groups?.groupDetails?[index].address.city?? ''}, ${groupViewCubit.groups?.groupDetails?[index].address.state?? ''}, ${groupViewCubit.groups?.groupDetails?[index].address.zipcore?? ''}, ${groupViewCubit.groups?.groupDetails?[index].address.country?? ''}",
                                              ),
                                        ));
                                  },
                                  child: Container(
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: [
                                            Container(
                                              height: screenHeight(context,
                                                  dividedBy: 5.8),
                                              width: screenWidth(context),
                                              padding: EdgeInsets.all(
                                                  groupViewCubit
                                                              .groups
                                                              ?.groupDetails?[
                                                                  index]
                                                              .birthdayIsIn !=
                                                          '0'
                                                      ? 2
                                                      : 0),
                                              decoration: BoxDecoration(
                                                  color: ColorCodes.coral,
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                  gradient:
                                                      const LinearGradient(
                                                          colors: [
                                                        ColorCodes.teal,
                                                        ColorCodes.coral
                                                      ],
                                                          begin: Alignment
                                                              .centerLeft,
                                                          end: Alignment
                                                              .centerRight)),
                                              child: Column(
                                                children: [
                                                  Stack(
                                                    children: [
                                                      SizedBox(
                                                        height: screenHeight(
                                                            context,
                                                            dividedBy: groupViewCubit
                                                                        .groups
                                                                        ?.groupDetails?[
                                                                            index]
                                                                        .birthdayIsIn !=
                                                                    '0'
                                                                ? 7.6
                                                                : 5.8),
                                                        width: screenWidth(
                                                            context),
                                                        child: ClipRRect(
                                                            borderRadius: groupViewCubit
                                                                        .groups
                                                                        ?.groupDetails?[
                                                                            index]
                                                                        .birthdayIsIn !=
                                                                    '0'
                                                                ? const BorderRadius
                                                                        .only(
                                                                    topRight: Radius
                                                                        .circular(
                                                                            10),
                                                                    topLeft: Radius
                                                                        .circular(
                                                                            10))
                                                                : BorderRadius
                                                                    .circular(
                                                                        10),
                                                            child: Image.network(
                                                              "${ApiConstants.baseUrlsSocket}${groupViewCubit.groups!.groupDetails?[index].avatar}",
                                                              fit: BoxFit.cover,
                                                            )),
                                                      ),
                                                      Positioned(
                                                        top: 0.0,
                                                        right: 0.0,
                                                        child: IconButton(
                                                          splashColor: Colors.transparent,
                                                            onPressed: () {
                                                              setState(() {
                                                                showDialog(
                                                                  context: context,
                                                                  builder: (context) {
                                                                    return SimpleDialog(
                                                                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                                                                      children: [
                                                                        Padding(
                                                                            padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 20),
                                                                            child: Center(child: Text("Are you sure for delete ${groupViewCubit.groups!.groupDetails?[index].name}"))
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
                                                                                _group= false;
                                                                                  print("hyyy:${groupViewCubit.groups?.groupDetails?[index].phoneNumber.toString()}");
                                                                                  deleteFriendsCubit.Delete_frdss(context, Numbers: "${groupViewCubit.groups?.groupDetails?[index].phoneNumber.toString()}",c_id:"${groupViewCubit.groups?.groupDetails?[index].id}" );
                                                                                    groupViewCubit.uniqueArray.clear();
                                                                                   Navigator.pop(context);
                                                                                    setState(() {
                                                                                      groupViewCubit.getGroups();
                                                                                    });
                                                                                    _group=true;
                                                                                    setState(() {});
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
                                                              });
                                                        }, icon: Icon(Icons.cancel,color: Colors.black,size: 20,)),
                                                      )
                                                    ],
                                                  ),
                                                  groupViewCubit
                                                              .groups
                                                              ?.groupDetails?[
                                                                  index]
                                                              .birthdayIsIn !=
                                                          '0'
                                                      ? SizedBox(
                                                          height: screenHeight(
                                                              context,
                                                              dividedBy: 160),
                                                        )
                                                      : Container(),
                                                  groupViewCubit
                                                              .groups
                                                              ?.groupDetails?[
                                                                  index]
                                                              .birthdayIsIn !=
                                                          '0'
                                                      ? Padding(
                                                          padding: EdgeInsets.symmetric(
                                                              horizontal:
                                                                  screenWidth(
                                                                      context,
                                                                      dividedBy:
                                                                          50)),
                                                          child: Text(
                                                            "Birthday is in ${groupViewCubit.groups?.groupDetails?[index].birthdayIsIn ?? ''} days!",
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .white,
                                                                fontFamily:
                                                                    poppins,
                                                                fontSize: 11,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500),
                                                          ),
                                                        )
                                                      : Container()
                                                ],
                                              ),
                                            ),
                                            Column(children: [
                                              customText(
                                                  groupViewCubit
                                                          .groups
                                                          ?.groupDetails?[index]
                                                          .name ??
                                                      '',
                                                  Colors.black,
                                                  14,
                                                  FontWeight.w500,
                                                  poppins),
                                              customText(
                                                  "${groupViewCubit.groups?.groupDetails?[index].birthday?.day.toString().padLeft(2, '0')}/${groupViewCubit.groups?.groupDetails?[index].birthday?.month.toString().padLeft(2, '0')}/${groupViewCubit.groups?.groupDetails?[index].birthday?.year}",
                                                  Colors.black,
                                                  12,
                                                  FontWeight.w400,
                                                  poppins)
                                            ])
                                          ])),
                                );
                              })
                          : Center(
                              child: customText("Build Your Gftr Group!", Colors.black, 15,
                                  FontWeight.w500, poppins),
                            ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) =>GfterNetworkViewPage(),));
                        },
                        child: Padding(
                          padding: EdgeInsets.only(
                              bottom: screenWidth(context, dividedBy: 8.8)),
                          child: customButton(
                              context,
                              screenWidth(context, dividedBy: 3.8),
                              "Add a Gftr"),
                        ),
                      )
                    ],
                  );
                }
                return Container(
                  color: Colors.green,
                );
              }),
            ),
          ],
        )):Center(child: customLoader(context)) ;
  }
}
