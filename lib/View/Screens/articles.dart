import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gftr/Helper/apiConstants.dart';
import 'package:gftr/Helper/appConfig.dart';
import 'package:gftr/Helper/colorConstants.dart';
import 'package:gftr/Helper/imageConstants.dart';
import 'package:gftr/View/Screens/ManageBottom/Thegiftrguids.dart';
import 'package:gftr/View/Screens/ManageBottom/gftrStoryViewPage.dart';
import 'package:gftr/View/Screens/google.dart';
import 'package:gftr/View/Widgets/customLoader.dart';
import 'package:gftr/View/Widgets/customText.dart';
import 'package:gftr/ViewModel/Cubits/All_Giftss.dart';
import 'package:gftr/ViewModel/Cubits/gftrStories.dart';
import 'package:html/parser.dart' as htmlParser;

class ArticlesPage extends StatefulWidget {
  const ArticlesPage({Key? key}) : super(key: key);

  @override
  State<ArticlesPage> createState() => _ArticlesPageState();
}

class _ArticlesPageState extends State<ArticlesPage> {
  List<BoxShadow> shadow = [
    const BoxShadow(color: Colors.grey, offset: Offset(0.0, 1.0), blurRadius: 3)
  ];
  TextEditingController search = TextEditingController();
  List resultSearch = [];
  GftrStoriesCubit gftrStoriesCubit = GftrStoriesCubit();
  final ScrollController _secondController = ScrollController();
  Fetch_All_GiftsCubit fetch_all_giftsCubit = Fetch_All_GiftsCubit();
  @override
  void initState() {
    super.initState();
    fetch_all_giftsCubit = BlocProvider.of<Fetch_All_GiftsCubit>(context);
    gftrStoriesCubit = BlocProvider.of<GftrStoriesCubit>(context);
    gftrStoriesCubit.gftrStoriesService();
    fetch_all_giftsCubit.Fetch_All_GiftsService();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
        isIcon = true;
        setState(() {});
      },
      child: Scaffold(
          body: SingleChildScrollView(
        child: SizedBox(
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
              SizedBox(
                height: screenHeight(context, dividedBy: 90),
              ),
              Container(
                  // height: screenHeight(context, dividedBy: 20),
                  margin: EdgeInsets.only(
                      left: screenWidth(context, dividedBy: 30)),
                  width: screenWidth(context, dividedBy: 1.1),
                  decoration: BoxDecoration(
                      boxShadow: shadow,
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10)),
                  alignment: Alignment.center,
                  child: TextField(
                    onTap: () {
                      isIcon = false;
                      setState(() {});
                    },
                    onSubmitted: (val) {
                      isIcon = true;
                      setState(() {});
                    },
                    controller: search,
                    onChanged: (val) {
                      if (val.isEmpty) {
                        resultSearch = [];
                      } else {
                        // Get matching articles
                        var matchingArticles = gftrStoriesCubit
                                .gftrStories?.data?.post
                                ?.where((article) =>
                                    article.title
                                        ?.toLowerCase()
                                        .contains(val.toLowerCase()) ??
                                    false)
                                .toList() ??
                            [];

                        // Store the full article objects, not just titles
                        resultSearch = matchingArticles;
                      }
                      setState(() {});
                    },
                    decoration: InputDecoration(
                      hintText: "Search Gftr",
                      hintStyle: TextStyle(fontFamily: poppins),
                      border: InputBorder.none,
                      prefixIcon: Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Image.asset(
                          ImageConstants.search,
                          height: 4,
                          width: 4,
                          color: ColorCodes.greyButton,
                        ),
                      ),
                    ),
                  )),
              SizedBox(
                height: screenHeight(context, dividedBy: 50),
              ),
              Padding(
                padding:
                    EdgeInsets.only(left: screenWidth(context, dividedBy: 30)),
                child: SizedBox(
                    width: screenWidth(context, dividedBy: 1),
                    child: customText("Articles", Colors.black, 20,
                        FontWeight.w300, madeOuterSans)),
              ),
              SizedBox(
                height: screenHeight(context, dividedBy: 60),
              ),
              if (search.text.isNotEmpty)
                if (resultSearch.isNotEmpty)
                  Expanded(
                      child: ListView.builder(
                          itemCount: resultSearch.length,
                          itemBuilder: (context, index) => Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal:
                                        screenWidth(context, dividedBy: 30)),
                                child: GestureDetector(
                                    onTap: () {
                                      Navigator.push(context, MaterialPageRoute(
                                        builder: (context) {
                                          return giftr_details(index);
                                        },
                                      ));
                                    },
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          height: 0.3,
                                          color: Colors.black,
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Container(
                                            height: screenHeight(context,
                                                dividedBy: 5),
                                            width: double.infinity,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(15),
                                              image: DecorationImage(
                                                image: NetworkImage(
                                                  "${resultSearch[index].image}",
                                                ),
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                            child: Stack(
                                              children: [
                                                Align(
                                                  alignment:
                                                      Alignment.bottomLeft,
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            12.0),
                                                    child: Container(
                                                      padding: const EdgeInsets
                                                          .symmetric(
                                                          horizontal: 12,
                                                          vertical: 8),
                                                      decoration: BoxDecoration(
                                                        color: Colors.black
                                                            .withOpacity(0.6),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(8),
                                                      ),
                                                      child: Text(
                                                        resultSearch[index]
                                                                .title ??
                                                            "",
                                                        style: TextStyle(
                                                          fontSize: 14,
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          color: Colors.white,
                                                          shadows: [
                                                            Shadow(
                                                              color: Colors
                                                                  .black
                                                                  .withOpacity(
                                                                      0.6),
                                                              offset:
                                                                  Offset(2, 2),
                                                              blurRadius: 4,
                                                            ),
                                                          ],
                                                        ),
                                                        maxLines: 2,
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        Container(
                                          height: 0.3,
                                          color: Colors.black,
                                        ),
                                      ],
                                    )),
                              )))
                else
                  Expanded(
                    child: Center(
                      child: customText("No results found!", Colors.black, 16,
                          FontWeight.w300, poppins),
                    ),
                  )
              else
                Column(
                  children: [
                    BlocBuilder<GftrStoriesCubit, GftrStoriesState>(
                        builder: (context, state) {
                      if (state is GftrStoriesLoading) {
                        return spinkitLoader(context, ColorCodes.coral);
                      } else if (state is GftrStoriesError) {
                        return customText("Not Data Found!", Colors.black, 16,
                            FontWeight.w300, poppins);
                      } else if (state is GftrStoriesSuccess) {
                        return Container(
                          height: screenHeight(context, dividedBy: 3),
                          child: Scrollbar(
                            thickness: 8,
                            radius: Radius.circular(16),
                            //--------------------------------CLOSED BY ME------------------------------------------------
                            // isAlwaysShown: true,
                            thumbVisibility: true,
                            //--------------------------------CLOSED BY ME------------------------------------------------
                            controller: _secondController,
                            child: ListView.builder(
                              controller: _secondController,
                              itemCount: gftrStoriesCubit
                                  .gftrStories?.data?.post?.length,
                              itemBuilder: (context, index) => Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal:
                                        screenWidth(context, dividedBy: 30)),
                                child: GestureDetector(
                                    onTap: () {
                                      Navigator.push(context, MaterialPageRoute(
                                        builder: (context) {
                                          return giftr_details(index);
                                        },
                                      ));
                                    },
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          height: 0.3, // Divider height
                                          color: Colors.black,
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Container(
                                            height: screenHeight(context,
                                                dividedBy:
                                                    5), // Height of the image container
                                            width:
                                                double.infinity, // Full width
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(15),
                                              image: DecorationImage(
                                                image: NetworkImage(
                                                  "${gftrStoriesCubit.gftrStories?.data?.post?[index].image}",
                                                ),
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                            child: Stack(
                                              children: [
                                                Align(
                                                  alignment:
                                                      Alignment.bottomLeft,
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            12.0),
                                                    child: Container(
                                                      padding: const EdgeInsets
                                                          .symmetric(
                                                          horizontal: 12,
                                                          vertical: 8),
                                                      decoration: BoxDecoration(
                                                        color: Colors.black
                                                            .withOpacity(0.6),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(8),
                                                      ),
                                                      child: Text(
                                                        gftrStoriesCubit
                                                                .gftrStories
                                                                ?.data
                                                                ?.post?[index]
                                                                .title ??
                                                            "",
                                                        style: TextStyle(
                                                          fontSize: 14,
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          color: Colors.white,
                                                          shadows: [
                                                            Shadow(
                                                              color: Colors
                                                                  .black
                                                                  .withOpacity(
                                                                      0.6),
                                                              offset:
                                                                  Offset(2, 2),
                                                              blurRadius: 4,
                                                            ),
                                                          ],
                                                        ),
                                                        maxLines: 2,
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        Container(
                                          height: 0.3, // Divider height
                                          color: Colors.black,
                                        ),
                                      ],
                                    )),
                              ),
                            ),
                          ),
                        );
                      }
                      return Container();
                    }),
                  ],
                ),
              SizedBox(
                height: screenHeight(context, dividedBy: 300),
              ),
              Container(
                width: screenWidth(context),
                height: screenHeight(context, dividedBy: 20),
                child: Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                          left: screenWidth(context, dividedBy: 25)),
                      child: Text(
                        "Saved by a ",
                        style: TextStyle(
                            fontSize: 20,
                            color: Colors.black,
                            fontWeight: FontWeight.w300,
                            fontFamily: madeOuterSans),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          top: screenWidth(context, dividedBy: 100)),
                      child: Image.asset(
                        ImageConstants.gftrBlack,
                        width: screenWidth(context, dividedBy: 11),
                        height: screenHeight(context, dividedBy: 12),
                      ),
                    ),
                  ],
                ),
              ),
              BlocBuilder<Fetch_All_GiftsCubit, Fetch_All_GiftsState>(
                builder: (context, state) {
                  print("NoGroupsCubit $state");
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
                    return SizedBox(
                        height: screenHeight(context, dividedBy: 6),
                        width: screenWidth(context, dividedBy: 1),
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount:
                              fetch_all_giftsCubit.allgifts?.data?.length,
                          itemBuilder: (BuildContext context, int index) {
                            return Padding(
                              padding: EdgeInsets.only(
                                  left: screenHeight(context, dividedBy: 50)),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      defauilUrl = fetch_all_giftsCubit.allgifts
                                              ?.data?[index].webViewLink ??
                                          '';
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  GooglePage()));
                                    },
                                    child: CachedNetworkImage(
                                      fit: BoxFit.fitHeight,
                                      imageUrl: fetch_all_giftsCubit
                                              .allgifts?.data?[index].image ??
                                          '',
                                      imageBuilder: (context, imageProvider) {
                                        return Container(
                                          height: screenHeight(context,
                                              dividedBy: 9),
                                          width: screenWidth(context,
                                              dividedBy: 3.5),
                                          decoration: BoxDecoration(
                                              image: DecorationImage(
                                                  image: imageProvider,
                                                  fit: BoxFit.fill),
                                              borderRadius:
                                                  BorderRadius.circular(15)),
                                        );
                                      },
                                      placeholder: (context, url) =>
                                          spinkitLoader(
                                              context, ColorCodes.coral),
                                      errorWidget: (context, url, error) =>
                                          Image(
                                        image: AssetImage(
                                            "assets/images/gift.png"),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: screenWidth(context, dividedBy: 3.7),
                                    child: AutoSizeText(
                                      "${fetch_all_giftsCubit.allgifts?.data?[index].title ?? ''}, \$${fetch_all_giftsCubit.allgifts?.data?[index].price ?? ''}",
                                      maxLines: 2,
                                      style: TextStyle(
                                        overflow: TextOverflow.ellipsis,
                                        color: Colors.black38,
                                        fontSize: 12,
                                        fontFamily: poppins,
                                        fontWeight: FontWeight.w100,
                                      ),
                                    ),
                                    //customText("${noGroupsCubit.noGroupData!.data![index].title},\$${noGroupsCubit.noGroupData!.data![index].price}", Colors.black, 10, FontWeight.w200, poppins,maxLines: 2,overflowText: true)
                                    // Text(
                                    //     "${noGroupsCubit.noGroupData!.data![index].title},\$${noGroupsCubit.noGroupData!.data![index].price}",
                                    //     style: TextStyle(
                                    //       color: Colors.black,
                                    //       fontSize: 10,
                                    //       fontWeight:
                                    //       FontWeight.w100,
                                    //       fontFamily: poppins,
                                    //     )),
                                  )
                                ],
                              ),
                            );
                          },
                        ));
                  }
                  return SizedBox();
                },
              )
            ])),
      )),
    );
  }
}
