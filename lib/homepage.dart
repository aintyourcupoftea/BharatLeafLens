import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // backgroundColor: Color(0xff7B3F00),
        toolbarHeight: 150,
        title: Center(
          child: RichText(
            textAlign: TextAlign.center,
            text: TextSpan(
              children: [
                TextSpan(
                  text: "Welcome to\n",
                  style: GoogleFonts.playfairDisplay(
                    fontWeight: FontWeight.w500,
                    color: Colors.brown.shade800,
                    fontSize: 24,
                  ),
                ),
                TextSpan(
                  text: "Bharat Leaf Lens",
                  style: GoogleFonts.playfairDisplay(
                    fontWeight: FontWeight.bold,
                    color: Colors.brown.shade900,
                    fontSize: 36,
                    // foreground: Paint()
                    //   ..shader = LinearGradient(
                    //     colors: [
                    //       Color(0xffFF9933), // Saffron
                    //       Color(0xff138808),
                    //       // Color(0xff17E700), // Green
                    //     ],
                    //   ).createShader(
                    //     Rect.fromLTWH(125, 0, 100, 0),
                    //   ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}