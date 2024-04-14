import 'package:bharat_leaf_lens/components/home_components.dart';
import 'package:bharat_leaf_lens/pages/homepage.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'results.dart';


class MySplashScreen extends StatefulWidget {
  const MySplashScreen({super.key});

  @override
  State<MySplashScreen> createState() => _MySplashScreenState();
}

class _MySplashScreenState extends State<MySplashScreen> {
  @override
  void initState() {
    super.initState();
    _navigateToHome();
  }

  _navigateToHome() async {
    await Future.delayed(Duration(milliseconds: 1500), () {});
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => HomePage()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomRight,
            colors: [Colors.deepOrangeAccent, Colors.white, Colors.green.shade700],

          ),
        ),
        child: Center(
          child: Text(
            "Bharat Leaf Lens",
            style: GoogleFonts.playfairDisplay(
              fontWeight: FontWeight.bold,
              fontSize: 36,
              foreground: Paint()
                ..shader = LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  // Change to RadialGradient
                  colors: [
                    Colors.blue.shade900,
                    Colors.deepPurple.shade500
                  ],
                ).createShader(
                  Rect.fromLTWH(-150, 1, 800, 0),
                ),
            ),
          ),
        ),
      ),
    );
  }
}
