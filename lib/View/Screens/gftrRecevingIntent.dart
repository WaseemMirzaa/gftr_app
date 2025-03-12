import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:metadata_extract/metadata_extract.dart';

import 'package:http/http.dart' as http;

class MyApp2 extends StatefulWidget {
  @override
  _MyApp2State createState() => _MyApp2State();
}

class _MyApp2State extends State<MyApp2> {
  /// I picked these links & images from internet
  final String _errorImage =
      "https://i.ytimg.com/vi/z8wrRRR7_qU/maxresdefault.jpg";
  final String _url1 =
      "https://www.espn.in/football/soccer-transfers/story/4163866/transfer-talk-lionel-messi-tells-barcelona-hes-more-likely-to-leave-then-stay";
  final String _url2 = "https://speakerdeck.com/themsaid/the-power-of-laravel-queues";
  final String _url3 = "https://twitter.com/laravelphp/status/1222535498880692225";
  final String _url4 = "https://www.youtube.com/watch?v=W1pNjxmNHNQ";
  final String _url5 = "https://www.brainyquote.com/topics/mo tivational-quotes";

  fetchData() async {
    var response = await http.get(Uri.parse(
        'https://dl.flipkart.com/dl/van-heusen-academy-full-sleeve-solid-men-sweatshirt/p/itm782051c95ff2a?pid=SWSGHWJ6BGPHEAA5&cmpid=product.share.pp&_refId=PP.63847424-6010-4a75-a04c-a82c3a3f8180.SWSGHWJ6BGPHEAA5&_appId=MR'));
    // Covert Response to a Document. The utility function `responseToDocument` is provided or you can use own decoder/parser.
    var document = responseToDocument(response);

    // get metadata
    var data = MetadataParser.parse(document);
    log(data.description??'');
    log(data.image??'');
    log(data.title??'');
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchData();
  }
  // @override
  // void initState() {
  //   super.initState();
  //   _getMetadata(_url5);
  // }

  // void _getMetadata(String url) async {
  //   bool _isValid = _getUrlValid(url);
  //   if (_isValid) {
  //     Metadata? metadata = await AnyLinkPreview.getMetadata(
  //       link: url,
  //       cache: Duration(days: 7),
  //       proxyUrl: "https://cors-anywhere.herokuapp.com/", // Needed for web app
  //     );
  //     log(metadata?.title ?? '');
  //     log(metadata?.desc ?? "");
  //   } else {
  //     debugPrint("URL is not valid");
  //   }
  // }
  //
  // bool _getUrlValid(String url) {
  //   bool _isUrlValid = AnyLinkPreview.isValidLink(
  //     url,
  //     protocols: ['http', 'https'],
  //     hostWhitelist: ['https://youtube.com/'],
  //     hostBlacklist: ['https://facebook.com/'],
  //   );
  //   return _isUrlValid;
  // }

  @override
  Widget build(BuildContext context) {
    return MaterialApp();
  }
}
