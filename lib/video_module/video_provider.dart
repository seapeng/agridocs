import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'video_app.dart';
import 'video_logic.dart';
import 'video_search_logic.dart';

Widget videoProvider() {
  return MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (context) => VideoLogic()),
      ChangeNotifierProvider(create: (context) => VideoSearchLogic()),
    ],
    child: const VideoApp(),
  );
}
