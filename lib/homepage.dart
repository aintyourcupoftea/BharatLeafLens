import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'navigation_bar.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    const String appTitle = 'Bharat Leaf Lens';
    return MaterialApp(
      title: appTitle,
      home: Scaffold(
        appBar: AppBar(
          title: Center(
            child: Text(
              "Welcome to\nBharat Leaf Lens",
              textAlign: TextAlign.center,
              style: GoogleFonts.playfairDisplay(
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
        bottomNavigationBar: MyBottomNavigationBar()
      ),
    );
  }
}
