import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:html/dom.dart' as dom;

import 'dart:async';
import 'package:webview_flutter/webview_flutter.dart';

import 'package:metadata_extract/metadata_extract.dart';
import 'package:gftr/Helper/appConfig.dart';
import 'package:gftr/Helper/colorConstants.dart';
import 'package:gftr/Helper/imageConstants.dart';
import 'package:gftr/View/Screens/addTo.dart';
import 'package:gftr/View/Widgets/customText.dart';
import 'package:gftr/View/Widgets/customLoader.dart';
import 'package:gftr/ViewModel/Cubits/gftrStories.dart';

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
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          onTap: () => Navigator.pop(context),
                          child: const Icon(Icons.arrow_back_ios_outlined,
                              size: 20),
                        ),
                        customText(
                          gftrStoriesCubit
                                  .gftrStories?.data?.post?[curpage].title ??
                              'Article',
                          Colors.black,
                          25,
                          FontWeight.bold,
                          poppins,
                        ),
                        Opacity(
                          opacity: 0.0,
                          child: Icon(Icons.more_vert),
                        ),
                      ],
                    )),
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
                      return PageView.builder(
                        controller: controller,
                        itemCount:
                            gftrStoriesCubit.gftrStories?.data?.post?.length,
                        itemBuilder: (context, index) {
                          final content = gftrStoriesCubit
                              .gftrStories?.data?.post?[index].content;
                          final title1 = gftrStoriesCubit
                              .gftrStories?.data?.post?[index].title1;
                          final blogItemArray = gftrStoriesCubit
                              .gftrStories?.data?.post?[index].blogItemArray;
                          final type = gftrStoriesCubit
                              .gftrStories?.data?.post?[index].blogType;

                          if (type == 'normal') {
                            return SingleChildScrollView(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(12.0),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          title1!,
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16,
                                            fontFamily: poppins,
                                          ),
                                        ),
                                        HTMLContentView(content: content ?? ""),
                                      ],
                                    ),
                                  ),
                                  if (blogItemArray != null)
                                    ...blogItemArray.map((blogItem) {
                                      return Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          if (blogItem.image != null)
                                            Padding(
                                              padding: EdgeInsets.all(20.0),
                                              child: Container(
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
                                            ),
                                          if (blogItem.title != null ||
                                              blogItem.content != null)
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  right: 10.0, left: 10.0),
                                              child: RichText(
                                                text: TextSpan(
                                                  style: const TextStyle(
                                                      fontSize: 16,
                                                      color: Colors.black54),
                                                  children: [
                                                    if (blogItem.title != null)
                                                      TextSpan(
                                                        text:
                                                            "${blogItem.title!}, ",
                                                        style: const TextStyle(
                                                          fontSize: 15,
                                                          fontFamily: 'Poppins',
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: Colors.black,
                                                        ),
                                                      ),
                                                    if (blogItem.content !=
                                                        null)
                                                      TextSpan(
                                                          text:
                                                              blogItem.content!,
                                                          style: TextStyle(
                                                              fontSize: 12,
                                                              fontFamily:
                                                                  'Poppins',
                                                              fontWeight:
                                                                  FontWeight
                                                                      .normal)),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              if (blogItem.price != null)
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          top: 10,
                                                          right: 10,
                                                          left: 10,
                                                          bottom: 10),
                                                  child: RichText(
                                                    text: TextSpan(
                                                      style: const TextStyle(
                                                        fontSize: 15,
                                                        fontFamily: 'Poppins',
                                                        color: Colors.black,
                                                      ),
                                                      children: [
                                                        TextSpan(
                                                          text:
                                                              '\$${blogItem.price ?? 'N/A'} at ',
                                                        ),
                                                        TextSpan(
                                                          text: blogItem
                                                                  .platform ??
                                                              'Unknown',
                                                          style:
                                                              const TextStyle(
                                                            color: Colors
                                                                .blue, // Makes it look like a link
                                                            decoration:
                                                                TextDecoration
                                                                    .underline,
                                                          ),
                                                          recognizer:
                                                              TapGestureRecognizer()
                                                                ..onTap = () {
                                                                  if (blogItem.platformlink !=
                                                                          null &&
                                                                      blogItem
                                                                          .platformlink!
                                                                          .isNotEmpty) {
                                                                    Navigator
                                                                        .push(
                                                                      context,
                                                                      MaterialPageRoute(
                                                                        builder:
                                                                            (context) =>
                                                                                WebViewScreen(url: blogItem.platformlink!),
                                                                      ),
                                                                    );
                                                                  } else {
                                                                    ScaffoldMessenger.of(
                                                                            context)
                                                                        .showSnackBar(
                                                                      const SnackBar(
                                                                          content:
                                                                              Text("Platform URL not available")),
                                                                    );
                                                                  }
                                                                },
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              Align(
                                                alignment:
                                                    Alignment.centerRight,
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          right: 15.0),
                                                  child: ElevatedButton(
                                                    onPressed: () async {
                                                      if (blogItem.platformlink !=
                                                              null &&
                                                          blogItem.platformlink!
                                                              .isNotEmpty) {
                                                        // Start loading state (optional)
                                                        ScaffoldMessenger.of(
                                                                context)
                                                            .showSnackBar(
                                                          const SnackBar(
                                                              content: Text(
                                                                  "Fetching product details...")),
                                                        );

                                                        try {
                                                          final response =
                                                              await http.get(Uri
                                                                  .parse(blogItem
                                                                      .platformlink!));
                                                          var document =
                                                              responseToDocument(
                                                                  response);
                                                          var metadata =
                                                              MetadataParser
                                                                  .parse(
                                                                      document);

                                                          // Extract Title (limit length)
                                                          String title =
                                                              metadata.title ??
                                                                  "Untitled";
                                                          if (title.length >
                                                              25) {
                                                            title =
                                                                title.substring(
                                                                    0, 25);
                                                          }

                                                          // Use the current blogItem's image as the main image
                                                          String mainImage =
                                                              blogItem.image ??
                                                                  '';

                                                          // Add the current image to the filtered images list if it exists
                                                          List<String>
                                                              filteredImages =
                                                              [];
                                                          if (mainImage
                                                              .isNotEmpty) {
                                                            filteredImages
                                                                .add(mainImage);
                                                          }

                                                          // Add additional images from the webpage
                                                          dom.Document html =
                                                              dom.Document.html(
                                                                  response
                                                                      .body);
                                                          List<
                                                                  String>
                                                              webImages = html
                                                                  .querySelectorAll(
                                                                      'img')
                                                                  .map((e) {
                                                                    // Get both src and data-src attributes
                                                                    String?
                                                                        src =
                                                                        e.attributes[
                                                                            'src'];
                                                                    String?
                                                                        dataSrc =
                                                                        e.attributes[
                                                                            'data-src'];
                                                                    String?
                                                                        srcset =
                                                                        e.attributes[
                                                                            'srcset'];

                                                                    // Return the first non-null value
                                                                    return src ??
                                                                        dataSrc ??
                                                                        srcset ??
                                                                        '';
                                                                  })
                                                                  .where((src) =>
                                                                      src
                                                                          .isNotEmpty)
                                                                  .where((src) =>
                                                                      src.startsWith(
                                                                          'http://') ||
                                                                      src.startsWith(
                                                                          'https://') ||
                                                                      src.startsWith(
                                                                          '//'))
                                                                  .map((src) {
                                                                    // Convert protocol-relative URLs to https
                                                                    if (src.startsWith(
                                                                        '//')) {
                                                                      return 'https:$src';
                                                                    }
                                                                    return src;
                                                                  })
                                                                  .where((img) => !img.contains(RegExp(
                                                                      r"gif|sticker|banner|adroll|logo|icons|resources|marketing|svg|transparent",
                                                                      caseSensitive:
                                                                          false)))
                                                                  .toList();

                                                          // Remove duplicate images
                                                          webImages = webImages
                                                              .toSet()
                                                              .toList();

                                                          // Add images to filtered list
                                                          filteredImages.addAll(
                                                              webImages);

                                                          // Modified navigation to use push instead of pushReplacement
                                                          Navigator.push(
                                                            context,
                                                            MaterialPageRoute(
                                                              builder:
                                                                  (context) =>
                                                                      AddTo(
                                                                imageUrl:
                                                                    mainImage,
                                                                webViewLink:
                                                                    blogItem
                                                                        .platformlink!,
                                                                sharedText: '',
                                                                title: title,
                                                                imagesList:
                                                                    filteredImages,
                                                                isBack: true,
                                                                price:
                                                                    ' ${blogItem.price}',
                                                              ),
                                                            ),
                                                          );
                                                        } catch (e) {
                                                          print(
                                                              "Error fetching data: $e");
                                                          ScaffoldMessenger.of(
                                                                  context)
                                                              .showSnackBar(
                                                            const SnackBar(
                                                                content: Text(
                                                                    "Failed to fetch product details")),
                                                          );
                                                        }
                                                      } else {
                                                        ScaffoldMessenger.of(
                                                                context)
                                                            .showSnackBar(
                                                          const SnackBar(
                                                              content: Text(
                                                                  "Platform URL not available")),
                                                        );
                                                      }
                                                    },
                                                    style: ElevatedButton
                                                        .styleFrom(
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
                                                      textStyle:
                                                          const TextStyle(
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
                                                    child: const Text(
                                                        'ADD TO GFTR'),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                          const SizedBox(height: 10),
                                        ],
                                      );
                                    }).toList(),
                                ],
                              ),
                            );
                          } else if (type == 'magazine') {
                            return SingleChildScrollView(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
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
                                                  bottom: 15),
                                              decoration: BoxDecoration(
                                                image: DecorationImage(
                                                  image: NetworkImage(
                                                      blogItem.image!),
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                            ),
                                          if (blogItem.content != null)
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 10, right: 10),
                                              child: Text(blogItem.content!,
                                                  style: TextStyle(
                                                      fontFamily: 'Poppins',
                                                      fontSize: 12,
                                                      fontWeight:
                                                          FontWeight.normal)),
                                            ),
                                          const SizedBox(height: 10),
                                        ],
                                      );
                                    }).toList(),
                                ],
                              ),
                            );
                          } else {
                            return const SizedBox();
                          }
                        },
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

class WebViewScreen extends StatefulWidget {
  final String url;

  const WebViewScreen({Key? key, required this.url}) : super(key: key);

  @override
  State<WebViewScreen> createState() => _WebViewScreenState();
}

class _WebViewScreenState extends State<WebViewScreen> {
  late WebViewController _controller;
  bool isLoading = true;
  bool change = true;
  String? urlImage;
  String? title;
  bool? isBack;
  List<String> productImage = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        leading: Builder(builder: (context) {
          return Padding(
            padding: const EdgeInsets.all(15),
            child: GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: SizedBox(
                height: screenHeight(context, dividedBy: 40),
                width: screenHeight(context, dividedBy: 40),
                child: const Icon(Icons.close, color: Colors.white),
              ),
            ),
          );
        }),
        backgroundColor: Colors.black,
        automaticallyImplyLeading: false,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(31),
          ),
        ),
        actions: [
          Padding(
            padding:
                const EdgeInsets.only(top: 8.0, left: 8, right: 15, bottom: 8),
            child: SizedBox(
                height: screenHeight(context, dividedBy: 40),
                child: Image.asset(
                  ImageConstants.gftrBlack,
                  color: Colors.white,
                )),
          ),
        ],
      ),
      body: Stack(
        children: [
          change
              ? WebView(
                  backgroundColor: const Color(0x00000000),
                  initialUrl: widget.url,
                  zoomEnabled: true,
                  javascriptMode: JavascriptMode.unrestricted,
                  onWebViewCreated: (controller) {
                    _controller = controller;
                  },
                  onPageFinished: (String url) {
                    setState(() {
                      isLoading = false;
                    });
                  },
                )
              : spinkitLoader(context, ColorCodes.coral),
          if (isLoading)
            Center(
              child: spinkitLoader(context, ColorCodes.coral),
            ),
          Positioned(
            bottom: 0.0,
            child: Container(
              height: screenHeight(context, dividedBy: 10),
              width: screenWidth(context),
              decoration: const BoxDecoration(
                  boxShadow: [BoxShadow(color: Colors.black45, blurRadius: 5)],
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(23),
                      topRight: Radius.circular(23)),
                  color: Colors.black),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Row(
                      children: [
                        GestureDetector(
                            child: const Icon(Icons.arrow_back_ios,
                                color: Colors.white),
                            onTap: () async {
                              isBack = await _controller.canGoBack();
                              if (isBack == true) {
                                _controller.goBack();
                              } else {
                                Navigator.pop(context);
                              }
                              setState(() {});
                            }),
                        SizedBox(
                          width: screenWidth(context, dividedBy: 20),
                        ),
                        GestureDetector(
                            child: const Icon(Icons.arrow_forward_ios_rounded,
                                color: Colors.white),
                            onTap: () async {
                              bool canGoForward =
                                  await _controller.canGoForward();
                              if (canGoForward) {
                                _controller.goForward();
                                setState(() {});
                              }
                            }),
                      ],
                    ),
                    GestureDetector(
                      onTap: () async {
                        setState(() {
                          change = false;
                        });
                        String? currentUrl = await _controller.currentUrl();
                        fetchData(url: currentUrl.toString());
                      },
                      child: Container(
                        height: screenHeight(context, dividedBy: 18),
                        width: screenWidth(context, dividedBy: 2.8),
                        decoration: BoxDecoration(
                            color: ColorCodes.coral,
                            borderRadius: BorderRadius.circular(100)),
                        alignment: Alignment.center,
                        child: customText("Add To Gftr", Colors.white, 12,
                            FontWeight.w100, poppins),
                      ),
                    )
                  ]),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> fetchData({required String url}) async {
    try {
      final response = await http.get(Uri.parse(url));
      var reDocument = responseToDocument(response);
      var data = MetadataParser.parse(reDocument);

      dom.Document html = dom.Document.html(response.body);
      final allImages = html
          .querySelectorAll('img')
          .map((e) => e.attributes['src'] ?? '')
          .toList();

      urlImage = data.image.toString();
      productImage =
          allImages.where((element) => element.startsWith('https://')).toList();

      // Filter out unwanted images
      productImage.removeWhere((element) =>
          element.toString().contains("gif") ||
          element.toString().contains("sticker") ||
          element.toString().contains("https://cdn.builder.io") ||
          element.toString().contains("\$pdp_sw20\$") ||
          element.toString().contains("/G/31") ||
          element.toString().contains("/I/01") ||
          element.toString().contains("I/11") ||
          element.toString().contains("/m/v/3/") ||
          element.toString().contains("q=90") ||
          element.toString().contains("q=50") ||
          element.toString().contains("svg") ||
          element.toString().contains("banner") ||
          element.toString().contains("LT33a2OUi") ||
          element.toString().contains("adroll") ||
          element.toString().contains("Logo") ||
          element.toString().contains("themes") ||
          element.toString().contains("pageSource") ||
          element.toString().contains("AC_SX96_SY48_QL70") ||
          element.toString().contains("s-l140") ||
          element.toString().contains("marketing") ||
          element.toString().contains("transparent") ||
          element.toString().contains("icons") ||
          element.toString().contains("resources") ||
          element.toString().contains("BwE"));

      if (data.title != null) {
        if (data.title.toString().length <= 25) {
          title = data.title.toString();
        } else {
          title = data.title.toString().substring(0, 25);
        }
      }

      if (productImage.isEmpty || productImage.length <= 1) {
        try {
          final String html = await _controller.evaluateJavascript('''
            // This JavaScript code will get all the image source URLs from the web page
            var images = document.getElementsByTagName('img');
            var urls = [];
            for (var i = 0; i < images.length; i++) {
              urls.push(images[i].src);
            }
            urls.join(';');
          ''');

          List<String> imageUrls =
              html.split(';').where((url) => url.isNotEmpty).toList();
          imageUrls = imageUrls
              .where((element) => element.startsWith('https://'))
              .toList();

          // Apply the same filters
          imageUrls.removeWhere((element) =>
              element.toString().contains("gif") ||
              element.toString().contains("sticker") ||
              element.toString().contains("https://cdn.builder.io") ||
              element.toString().contains("\$pdp_sw20\$") ||
              element.toString().contains("/G/31") ||
              element.toString().contains("/I/01") ||
              element.toString().contains("I/11") ||
              element.toString().contains("/m/v/3/") ||
              element.toString().contains("q=90") ||
              element.toString().contains("svg") ||
              element.toString().contains("banner") ||
              element.toString().contains("LT33a2OUi") ||
              element.toString().contains("adroll") ||
              element.toString().contains("Logo") ||
              element.toString().contains("themes") ||
              element.toString().contains("63f") ||
              element.toString().contains("64d") ||
              element.toString().contains("pageSource") ||
              element.toString().contains("64e") ||
              element.toString().contains("7b1") ||
              element.toString().contains("64c") ||
              element.toString().contains("bing") ||
              element.toString().contains("643") ||
              element.toString().contains("s-l140") ||
              element.toString().contains("marketing") ||
              element.toString().contains("transparent") ||
              element.toString().contains("icons") ||
              element.toString().contains("resources") ||
              element.toString().contains("BwE"));

          Navigator.push(context, MaterialPageRoute(
            builder: (context) {
              return AddTo(
                  imageUrl: '',
                  webViewLink: url,
                  sharedText: '',
                  title: title ?? '',
                  imagesList: imageUrls);
            },
          ));

          setState(() {
            change = true;
          });
        } catch (e) {
          print("Error executing JavaScript: $e");
          Navigator.push(context, MaterialPageRoute(
            builder: (context) {
              return AddTo(
                  imageUrl: urlImage.toString(),
                  webViewLink: url,
                  sharedText: '',
                  title: title ?? '',
                  imagesList: []);
            },
          ));

          setState(() {
            change = true;
          });
        }
      } else {
        Navigator.push(context, MaterialPageRoute(
          builder: (context) {
            return AddTo(
                imageUrl: urlImage.toString(),
                webViewLink: url,
                sharedText: '',
                title: title ?? '',
                imagesList: productImage);
          },
        ));

        setState(() {
          change = true;
        });
      }
    } catch (e) {
      print("Error fetching data: $e");
      setState(() {
        change = true;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Error fetching page data")),
      );
    }
  }
}
