import 'package:bharat_leaf_lens/components/home_components.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

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
        context, MaterialPageRoute(builder: (context) => HomeComponents()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.deepOrangeAccent, Colors.green],
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
                  // Change to RadialGradient
                  colors: [
                    Color(0xff051C13),
                    Color(0xff1B4723),
                    Color(0xff69A832),
                    Color(0xff99D689),
                    Color(0xffD8F19C),
                    Color(0xffC2D5B9)
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
