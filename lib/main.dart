import 'package:flutter/material.dart';
import 'package:posts_client/models/nikeo_theme_model.dart';
import 'package:posts_client/screens/reading.dart';
import 'package:posts_client/screens/posts.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [ChangeNotifierProvider(create: (_) => NikeoThemeModel())],
      builder: (context, _) {
        return MaterialApp(
          title: 'Posts - Nikeo',
          theme: context.watch<NikeoThemeModel>().theme.themeData,
          initialRoute: '/posts',
          routes: {
            '/posts': (context) => MyPosts(title: "Nikeo 's Posts"),
            '/reading': (context) => MyReading(
                  title: "Nikeo 's Posts",
                ),
          },
        );
      },
    );
  }
}
