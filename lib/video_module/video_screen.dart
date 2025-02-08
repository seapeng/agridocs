import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'dart:convert';

class VideoScreen extends StatefulWidget {
  const VideoScreen({super.key});

  @override
  State<VideoScreen> createState() => _VideoScreenState();
}

class _VideoScreenState extends State<VideoScreen> {
  late WebViewController controller;
  String videoId = 'qykdGycEWLk';
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
          <iframe width="100%" height="300" src="https://www.youtube.com/embed/$videoId" 
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
      appBar: AppBar(title: Text("YouTube WebView")),
      body: WebViewWidget(controller: controller),
    );
  }
}
