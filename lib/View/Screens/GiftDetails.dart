import 'dart:developer';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_html/flutter_html.dart';

import 'package:gftr/Helper/appConfig.dart';
import 'package:gftr/Helper/colorConstants.dart';
import 'package:gftr/View/Widgets/customLoader.dart';
import 'package:gftr/View/Widgets/customText.dart';
import 'package:gftr/ViewModel/Cubits/gftrStories.dart';
import 'package:http/http.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../Helper/html_converter.dart';

class Gift_Ditails extends StatefulWidget {
  final int cur;
  const Gift_Ditails(this.cur, {Key? key}) : super(key: key);

  @override
  State<Gift_Ditails> createState() => _Gift_DitailsState();
}

class _Gift_DitailsState extends State<Gift_Ditails> {
  late GftrStoriesCubit gftrStoriesCubit;
  PageController? controller;
  int curpage = 0;

  @override
  void initState() {
    super.initState();
    gftrStoriesCubit = BlocProvider.of<GftrStoriesCubit>(context);
    gftrStoriesCubit.gftrStoriesService();
    curpage = widget.cur;
    controller = PageController(initialPage: curpage);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
        setState(() {});
      },
      child: SafeArea(
        child: Scaffold(
          body: Column(
            children: [
              Container(
                height: screenHeight(context, dividedBy: 15),
                child: Padding(
                  padding: EdgeInsets.only(
                      left: screenWidth(context, dividedBy: 40)),
                  child: Row(
                    children: [
                      GestureDetector(
                        onTap: () => Navigator.pop(context),
                        child:
                            const Icon(Icons.arrow_back_ios_outlined, size: 20),
                      ),
                      SizedBox(width: screenWidth(context, dividedBy: 3)),
                      customText(
                          'Article', Colors.black, 25, FontWeight.bold, poppins)
                    ],
                  ),
                ),
              ),
              Expanded(
                child: BlocBuilder<GftrStoriesCubit, GftrStoriesState>(
                  builder: (context, state) {
                    if (state is GftrStoriesLoading) {
                      return Center(
                        child: spinkitLoader(context, ColorCodes.coral),
                      );
                    } else if (state is GftrStoriesError) {
                      return const Text("No data Found");
                    } else if (state is GftrStoriesSuccess) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        child: PageView.builder(
                          controller: controller,
                          itemCount:
                              gftrStoriesCubit.gftrStories?.data?.post?.length,
                          itemBuilder: (context, index) {
                            final content = gftrStoriesCubit
                                .gftrStories?.data?.post?[index].content;
                            final title = gftrStoriesCubit
                                .gftrStories?.data?.post?[index].title;
                            final title1 = gftrStoriesCubit
                                .gftrStories?.data?.post?[index].title;
                            final image = gftrStoriesCubit
                                .gftrStories?.data?.post?[index].image;
                            final blogItemArray = gftrStoriesCubit
                                .gftrStories?.data?.post?[index].blogItemArray;
                            final type = gftrStoriesCubit
                                .gftrStories?.data?.post?[index].blogType;

                            if (type == 'normal') {
                              return SingleChildScrollView(
                                child: Padding(
                                  padding: const EdgeInsets.all(20.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      HTMLContentView(content: content ?? ""),
                                      if (blogItemArray != null)
                                        ...blogItemArray.map((blogItem) {
                                          return Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              if (blogItem.image != null)
                                                Container(
                                                  width: double.infinity,
                                                  height: 400,
                                                  margin: const EdgeInsets.only(
                                                      bottom: 20),
                                                  decoration: BoxDecoration(
                                                    image: DecorationImage(
                                                      image: NetworkImage(
                                                          blogItem.image!),
                                                      fit: BoxFit.cover,
                                                    ),
                                                  ),
                                                ),
                                              if (blogItem.title != null ||
                                                  blogItem.content != null)
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          bottom: 20),
                                                  child: RichText(
                                                    text: TextSpan(
                                                      style: const TextStyle(
                                                          fontSize: 16,
                                                          color:
                                                              Colors.black54),
                                                      children: [
                                                        if (blogItem.title !=
                                                            null)
                                                          TextSpan(
                                                            text:
                                                                "${blogItem.title!}, ",
                                                            style:
                                                                const TextStyle(
                                                              fontSize: 15,
                                                              fontFamily:
                                                                  'Times New Roman',
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              color:
                                                                  Colors.black,
                                                            ),
                                                          ),
                                                        if (blogItem.content !=
                                                            null)
                                                          TextSpan(
                                                              text: blogItem
                                                                  .content!,
                                                              style: TextStyle(
                                                                fontSize: 14,
                                                                fontFamily:
                                                                    'Times New Roman',
                                                              )),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              if (blogItem.price != null)
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          bottom: 10),
                                                  child: Text(
                                                    '\$${blogItem.price!} at ...',
                                                    style: const TextStyle(
                                                      fontSize: 15,
                                                      fontFamily:
                                                          'Times New Roman',
                                                      color: Colors.blue,
                                                    ),
                                                  ),
                                                ),
                                              Align(
                                                alignment:
                                                    Alignment.centerRight,
                                                child: ElevatedButton(
                                                  onPressed: () {
                                                    // Add your button action here
                                                    log("ADD TO GFTR button pressed");
                                                  },
                                                  style:
                                                      ElevatedButton.styleFrom(
                                                    backgroundColor: Colors
                                                        .black, // Button background color
                                                    foregroundColor: Colors
                                                        .white, // Text color
                                                    padding: const EdgeInsets
                                                        .symmetric(
                                                      horizontal:
                                                          10, // Reduced horizontal padding
                                                      vertical:
                                                          8, // Reduced vertical padding
                                                    ),
                                                    textStyle: const TextStyle(
                                                      fontSize:
                                                          12, // Reduced font size
                                                      fontFamily:
                                                          'Times New Roman',
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                    shape:
                                                        RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              8), // Button border radius
                                                    ),
                                                  ),
                                                  child:
                                                      const Text('ADD TO GFTR'),
                                                ),
                                              ),
                                              const SizedBox(height: 10),
                                            ],
                                          );
                                        }).toList(),
                                    ],
                                  ),
                                ),
                              );
                            } else if (type == 'magazine') {
                              return SingleChildScrollView(
                                child: Padding(
                                  padding: const EdgeInsets.all(20.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text('$title',
                                          style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold)),
                                      HTMLContentView(content: content ?? ""),
                                      if (blogItemArray != null)
                                        ...blogItemArray.map((blogItem) {
                                          return Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              if (blogItem.image != null)
                                                Container(
                                                  width: double.infinity,
                                                  height: 400,
                                                  margin: const EdgeInsets.only(
                                                      bottom: 20),
                                                  decoration: BoxDecoration(
                                                    image: DecorationImage(
                                                      image: NetworkImage(
                                                          blogItem.image!),
                                                      fit: BoxFit.cover,
                                                    ),
                                                  ),
                                                ),
                                              if (blogItem.title != null ||
                                                  blogItem.content != null)
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          bottom: 20),
                                                  child: RichText(
                                                    text: TextSpan(
                                                      style: const TextStyle(
                                                          fontSize: 14,
                                                          fontFamily:
                                                              'Times New Roman',
                                                          color:
                                                              Colors.black54),
                                                      children: [
                                                        if (blogItem.title !=
                                                            null)
                                                          TextSpan(
                                                            text:
                                                                "${blogItem.title!}, ",
                                                            style:
                                                                const TextStyle(
                                                              fontSize: 14,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              color:
                                                                  Colors.black,
                                                            ),
                                                          ),
                                                        if (blogItem.content !=
                                                            null)
                                                          TextSpan(
                                                              text: blogItem
                                                                  .content!),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              const SizedBox(height: 10),
                                            ],
                                          );
                                        }).toList(),
                                    ],
                                  ),
                                ),
                              );
                            } else {
                              return const SizedBox();
                            }
                          },
                        ),
                      );
                    }
                    return const SizedBox();
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class WebViewScreen extends StatelessWidget {
  final String url;

  const WebViewScreen({Key? key, required this.url}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: WebView(
        initialUrl: url,
        javascriptMode: JavascriptMode.unrestricted,
      ),
    );
  }
}
