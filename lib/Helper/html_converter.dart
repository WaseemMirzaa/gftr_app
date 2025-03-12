import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:html/parser.dart' as htmlParser;

import '../View/Screens/GiftDetails.dart';
import '../View/Screens/addTo.dart';

class HTMLContentView extends StatelessWidget {
  final String content;

  HTMLContentView({required this.content});

  @override
  Widget build(BuildContext context) {
    final modifiedContent = replaceAddToGFTRWithClickable(content);

    return SingleChildScrollView(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Html(
          style: {
            'body': Style(
              fontSize: FontSize(14.0),
              fontFamily: 'Times New Roman',
              fontWeight: FontWeight.w400,
              lineHeight: LineHeight(1.5),
              color: Colors.black,
              margin: Margins.symmetric(vertical: 8.0),
            ),
            'img': Style(
              alignment: Alignment.centerLeft,
              margin: Margins.only(top: 32),
            ),
            'a': Style(
              fontSize: FontSize(14.0),
              fontFamily: 'Times New Roman',
              fontWeight: FontWeight.w600,
              textDecoration: TextDecoration.underline,
              color: Colors.blue,
            ),
            'h1': Style(
              fontSize: FontSize(20.0),
              fontFamily: 'Times New Roman',
              fontWeight: FontWeight.w700,
              color: Colors.black87,
              margin: Margins.symmetric(vertical: 12.0),
            ),
            'h2': Style(
              fontSize: FontSize(18.0),
              fontFamily: 'Times New Roman',
              fontWeight: FontWeight.w600,
              color: Colors.black87,
              margin: Margins.symmetric(vertical: 12.0),
            ),
          },
          data: modifiedContent,
          onLinkTap: (url, _, __) {
            if (url != null && url.startsWith('add_to_gftr')) {
              final gftrId = url.split("_").last;
              handleAddToGFTR(context, content, int.parse(gftrId));
            } else if (url != null) {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => WebViewScreen(url: url),
                ),
              );
            }
          },
        ),
      ),
    );
  }

  void handleAddToGFTR(BuildContext context, String htmlContent, int gftrId) {
    String extractedContent = extractContent(htmlContent, gftrId);
    log(extractedContent);
    final Map<String, String> parsedData =
        parseExtractedContent(extractedContent);
    Navigator.push(context, MaterialPageRoute(
      builder: (context) {
        return AddTo(
          imageUrl: parsedData['imageUrl'] ?? '',
          webViewLink: parsedData['link'] ?? '',
          title: parsedData['title'] ?? '',
          sharedText: parsedData['description'] ?? '',
          imagesList: [],
          isBack: true,
        );
      },
    ));
  }

  Map<String, String> parseExtractedContent(String extractedContent) {
    final document = htmlParser.parse(extractedContent);
    final imgTag = document.querySelector('img');
    final imageUrl = imgTag?.attributes['src'] ?? '';
    final linkTag = document.querySelector('a');
    final link = linkTag?.attributes['href'] ?? '';
    final titleSpan = document.querySelector('span[style*="font-weight:700"]');
    final title = titleSpan?.text ?? '';
    final description =
        document.body?.text.replaceAll(RegExp(r'\s+'), ' ').trim() ?? '';
    return {
      'imageUrl': imageUrl,
      'link': link,
      'title': title,
      'description': description,
    };
  }

  String extractContent(String htmlContent, int gftrId) {
    final regex = RegExp(
      r'(<img.*?>.*?)(\(ADD TO GFTR\))',
      caseSensitive: false,
      multiLine: true,
    );
    final matches = regex.allMatches(htmlContent).toList();
    if (gftrId >= 0 && gftrId < matches.length) {
      final match = matches[gftrId];
      return htmlContent.substring(match.start, match.end);
    }
    return "No matching content found";
  }

  String replaceAddToGFTRWithClickable(String htmlContent) {
    final pattern = RegExp(
      r'<span[^>]*>\(ADD\s+TO\s+GFTR\)\s*<\/span>',
      caseSensitive: false,
      multiLine: true,
    );
    int gftrCounter = 0;
    final modifiedHtml = htmlContent.replaceAllMapped(pattern, (match) {
      final gftrId = gftrCounter++;
      return """
      <a href="add_to_gftr_$gftrId" style="color:blue;text-decoration:underline;cursor:pointer;">ADD TO GFTR</a>
      """;
    });
    return modifiedHtml;
  }
}
