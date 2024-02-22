import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
// import 'navigation_bar.dart';
import 'aesthetic_nav_bar.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    const String appTitle = 'Bharat Leaf Lens';
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: appTitle,
      home: Scaffold(
        backgroundColor: Color(0xffF5F5DC), //Change later
        appBar: AppBar(
          backgroundColor: Colors.amber, //Remove when debugged
          title: Center(
            child: Text(
              "Welcome to\n$appTitle",
              textAlign: TextAlign.center,
              style: GoogleFonts.playfairDisplay(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        bottomNavigationBar: AestheticNavBar()
      ),
    );
  }
}
