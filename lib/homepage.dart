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
            child: RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                  children: [
                    TextSpan(
                        text: "Welcome to\n",
                        style: GoogleFonts.playfairDisplay(fontWeight: FontWeight.w500) // Semi-bold
                    ),
                    TextSpan(
                        text: "Bharat Leaf Lens",
                        style: GoogleFonts.playfairDisplay(fontWeight: FontWeight.bold) // Bold
                    ),
                  ]
              ),
            ),
          ),
        ),
        bottomNavigationBar: MyBottomNavigationBar(),
      ),
    );
  }
}
