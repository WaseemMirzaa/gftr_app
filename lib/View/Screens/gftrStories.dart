import 'package:carousel_slider/carousel_slider.dart';
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
    setState(() {});
    gftrStoriesCubit = BlocProvider.of<GftrStoriesCubit>(context);
    gftrStoriesCubit.gftrStoriesService();
    settingCubit = BlocProvider.of<SettingCubit>(context);
    viewSettingCubit = BlocProvider.of<ViewSettingCubit>(context);
    viewSettingCubit.getviewSetting();
  }

  int indexdata = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            height: screenHeight(context),
            width: screenWidth(context),
            color: Colors.black,
            child: Column(children: [
              Image.asset(
                ImageConstants.theGuide,
                height: screenHeight(context, dividedBy: 9),
                width: screenWidth(context, dividedBy: 1.7),
                fit: BoxFit.contain,
              ),
              SizedBox(
                height: screenHeight(context, dividedBy: 50),
              ),
              BlocBuilder<GftrStoriesCubit, GftrStoriesState>(
                  builder: (context, state) {
                if (state is GftrStoriesLoading) {
                  return Expanded(
                      child: Center(
                          child: spinkitLoader(context, ColorCodes.coral)));
                } else if (state is GftrStoriesError) {
                  return Expanded(
                    child: Center(
                      child: customText("No data found!", Colors.white, 22,
                          FontWeight.w500, poppins),
                    ),
                  );
                } else if (state is GftrStoriesSuccess) {
                  return Expanded(
                    child: Column(
                      children: [
                        Container(
                            height: screenHeight(context, dividedBy: 4),
                            width: screenWidth(context, dividedBy: 0.9),
                            decoration: const BoxDecoration(
                              color: Colors.transparent,
                            ),
                            child: CarouselSlider(
                              options: CarouselOptions(
                                  onPageChanged: (index, re) {
                                    pageViewIndex = index;
                                    setState(() {});
                                  },
                                  autoPlay: true,
                                  viewportFraction: 1.0),
                              items: gftrStoriesCubit.gftrStories?.data?.post
                                  ?.map((item) => Column(children: [
                                        GestureDetector(
                                          onTap: () {
                                            Navigator.push(context,
                                                MaterialPageRoute(
                                              builder: (context) {
                                                return giftr_details(
                                                    pageViewIndex);
                                              },
                                            ));
                                          },
                                          child: Stack(children: [
                                            Container(
                                              height: screenHeight(context,
                                                  dividedBy: 4.5),
                                              width: screenWidth(context,
                                                  dividedBy: 1.1),
                                              decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          20)),
                                              child: ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(20),
                                                  child: Image.network(
                                                    "${ApiConstants.baseUrls}${item.image}",
                                                    fit: BoxFit.cover,
                                                  )),
                                            ),
                                            Container(
                                              height: screenHeight(context,
                                                  dividedBy: 4.5),
                                              width: screenWidth(context,
                                                  dividedBy: 1.6),
                                              padding: EdgeInsets.all(
                                                  screenWidth(context,
                                                      dividedBy: 30)),
                                              alignment: Alignment.bottomLeft,
                                              decoration: BoxDecoration(
                                                  color: Colors.transparent,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          20)),
                                              child: customText(
                                                  item.title!,
                                                  Colors.white,
                                                  14,
                                                  FontWeight.w500,
                                                  poppins,
                                                  maxLines: 2),
                                            )
                                          ]),
                                        ),
                                        SizedBox(
                                          height: screenHeight(context,
                                              dividedBy: 50),
                                        )
                                      ]))
                                  .toList(),
                            )),
                        gftrStoriesCubit.gftrStories!.data!.post!.length == 1 ||
                                gftrStoriesCubit
                                        .gftrStories!.data!.post!.length ==
                                    0
                            ? SizedBox()
                            : TabPageSelector(
                                controller: TabController(
                                    vsync: this,
                                    length: gftrStoriesCubit
                                        .gftrStories!.data!.post!.length,
                                    initialIndex: pageViewIndex),
                                color: ColorCodes.lightGrey,
                                borderStyle: BorderStyle.none,
                                indicatorSize: 7,
                                selectedColor: ColorCodes.teal,
                              ),
                        SizedBox(height: screenHeight(context, dividedBy: 90)),

                        ///---------------------------------The Giftr Stories---------------------------------
                        Expanded(
                          child: ListView.builder(
                            physics: BouncingScrollPhysics(),
                            itemCount: gftrStoriesCubit
                                    .gftrStories?.data?.post?.length ??
                                0,
                            padding: EdgeInsets.zero,
                            itemBuilder: (context, index) {
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
                                            builder: (context) {
                                              return giftr_details(index);
                                            },
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
                                                "${ApiConstants.baseUrls}${gftrStoriesCubit.gftrStories?.data?.post?[index].image}",
                                              ),
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                          child: Align(
                                            alignment: Alignment.bottomLeft,
                                            child: Padding(
                                                padding:
                                                    const EdgeInsets.all(12.0),
                                                child: customText(
                                                    gftrStoriesCubit
                                                            .gftrStories
                                                            ?.data
                                                            ?.post?[index]
                                                            .title ??
                                                        "",
                                                    Colors.white,
                                                    14,
                                                    FontWeight.w500,
                                                    poppins,
                                                    maxLines: 2)),
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

                        //---------------------------------The Giftr Stories---------------------------------
                      ],
                    ),
                  );
                }
                return Container();
              })
            ])));
  }
}
