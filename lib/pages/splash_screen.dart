import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'homepage.dart';
import 'package:http/http.dart' as http;

class MySplashScreen extends StatefulWidget {
  const MySplashScreen({Key? key}) : super(key: key);

  @override
  _MySplashScreenState createState() => _MySplashScreenState();
}

class _MySplashScreenState extends State<MySplashScreen> {
  @override
  void initState() {
    super.initState();
    _initializeAndNavigateToHome();
  }

  Future<void> pingAPI() async {
    const apiUrl = 'https://api-inference.huggingface.co/models/dima806/medicinal_plants_image_detection';
    final headers = {
      "Authorization": "Bearer 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",
    };

    try {
      final response = await http.head(Uri.parse(apiUrl), headers: headers);
      if (response.statusCode != 200) {
        print('API ping failed with status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error pinging API: ${e.toString()}');
    }
  }

  Future<void> _initializeAndNavigateToHome() async {
    await pingAPI();
    await Future.delayed(const Duration(milliseconds: 1500));
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const HomePage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
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
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}