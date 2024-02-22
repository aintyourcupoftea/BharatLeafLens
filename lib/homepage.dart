import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_carousel_widget/flutter_carousel_widget.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

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
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: Container(),
            ),
            SizedBox(
              height: 200,
              width: 300,
              child: FlutterCarousel(
                items: imageWidgets,
                options: CarouselOptions(
                  height: 150.0,
                  aspectRatio: 1 / 1,
                  viewportFraction: 1.0,
                  initialPage: 0,
                  enableInfiniteScroll: true,
                  reverse: false,
                  autoPlay: true,
                  autoPlayInterval: const Duration(seconds: 3),
                  autoPlayAnimationDuration: const Duration(milliseconds: 800),
                  autoPlayCurve: Curves.fastOutSlowIn,
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
                  slideIndicator: CircularSlideIndicator(
                    currentIndicatorColor: Colors.black,
                    indicatorBackgroundColor: Colors.brown,
                  ),
                ),
              ),
            ),
            Expanded(child: Container()),
            Padding(
              padding: EdgeInsets.all(16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xff889452),
                    ),
                    onPressed: () {},
                    icon: SvgPicture.asset(
                      "assets/icons/camera.svg", // Your SVG icon path
                      width: 24,
                      height: 24,
                    ),
                    label: Text(
                      "Take picture",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xff325721),
                    ),
                    onPressed: () {},
                    icon: SvgPicture.asset(
                      "assets/icons/upload_Image.svg",
                      width: 24,
                      height: 24,
                    ),
                    label: Text(
                      "Upload image",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
