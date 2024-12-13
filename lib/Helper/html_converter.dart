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
    // Replace ADD TO GFTR with clickable links
    final modifiedContent = replaceAddToGFTRWithClickable(content);

    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Html(
            style: {
              'body': Style(
                fontSize: FontSize(16.0), // Consistent font size for the body
                fontFamily: 'Georgia', // Use a consistent font family
                fontWeight:
                    FontWeight.w400, // Standardize font weight for body text
                lineHeight: LineHeight(1.5), // Improve spacing between lines
                color: Colors.black, // Default text color
                margin: Margins.symmetric(
                    vertical: 8.0), // Medium margin for subheadings
              ),
              'img': Style(
                alignment: Alignment.centerLeft, // Center align images
                margin: Margins.only(
                  top: 32,
                ), // Medium margin for images
              ),
              'a': Style(
                fontSize: FontSize(16.0), // Match link font size with body text
                fontFamily: 'Georgia', // Keep font family consistent
                fontWeight:
                    FontWeight.w600, // Slightly bold for emphasis on links
                textDecoration: TextDecoration.underline, // Underline links
                color: Colors.blue, // Standard link color
              ),
              'h1': Style(
                fontSize: FontSize(24.0), // Larger font size for headings
                fontFamily: 'Georgia',
                fontWeight: FontWeight.w700, // Bold for headings
                color: Colors.black87, // Slightly lighter black for headings
                margin: Margins.symmetric(
                    vertical: 12.0), // Medium margin for subheadings
              ),
              'h2': Style(
                fontSize:
                    FontSize(20.0), // Slightly smaller font for subheadings
                fontFamily: 'Georgia',
                fontWeight: FontWeight.w600,
                color: Colors.black87,
                margin: Margins.symmetric(
                    vertical: 12.0), // Medium margin for subheadings
              ),
            },
            data: modifiedContent,
            onLinkTap: (url, _, __) {
              // Handle link taps for "ADD TO GFTR" and other cases
              if (url != null && url.startsWith('add_to_gftr')) {
                final gftrId = url.split("_").last; // Extract the GFTR ID
                handleAddToGFTR(
                  context,
                  content,
                  int.parse(gftrId),
                );
              } else if (url != null) {
                // Handle external links
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
      ),
    );
  }

  /// Handles the "ADD TO GFTR" click by extracting content and navigating to AddTo screen
  void handleAddToGFTR(BuildContext context, String htmlContent, int gftrId) {
    // Extract the section from <img> to the GFTR link based on the GFTR ID
    String extractedContent = extractContent(htmlContent, gftrId);

    log(extractedContent);

    // Parse the extracted content into relevant fields
    final Map<String, String> parsedData =
        parseExtractedContent(extractedContent);

    // Navigate to the AddTo screen with extracted data
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

  /// Parses the extracted content to retrieve image URL, link, title, and description
  Map<String, String> parseExtractedContent(String extractedContent) {
    // Parse the extracted HTML content using the HTML parser
    final document = htmlParser.parse(extractedContent);

    // Extract image URL
    final imgTag = document.querySelector('img');
    final imageUrl = imgTag?.attributes['src'] ?? '';

    // Extract link (if present in the content)
    final linkTag = document.querySelector('a');
    final link = linkTag?.attributes['href'] ?? '';

    // Extract title (use bold or styled text as title)
    final titleSpan = document.querySelector('span[style*="font-weight:700"]');
    final title = titleSpan?.text ?? '';

    // Extract description (remaining text excluding title and link)
    final description =
        document.body?.text.replaceAll(RegExp(r'\s+'), ' ').trim() ?? '';

    return {
      'imageUrl': imageUrl,
      'link': link,
      'title': title,
      'description': description,
    };
  }

  /// Extracts content from the nearest `<img>` tag to the selected GFTR link
  String extractContent(String htmlContent, int gftrId) {
    // Regex to match <img> followed by "(ADD TO GFTR)"
    final regex = RegExp(
      r'(<img.*?>.*?)(\(ADD TO GFTR\))',
      caseSensitive: false,
      multiLine: true,
    );

    // Find all matches in the content
    final matches = regex.allMatches(htmlContent).toList();

    // Get the specific match for the GFTR ID
    if (gftrId >= 0 && gftrId < matches.length) {
      final match = matches[gftrId];
      return htmlContent.substring(match.start, match.end);
    }

    return "No matching content found";
  }

  /// Replaces "(ADD TO GFTR)" spans with clickable links and assigns unique IDs
  String replaceAddToGFTRWithClickable(String htmlContent) {
    final pattern = RegExp(
      r'<span[^>]*>\(ADD\s+TO\s+GFTR\)\s*<\/span>',
      caseSensitive: false,
      multiLine: true,
    );

    int gftrCounter = 0;

    // Replace the matched pattern with clickable HTML links
    final modifiedHtml = htmlContent.replaceAllMapped(pattern, (match) {
      final gftrId = gftrCounter++; // Increment unique ID for each match
      return """
      <a href="add_to_gftr_$gftrId" style="color:blue;text-decoration:underline;cursor:pointer;">ADD TO GFTR</a>
      """;
    });

    return modifiedHtml;
  }
}
