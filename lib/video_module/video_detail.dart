import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'dart:convert';

class VideoDetail extends StatefulWidget {
  final String title;
  final String youtubeId;
  final DateTime published;
  const VideoDetail({
    required this.title,
    required this.youtubeId,
    required this.published,
  });

  @override
  State<VideoDetail> createState() => _VideoDetailState();
}

class _VideoDetailState extends State<VideoDetail> {
  late WebViewController controller;
  @override
  void initState() {
    super.initState();
    controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted) // Enable JavaScript
      ..loadRequest(Uri.dataFromString(
        '''
        <!DOCTYPE html>
        <html>
          <head>
            <meta name="viewport" content="width=device-width, initial-scale=1">
          </head>
          <body style="margin: 0; padding: 0;">
            <iframe width="100%" height="250" src="https://www.youtube.com/embed/${widget.youtubeId}" 
            frameborder="0" allowfullscreen></iframe>
          </body>
        </html>
        ''',
        mimeType: 'text/html',
        encoding: utf8,
      ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.title)),
      body: WebViewWidget(controller: controller),
    );
  }
}
