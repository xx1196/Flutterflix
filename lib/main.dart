import 'package:flutter/material.dart';
import 'package:flutterflix/src/pages/home_page.dart';
import 'package:flutterflix/src/pages/movie_detail.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'FlutterFlix',
      initialRoute: '/',
      routes: {
        '/': (BuildContext contex) => HomePage(),
        'detail': (BuildContext contex) => MovieDetail(),
      },
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
      ),
    );
  }
}
