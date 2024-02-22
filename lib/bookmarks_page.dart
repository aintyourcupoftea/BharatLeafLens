import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class BookmarksPage extends StatelessWidget {
  const BookmarksPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.amber, //Remove when debugged
        title: Text(
          "Bookmarks",
          style: GoogleFonts.playfairDisplay(
            fontWeight: FontWeight.w500,
          ),
        ),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
    );
  }
}
