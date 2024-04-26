import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lottie/lottie.dart';

class PlantNotFound extends StatelessWidget {
  const PlantNotFound({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Error",
          style: GoogleFonts.merriweather(),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: SvgPicture.asset(
            'assets/icons/close_icon.svg', // Replace 'assets/close_icon.svg' with the path to your SVG file
            height: 21, // Adjust height as needed
            width: 21, // Adjust width as needed
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(bottom: 75),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: SizedBox(
                height: 200, // Adjust height as needed
                width: 300, // Adjust width as needed
                child: Lottie.asset('assets/icons/404.json'),
              ),
            ),
            Center(
              child: Text(
                "The image you uploaded\nis not likely a leaf image.\nPlease try again.",
                textAlign: TextAlign.center,
                style: GoogleFonts.merriweather(
                  textStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
