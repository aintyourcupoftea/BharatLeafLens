import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:bharat_leaf_lens/pages/plantNotFound.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:image/image.dart' as img;
import 'package:lottie/lottie.dart';

import 'plant_info.dart'; // Import the plant information page

class Results extends StatefulWidget {
  final File image;
  const Results({Key? key, required this.image}) : super(key: key);

  @override
  _ResultsState createState() => _ResultsState();
}

class _ResultsState extends State<Results> {
  bool isLoading = true;
  String error = ''; // Add error message variable

  List<dynamic>? apiResponseList;
  late String firstLabel;
  late double firstScoreDouble;
  late String secondLabel;
  late double secondScoreDouble;
  late String thirdLabel;
  late double thirdScoreDouble;

  @override
  void initState() {
    super.initState();
    startImageProcessing();
  }

  Future<void> startImageProcessing() async {
    setState(() {
      isLoading = true;
      error = ''; // Clear any previous error messages
    });

    try {
      List<int> imageBytes = await widget.image.readAsBytes();
      img.Image? image = img.decodeImage(imageBytes);

      // Resize the image if necessary
      if (image!.width > 1080 || image.height > 1080) {
        image = await resizeImage(image);
        imageBytes = img.encodeJpg(image!);
      }

      await predictImage(imageBytes);
    } catch (e) {
      // Handle any errors during image processing
      setState(() {
        isLoading = false;
        error = 'Error processing image: ${e.toString()}';
      });
    }
  }

  Future<img.Image?> resizeImage(img.Image image) async {
    int newWidth = image.width;
    int newHeight = image.height;

    // Determine the scaling factor based on the larger dimension
    double scale = 1080 / (newWidth > newHeight ? newWidth : newHeight);

    // Calculate new dimensions while maintaining aspect ratio
    newWidth = (newWidth * scale).toInt();
    newHeight = (newHeight * scale).toInt();

    // Resize the image
    return img.copyResize(image, width: newWidth, height: newHeight);
  }

  Future<void> predictImage(List<int> imageBytes) async {
    const apiUrl =
        "https://api-inference.huggingface.co/models/dima806/medicinal_plants_image_detection";
    final headers = {
      "Authorization": "Bearer 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",
    };

    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: headers,
        body: imageBytes,
      );

      if (response.statusCode == 200) {
        final dynamic responseData = jsonDecode(response.body);
        if (responseData is List<dynamic>) {
          setState(() {
            apiResponseList = responseData;
            firstLabel = apiResponseList?[0]['label'];
            firstScoreDouble =
                apiResponseList?[0]['score'] * 100.roundToDouble();
            secondLabel = apiResponseList?[1]['label'];
            secondScoreDouble =
                apiResponseList?[1]['score'] * 100.roundToDouble();
            thirdLabel = apiResponseList?[2]['label'];
            thirdScoreDouble =
                apiResponseList?[2]['score'] * 100.roundToDouble();
            isLoading = false;
          });

          if (firstScoreDouble < 20) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => PlantNotFound()),
            );
          }
        } else {
          throw Exception('Invalid API response format');
        }
      } else {
        throw Exception(
            'API request failed with status code: ${response.statusCode}');
      }
    } catch (e) {
      // Handle API call errors
      setState(() {
        isLoading = false;
        error = 'Error predicting image: ${e.toString()}';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Plant Prediction Results',
          style: GoogleFonts.merriweather(),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: SvgPicture.asset(
            'assets/icons/close_icon.svg',
            height: 21,
            width: 21,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Center(
        child: isLoading
            ? Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Lottie.asset('assets/icons/loading.json'),
            const SizedBox(height: 16),
            Text(
              'Leaf Me Alone, I\'m Thinking...',
              style: GoogleFonts.baloo2(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                fontStyle: FontStyle.italic,
              ),
            ),
          ],
        )
            : error.isNotEmpty
            ? Text(
          'Error occurred! Please try again: $error',
          style: TextStyle(color: Colors.red, fontSize: 16),
        )
            : Column(
          children: [
            Container(
              width: 300,
              height: 300,
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.black,
                  width: 2,
                ),
              ),
              child: Image.file(
                widget.image,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 12),
            const Text(
              'Confidences in Percentage :',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                fontStyle: FontStyle.italic,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 12),
            buildPlantNameCard(firstLabel, firstScoreDouble),
            buildPlantNameCard(secondLabel, secondScoreDouble),
            buildPlantNameCard(thirdLabel, thirdScoreDouble),
          ],
        ),
      ),
    );
  }

  Widget buildPlantNameCard(String label, double score) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => PlantInformationPage(plantName: label),
            ),
          );
        },
        child: Card(
          elevation: 3,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          color: score >= 70 ? Color(0xFFC8E6C9) : score >= 40 ? Color(0xFFFFF9C4) : Color(0xFFFFCDD2),
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded( // Expanded to allow text wrapping
                  child: Text(
                    label,
                    style: GoogleFonts.roboto( // Modern font choice
                      fontWeight: FontWeight.w500,
                      fontSize: 16,
                      color:  score >= 70 ? Color(0xFF2E7D32) : score >= 40 ? Color(0xFF8D6E63) : Color(0xFFB71C1C), // Color based on score
                    ),
                  ),
                ),
                SizedBox(width: 16),
                Text(
                  '${score.toStringAsFixed(2)}%',
                  style: GoogleFonts.roboto(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color:  score >= 70 ? Color(0xFF2E7D32) : score >= 40 ? Color(0xFF8D6E63) : Color(0xFFB71C1C), // Color based on score
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
