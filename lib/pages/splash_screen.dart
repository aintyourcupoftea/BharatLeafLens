import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'homepage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const String appTitle = 'Bharat Leaf Lens';
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: appTitle,
      home: MySplashScreen(),
    );
  }
}

class MySplashScreen extends StatefulWidget {
  const MySplashScreen({Key? key}) : super(key: key);

  @override
  _MySplashScreenState createState() => _MySplashScreenState();
}

class _MySplashScreenState extends State<MySplashScreen> {
  @override
  void initState() {
    super.initState();
    _installProfileAndNavigateToHome();
  }

  _installProfileAndNavigateToHome() async {
    await _installProfile(); // Call the method to install the profile

    // Delay for splash screen (if needed)
    await Future.delayed(const Duration(milliseconds: 1500));

    // Navigate to the home page
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const HomePage()),
    );
  }

  Future<void> _installProfile() async {
    // Add your code to install the profile here
    // For example:
    // await ProfileInstaller.install('aintyourcupoftea.web.app.bharat_leaf_lens');
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
