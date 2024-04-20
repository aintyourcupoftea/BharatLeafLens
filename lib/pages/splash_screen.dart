import 'package:bharat_leaf_lens/components/home_components.dart';
import 'package:bharat_leaf_lens/pages/homepage.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'results.dart';
import 'package:lottie/lottie.dart';


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
    await Future.delayed(const Duration(milliseconds: 1500), () {});
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => const HomePage()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: [Color(0xFFC31432), Color(0xFF240B36)],
          ),
        ),
        child: Center(
          child: Text(
            'Bharat Leaf Lens',
            style: GoogleFonts.merriweather(
              fontSize: 32.0,
              fontWeight: FontWeight.w900,
              color:Colors.white
            ),
          ),
        ),
      ),
    );
  }
}
