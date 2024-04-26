import 'package:bharat_leaf_lens/pages/homepage.dart';
import 'package:flutter/material.dart';
import 'pages/splash_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {


  @override
  Widget build(BuildContext context) {
    const String appTitle = 'Bharat Leaf Lens';
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: appTitle,
      home: MySplashScreen(),
    );
  }
}

