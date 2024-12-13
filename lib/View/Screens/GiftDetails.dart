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
          body: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: screenHeight(context, dividedBy: 15),
                  child: Padding(
                    padding: EdgeInsets.only(
                      left: screenWidth(context, dividedBy: 40),
                    ),
                    child: Row(
                      children: [
                        GestureDetector(
                          onTap: () => Navigator.pop(context),
                          child: const Icon(Icons.arrow_back_ios_outlined,
                              size: 20),
                        ),
                        SizedBox(
                          width: screenWidth(context, dividedBy: 3),
                        ),
                        customText('Article', Colors.black, 25, FontWeight.bold,
                            poppins)
                      ],
                    ),
                  ),
                ),
                BlocBuilder<GftrStoriesCubit, GftrStoriesState>(
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
                        child: Container(
                          // Apply a height constraint here
                          height:
                              screenHeight(context) * 0.7, // Adjust as needed
                          width: screenWidth(context, dividedBy: 1.1),
                          child: PageView.builder(
                            controller: controller,
                            itemCount: gftrStoriesCubit
                                .gftrStories?.data?.post?.length,
                            itemBuilder: (context, index) {
                              final content = gftrStoriesCubit
                                  .gftrStories?.data?.post?[index].content;

                              return HTMLContentView(content: content ?? "");
                            },
                          ),
                        ),
                      );
                    }
                    return const SizedBox();
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// class HTMLContentView extends StatelessWidget {
//   final String content;

//   const HTMLContentView({Key? key, required this.content}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return SingleChildScrollView(
//       child: Container(
//         color: Colors.white,
//         padding: const EdgeInsets.all(16.0),
//         child: Html(
//           data: content,
//           style: {
//             'body': Style(
//               fontSize: FontSize(16),
//               fontFamily: 'Roboto',
//               lineHeight: LineHeight.number(1.6),
//             ),
//             // 'img': Style(
//             //   width: Width.auto(), // Use full width
//             //   height: Height.auto(),
//             //   alignment: Alignment.center,
//             // ),
//             'a': Style(
//               color: Colors.blue,
//               textDecoration: TextDecoration.underline,
//             ),
//           },
//           onLinkTap: (url, _, __) async {
//             if (url != null) {
//               // You can navigate to a new screen with WebView
//               Navigator.push(
//                 context,
//                 MaterialPageRoute(
//                   builder: (context) => WebViewScreen(url: url),
//                 ),
//               );
//             }
//           },

//           // // Add this to improve image loading
//           // customImageRenders: {
//           //   networkSourceMatcher(): networkImageRender(
//           //     headers: {}, // Add any necessary headers
//           //     altWidget: (alt) => Text(alt ?? 'Image not found'),
//           //   ),
//           // },
//         ),
//       ),
//     );
//   }
// }

class WebViewScreen extends StatelessWidget {
  final String url;

  const WebViewScreen({Key? key, required this.url}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: WebView(
        initialUrl: url,
        javascriptMode: JavascriptMode.unrestricted, // Enable JS if needed
      ),
    );
  }
}
