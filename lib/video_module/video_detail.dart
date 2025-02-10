import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'dart:convert';

class VideoDetail extends StatefulWidget {
  final String title;
  final String author;
  final String youtubeId;
  final DateTime published;
  final int view;
  const VideoDetail({
    required this.title,
    required this.author,
    required this.youtubeId,
    required this.published,
    required this.view,
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
      body: _buildBody(),
      // body: WebViewWidget(controller: controller),
    );
  }

  Widget _buildBody() {
    return Column(
      children: [
        _buildVideoPlayer(),
        _buildVideoTitle(),
        Divider(),
        _buildDetailRow('ផលិតដោយ: ', widget.author),
        _buildDetailRow('ថ្ងៃចុះផ្សាយ: ', widget.published.toString()),
        _buildDetailRow('អ្នកទស្សនា: ', widget.view.toString()),
      ],
    );
  }

  Widget _buildVideoPlayer() {
    return SizedBox(
      height: 250,
      child: WebViewWidget(controller: controller),
    );
  }

  Widget _buildVideoTitle() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Text(
        widget.title,
        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _buildDetailRow(String title, String value) {
    return Container(
      margin: EdgeInsets.only(left: 20, right: 20, top: 10),
      child: Row(
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }
}
