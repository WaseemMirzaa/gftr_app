import 'package:carousel_slider/carousel_slider.dart' as c1;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gftr/Helper/apiConstants.dart';
import 'package:gftr/Helper/appConfig.dart';
import 'package:gftr/Helper/colorConstants.dart';
import 'package:gftr/Helper/imageConstants.dart';
import 'package:gftr/View/Screens/ManageBottom/Thegiftrguids.dart';
import 'package:gftr/View/Widgets/customLoader.dart';
import 'package:gftr/View/Widgets/customText.dart';
import 'package:gftr/ViewModel/Cubits/gftrStories.dart';
import 'package:gftr/ViewModel/Cubits/setting_cubit.dart';
import 'package:gftr/ViewModel/Cubits/viewsetting.dart';

class GfterStories extends StatefulWidget {
  const GfterStories({Key? key}) : super(key: key);

  @override
  State<GfterStories> createState() => _GfterStoriesState();
}

class _GfterStoriesState extends State<GfterStories>
    with TickerProviderStateMixin {
  GftrStoriesCubit gftrStoriesCubit = GftrStoriesCubit();
  SettingCubit settingCubit = SettingCubit();
  ViewSettingCubit viewSettingCubit = ViewSettingCubit();
  TabController? tabController;
  int pageViewIndex = 0;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      gftrStoriesCubit = BlocProvider.of<GftrStoriesCubit>(context);
      settingCubit = BlocProvider.of<SettingCubit>(context);
      viewSettingCubit = BlocProvider.of<ViewSettingCubit>(context);

      gftrStoriesCubit.gftrStoriesService();
      viewSettingCubit.getviewSetting();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: screenHeight(context),
        width: screenWidth(context),
        color: Colors.black,
        child: Column(
          children: [
            Image.asset(
              ImageConstants.theGuide,
              height: screenHeight(context, dividedBy: 9),
              width: screenWidth(context, dividedBy: 1.7),
              fit: BoxFit.contain,
            ),
            SizedBox(
              height: screenHeight(context, dividedBy: 50),
            ),
            Expanded(
              child: BlocBuilder<GftrStoriesCubit, GftrStoriesState>(
                builder: (context, state) {
                  if (state is GftrStoriesLoading) {
                    return Center(
                        child: spinkitLoader(context, ColorCodes.coral));
                  } else if (state is GftrStoriesError) {
                    return Center(
                      child: customText("No data found!", Colors.white, 22,
                          FontWeight.w500, poppins),
                    );
                  } else if (state is GftrStoriesSuccess) {
                    final posts =
                        gftrStoriesCubit.gftrStories?.data?.post ?? [];

                    return Column(
                      children: [
                        if (posts.isNotEmpty)
                          Container(
                            height: screenHeight(context, dividedBy: 4),
                            width: screenWidth(context, dividedBy: 0.9),
                            decoration: const BoxDecoration(
                              color: Colors.transparent,
                            ),
                            child: c1.CarouselSlider(
                              options: c1.CarouselOptions(
                                onPageChanged: (index, re) {
                                  setState(() {
                                    pageViewIndex = index;
                                  });
                                },
                                autoPlay: true,
                                viewportFraction: 1.0,
                              ),
                              items: posts
                                  .map((item) => Column(
                                        children: [
                                          GestureDetector(
                                            onTap: () {
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      giftr_details(
                                                          pageViewIndex),
                                                ),
                                              );
                                            },
                                            child: Stack(
                                              children: [
                                                Container(
                                                  height: screenHeight(context,
                                                      dividedBy: 4.5),
                                                  width: screenWidth(context,
                                                      dividedBy: 1.1),
                                                  decoration: BoxDecoration(
                                                    color: Colors.white,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            20),
                                                  ),
                                                  child: ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            20),
                                                    child: Image.network(
                                                      "${item.image ?? ''}",
                                                      fit: BoxFit.cover,
                                                      errorBuilder: (context,
                                                          error, stackTrace) {
                                                        return Container(
                                                          color: Colors.grey,
                                                          child: Center(
                                                            child: Text(
                                                              'Image Not Available',
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .white),
                                                            ),
                                                          ),
                                                        );
                                                      },
                                                    ),
                                                  ),
                                                ),
                                                Positioned(
                                                  bottom: 10,
                                                  left: 10,
                                                  child: IntrinsicWidth(
                                                    child: Container(
                                                      height: 55,
                                                      padding:
                                                          EdgeInsets.symmetric(
                                                              horizontal: 16),
                                                      decoration: BoxDecoration(
                                                        color: Colors.black
                                                            .withOpacity(0.6),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10),
                                                      ),
                                                      alignment:
                                                          Alignment.centerLeft,
                                                      child: Text(
                                                        item.title?.isNotEmpty ==
                                                                true
                                                            ? item.title!
                                                            : 'Placeholder Title',
                                                        style: TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 14,
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          fontFamily: poppins,
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
                                          SizedBox(
                                            height: screenHeight(context,
                                                dividedBy: 50),
                                          )
                                        ],
                                      ))
                                  .toList(),
                            ),
                          ),
                        if (posts.length > 1)
                          TabPageSelector(
                            controller: TabController(
                              vsync: this,
                              length: posts.length,
                              initialIndex: pageViewIndex,
                            ),
                            color: ColorCodes.lightGrey,
                            borderStyle: BorderStyle.none,
                            indicatorSize: 7,
                            selectedColor: ColorCodes.teal,
                          ),
                        Expanded(
                          child: ListView.builder(
                            physics: BouncingScrollPhysics(),
                            itemCount: posts.length,
                            padding: EdgeInsets.zero,
                            itemBuilder: (context, index) {
                              final post = posts[index];
                              return Padding(
                                padding: EdgeInsets.symmetric(
                                  horizontal:
                                      screenWidth(context, dividedBy: 30),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: GestureDetector(
                                        onTap: () => Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                giftr_details(index),
                                          ),
                                        ),
                                        child: Container(
                                          height: 220,
                                          width: double.infinity,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(15),
                                            image: DecorationImage(
                                              image: NetworkImage(
                                                "${post.image ?? ''}",
                                              ),
                                              fit: BoxFit.cover,
                                              onError: (exception, stackTrace) {
                                                // Fallback image or error handling
                                              },
                                            ),
                                          ),
                                          child: Align(
                                            alignment: Alignment.bottomLeft,
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(12.0),
                                              child: IntrinsicWidth(
                                                child: Container(
                                                  height: 55,
                                                  decoration: BoxDecoration(
                                                    color: Colors.black
                                                        .withOpacity(0.6),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            12),
                                                  ),
                                                  alignment:
                                                      Alignment.centerLeft,
                                                  padding: const EdgeInsets
                                                          .symmetric(
                                                      horizontal: 12),
                                                  child: Text(
                                                    post.title ?? '',
                                                    style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      fontFamily: poppins,
                                                    ),
                                                    maxLines: 2,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                        )
                      ],
                    );
                  }
                  return Container();
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
