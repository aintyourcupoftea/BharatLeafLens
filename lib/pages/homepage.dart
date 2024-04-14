import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_carousel_widget/flutter_carousel_widget.dart';
import 'package:image_picker/image_picker.dart';
import 'results.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  File? _image;
  final picker = ImagePicker();
  late Timer _backButtonTimer;
  bool _exitApp = false;

  @override
  void initState() {
    super.initState();
    _backButtonTimer = Timer(Duration(seconds: 2), () {});
  }

  Future getImage(ImageSource source) async {
    final pickedFile = await picker.pickImage(source: source);
    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ResultsPage(image: _image!),
          ),
        );
      } else {
        print('No image selected.');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final List<String> imageList = [
      "assets/carousel/1.png",
      "assets/carousel/2.png",
      "assets/carousel/3.png"
    ];

    final List<Widget> imageWidgets = imageList
        .map(
          (imageAsset) => Image.asset(
        imageAsset,
        fit: BoxFit.cover,
      ),
    )
        .toList();

    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) {
        if (!didPop) {
          if (_exitApp) {
            // If already pressed back once and within 2 seconds, exit the app
            exit(0);
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text("Press back again to exit"),
                duration: Duration(seconds: 2),
              ),
            );

            // Set the flag to true after first back button press
            _exitApp = true;

            _backButtonTimer.cancel();
            _backButtonTimer = Timer(Duration(seconds: 2), () {
              // Reset the flag after 2 seconds
              _exitApp = false;
            });
          }
        }
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
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
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
        backgroundColor: Colors.white,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(child: Container()),
              SizedBox(
                height: 300,
                width: 300,
                child: FlutterCarousel(
                  items: imageWidgets,
                  options: CarouselOptions(
                    indicatorMargin: 0,
                    height: 250.0,
                    aspectRatio: 1 / 1,
                    viewportFraction: 1.0,
                    initialPage: 0,
                    enableInfiniteScroll: true,
                    reverse: false,
                    autoPlay: true,
                    autoPlayInterval: const Duration(seconds: 3),
                    autoPlayAnimationDuration: const Duration(milliseconds: 800),
                    autoPlayCurve: Curves.fastEaseInToSlowEaseOut,
                    enlargeCenterPage: false,
                    controller: CarouselController(),
                    pageSnapping: true,
                    scrollDirection: Axis.horizontal,
                    pauseAutoPlayOnTouch: true,
                    pauseAutoPlayOnManualNavigate: true,
                    pauseAutoPlayInFiniteScroll: false,
                    enlargeStrategy: CenterPageEnlargeStrategy.scale,
                    disableCenter: false,
                    showIndicator: true,
                    slideIndicator: const CircularSlideIndicator(
                      currentIndicatorColor: Colors.black,
                      indicatorBackgroundColor: Colors.brown,
                    ),
                  ),
                ),
              ),
              Expanded(child: Container()),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(16),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xff889452),
                          minimumSize: const Size(100, 90),
                          elevation: 4,
                          shadowColor: Colors.black,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(24),
                          ),
                        ),
                        onPressed: () {
                          getImage(ImageSource.camera);
                        },
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SvgPicture.asset(
                              "assets/icons/camera.svg",
                              height: 24,
                              width: 24,
                            ),
                            const SizedBox(height: 4),
                            const Text(
                              "Take picture",
                              style: TextStyle(color: Colors.white),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xff325721),
                          minimumSize: const Size(100, 90),
                          elevation: 4,
                          shadowColor: Colors.black,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(24),
                          ),
                        ),
                        onPressed: () {
                          getImage(ImageSource.gallery);
                        },
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SvgPicture.asset(
                              "assets/icons/upload_Image.svg",
                              height: 24,
                              width: 24,
                            ),
                            const SizedBox(height: 4),
                            const Text(
                              "Choose picture",
                              style: TextStyle(color: Colors.white),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
