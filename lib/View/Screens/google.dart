import 'dart:async';
import 'package:gftr/Helper/imageConstants.dart';
import 'package:gftr/View/Screens/ManageBottom/Thegiftrguids.dart';
import 'package:gftr/View/Screens/ManageBottom/gftrStoryViewPage.dart';
import 'package:gftr/View/Widgets/customLoader.dart';
import 'package:gftr/View/Widgets/roundedAppBar.dart';
import 'package:http/http.dart' as http;
import 'package:gftr/View/Screens/ManageBottom/getGiftedPublicView.dart';
import 'package:gftr/View/Screens/addTo.dart';
import 'package:flutter/material.dart';
import 'package:gftr/Helper/appConfig.dart';
import 'package:gftr/Helper/colorConstants.dart';
import 'package:gftr/View/Widgets/customText.dart';
import 'package:html/parser.dart' as parser;
import 'package:html/dom.dart' as dom;
import 'package:metadata_fetch/metadata_fetch.dart';
import 'package:webview_flutter/webview_flutter.dart';

String defauilUrl = 'https://www.google.com/search';

class GooglePage extends StatefulWidget {
  const GooglePage({Key? key}) : super(key: key);

  @override
  State<GooglePage> createState() => _GooglePageState();
}

class _GooglePageState extends State<GooglePage> {
  String? urlImage;
  String? Title;
  bool? isBack;
  bool isLoading = true;
  bool Change = true;
  String? pageContent;
  var loadingPercentage = 0;
  List<String> ProductImage = [];
  //  late final WebViewController _controller;
  // // final _controller = WebViewController();
  WebViewController? _controller;

  String _productPrice = "";
  String _productImage = "";
  List<String> filterUnsportingImages(List<String> images) {
    // Define your criteria for unsporting images
    // For example, let's say we're filtering out images with the word "explicit" in their filename
    final List<String> filteredImages = images.where((image) {
      return !image.contains("explicit");
    }).toList();

    return filteredImages;
  }

  Future fetchData({required String url}) async {
    print(' url : ${url}');
    print("Welcome to other preformat");
    final response = await http.get(Uri.parse(url));
    var _reDocument = MetadataFetch.responseToDocument(response);
    var data = MetadataParser.parse(_reDocument);
    print("Data : $data");
    dom.Document html = dom.Document.html(response.body);
    final _allimages = html
        .querySelectorAll('img')
        .map((e) => e.attributes['src'] ?? '')
        .toList();
    urlImage = data.image.toString();
    ProductImage =
        _allimages.where((element) => element.startsWith('https://')).toList();
    //  List filteredImages = filterUnsportingImages(ProductImage);
    ProductImage.removeWhere((element) => element.toString().contains("gif"));
    ProductImage.removeWhere(
        (element) => element.toString().contains("sticker"));
    ProductImage.removeWhere(
        (element) => element.toString().contains("https://cdn.builder.io"));
    ProductImage.removeWhere(
        (element) => element.toString().contains("\$pdp_sw20\$"));
    ProductImage.removeWhere((element) => element.toString().contains("/G/31"));
    ProductImage.removeWhere((element) => element.toString().contains("/I/01"));
    ProductImage.removeWhere((element) => element.toString().contains("I/11"));
    ProductImage.removeWhere(
        (element) => element.toString().contains("/m/v/3/"));
    ProductImage.removeWhere((element) => element.toString().contains("q=90"));
    ProductImage.removeWhere((element) => element.toString().contains("q=50"));
    ProductImage.removeWhere((element) => element.toString().contains("svg"));
    ProductImage.removeWhere(
        (element) => element.toString().contains("banner"));
    ProductImage.removeWhere(
        (element) => element.toString().contains("banner"));
    ProductImage.removeWhere(
        (element) => element.toString().contains("LT33a2OUi"));
    ProductImage.removeWhere(
        (element) => element.toString().contains("adroll"));
    ProductImage.removeWhere((element) => element.toString().contains("Logo"));
    ProductImage.removeWhere(
        (element) => element.toString().contains("themes"));
    ProductImage.removeWhere(
        (element) => element.toString().contains("pageSource"));
    ProductImage.removeWhere(
        (element) => element.toString().contains("AC_SX96_SY48_QL70"));
    ProductImage.removeWhere(
        (element) => element.toString().contains("s-l140"));
    ProductImage.removeWhere(
        (element) => element.toString().contains("marketing"));
    ProductImage.removeWhere(
        (element) => element.toString().contains("transparent"));
    ProductImage.removeWhere((element) => element.toString().contains("icons"));
    ProductImage.removeWhere(
        (element) => element.toString().contains("resources"));
    ProductImage.removeWhere((element) => element.toString().contains("BwE"));
    //  print("filteredImages :$filteredImages");
    if (data.title.toString().length <= 25) {
      Title = data.title.toString();
    } else {
      Title = data.title.toString().substring(0, 25);
    }
    if (ProductImage.length <= 1) {
      print("Welcome to amazon");
      try {
        final String html = await _controller!.runJavaScriptReturningResult('''
        // This JavaScript code will get all the image source URLs from the web page
        var images = document.getElementsByTagName('img');
        var urls = [];
        for (var i = 0; i < images.length; i++) {
          urls.push(images[i].src);
        }
        urls.join(';');
      ''') as String;
        List<String> imageUrls =
            html.split(';').where((url) => url.isNotEmpty).toList();
        imageUrls = imageUrls
            .where((element) => element.startsWith('https://'))
            .toList();
        imageUrls.removeWhere((element) => element.toString().contains("gif"));
        imageUrls
            .removeWhere((element) => element.toString().contains("sticker"));
        imageUrls.removeWhere(
            (element) => element.toString().contains("https://cdn.builder.io"));
        imageUrls.removeWhere(
            (element) => element.toString().contains("\$pdp_sw20\$"));
        imageUrls
            .removeWhere((element) => element.toString().contains("/G/31"));
        imageUrls
            .removeWhere((element) => element.toString().contains("/I/01"));
        imageUrls.removeWhere((element) => element.toString().contains("I/11"));
        imageUrls
            .removeWhere((element) => element.toString().contains("/m/v/3/"));
        imageUrls.removeWhere((element) => element.toString().contains("q=90"));
        imageUrls.removeWhere((element) => element.toString().contains("svg"));
        imageUrls
            .removeWhere((element) => element.toString().contains("banner"));
        imageUrls
            .removeWhere((element) => element.toString().contains("banner"));
        imageUrls
            .removeWhere((element) => element.toString().contains("LT33a2OUi"));
        imageUrls
            .removeWhere((element) => element.toString().contains("adroll"));
        imageUrls.removeWhere((element) => element.toString().contains("Logo"));
        imageUrls
            .removeWhere((element) => element.toString().contains("themes"));
        imageUrls.removeWhere((element) => element.toString().contains("63f"));
        imageUrls.removeWhere((element) => element.toString().contains("64d"));
        imageUrls.removeWhere(
            (element) => element.toString().contains("pageSource"));
        imageUrls.removeWhere((element) => element.toString().contains("64e"));
        imageUrls.removeWhere((element) => element.toString().contains("7b1"));
        imageUrls.removeWhere((element) => element.toString().contains("64c"));
        imageUrls.removeWhere((element) => element.toString().contains("bing"));
        imageUrls.removeWhere((element) => element.toString().contains("643"));
        imageUrls
            .removeWhere((element) => element.toString().contains("s-l140"));
        imageUrls
            .removeWhere((element) => element.toString().contains("marketing"));
        imageUrls.removeWhere(
            (element) => element.toString().contains("transparent"));
        imageUrls
            .removeWhere((element) => element.toString().contains("icons"));
        imageUrls
            .removeWhere((element) => element.toString().contains("resources"));
        imageUrls.removeWhere((element) => element.toString().contains("BwE"));
        print("imageUrls $imageUrls");
        //List filteredImages = filterUnsportingImages(imageUrls);
        print('Extracted Image URLs:');
        //print("filteredImages :$filteredImages");
        Navigator.push(context, MaterialPageRoute(
          builder: (context) {
            return AddTo(
                imageUrl: '',
                webViewLink: url,
                sharedText: '',
                title: Title ?? '',
                imagesList: imageUrls);
          },
        ));
        setState(() {
          Change = true;
        });
      } catch (e) {
        print("Error executing JavaScript: $e");
        Navigator.push(context, MaterialPageRoute(
          builder: (context) {
            return AddTo(
                imageUrl: urlImage.toString(),
                webViewLink: url,
                sharedText: '',
                title: Title ?? '',
                imagesList: []);
          },
        ));
        setState(() {
          Change = true;
        });
      }
    } else {
      Navigator.push(context, MaterialPageRoute(
        builder: (context) {
          return AddTo(
              imageUrl: urlImage.toString(),
              webViewLink: url,
              sharedText: '',
              title: Title ?? '',
              imagesList: ProductImage);
        },
      ));
      setState(() {
        Change = true;
      });
    }

    // // final Redocument = parser.parse(response.body);
    // // final imageElements = Redocument.querySelectorAll('img');

    //  // imageUrls = imageElements
    //  //     .map((element) => element.attributes['src'] ?? '')
    //  //     .toList();
  }

  @override
  Widget build(BuildContext context) {
    if (_controller == null) {
      _controller = WebViewController()
        ..setBackgroundColor(
          const Color(0x00000000),
        )
        ..setJavaScriptMode(JavaScriptMode.unrestricted)
        ..enableZoom(true)
        ..setNavigationDelegate(
          NavigationDelegate(
            onProgress: (int progress) {
              // Update loading bar.
            },
            onPageFinished: (String url) {
              setState(() {
                isLoading = false;
              });
            },
          ),
        )
        ..loadRequest(Uri.parse(defauilUrl));
    }
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        leading: Builder(builder: (context) {
          return Padding(
            padding: EdgeInsets.all(15),
            child: GestureDetector(
              onTap: () {
                // For GooglePage accessed via bottom navigation, navigate to home instead of popping
                print("GooglePage: Close button pressed, navigating to home");
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => GfterStoryViewPage(),
                  ),
                );
                // Update global state for bottom navigation
                bottombarblack = true;
                isSearchbar = true;
                print(
                    "GooglePage: Updated bottombarblack=$bottombarblack, isSearchbar=$isSearchbar");
              },
              child: SizedBox(
                  height: screenHeight(context, dividedBy: 40),
                  width: screenHeight(context, dividedBy: 40),
                  child: Icon(
                    Icons.close,
                    color: Colors.white,
                  )),
            ),
          );
        }),
        backgroundColor: Colors.black,
        //elevation: 0,
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
                height: screenHeight(context, dividedBy: 30),
                // width: screenWidth(context,dividedBy: 20),
                child: Image.asset(
                  ImageConstants.gftrBlack,
                  color: Colors.white,
                )),
          ),
        ],
      ),
      body: Stack(children: [
        Change == true
            ? WebViewWidget(controller: _controller!)
            : spinkitLoader(context, ColorCodes.coral),
        // Container(
        //    margin: EdgeInsets.only(top: screenHeight(context,dividedBy: 60)),
        //   height: screenHeight(context, dividedBy: 13),
        //   width: screenWidth(context),
        //   decoration: BoxDecoration(
        //       color: ColorCodes.teal,
        //       borderRadius: BorderRadius.only(
        //           bottomLeft: Radius.circular(23),
        //           bottomRight: Radius.circular(23))),
        //   child: Padding(
        //     padding: const EdgeInsets.all(15),
        //     child: Row(
        //       mainAxisAlignment: MainAxisAlignment.spaceAround,
        //       children: [
        //         // IconButton(
        //         //     onPressed: () {
        //               Navigator.pushReplacement(
        //                 context,
        //                 MaterialPageRoute(
        //                   builder: (context) => GfterStoryViewPage(),
        //                 ),
        //               );
        //               bottombarblack = true;
        //               isSearchbar = true;
        //         //     },
        //         //     icon:
        //             GestureDetector(onTap: () {
        //               Navigator.pushReplacement(
        //                 context,
        //                 MaterialPageRoute(
        //                   builder: (context) => GfterStoryViewPage(),
        //                 ),
        //               );
        //               bottombarblack = true;
        //               isSearchbar = true;
        //             },child: Icon(Icons.close)),
        //         //),
        //         Spacer(),
        //         Padding(
        //           padding: const EdgeInsets.only(right: 10),
        //           child: SizedBox(
        //               height: screenHeight(context, dividedBy: 30),
        //               // width: screenWidth(context,dividedBy: 20),
        //               child: Image.asset(
        //                 ImageConstants.gftrBlack,
        //                 color: Colors.white,
        //               )),
        //         )
        //       ],
        //     ),
        //   ),
        // ),
        Positioned(
          bottom: 0.0,
          child: Container(
            height: screenHeight(context, dividedBy: 10),
            width: screenWidth(context),
            decoration: BoxDecoration(
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
                          child: Icon(
                            Icons.arrow_back_ios,
                            color: Colors.white,
                          ),
                          onTap: () async {
                            isBack = await _controller!.canGoBack();
                            isBack == false
                                ? Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          GetGiftedPublicViewPage(indexdata: 0),
                                    ))
                                : _controller!.goBack();
                            setState(() {});
                          }),
                      SizedBox(
                        width: screenWidth(context, dividedBy: 20),
                      ),
                      GestureDetector(
                          child: Icon(
                            Icons.arrow_forward_ios_rounded,
                            color: Colors.white,
                          ),
                          onTap: () {
                            _controller!.goForward();
                            setState(() {});
                          }),
                    ],
                  ),
                  GestureDetector(
                    onTap: () async {
                      setState(() {
                        Change = false;
                      });
                      String? url = await _controller!.currentUrl();
                      // String? url = await _controller.toString();
                      fetchData(url: url.toString());
                    },
                    child: Container(
                      height: screenHeight(context, dividedBy: 18),
                      width: screenWidth(context, dividedBy: 2.8),
                      decoration: BoxDecoration(
                          // boxShadow: [
                          //   BoxShadow(
                          //     color: Colors.grey,
                          //     blurRadius: 0.0,
                          //     // spreadRadius: 0.0,
                          //     offset: Offset(
                          //       1.0,
                          //       0.0,
                          //     ),
                          //   )
                          // ],
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
      ]),
      // floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      // floatingActionButton:
    );
  }
}
