import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_rounded_progress_bar/flutter_rounded_progress_bar.dart';
import 'package:flutter_rounded_progress_bar/rounded_progress_bar_style.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:image/image.dart' as img;
import 'package:lottie/lottie.dart';
import 'plantNotFound.dart';

List<dynamic>? apiResponseList;

class Results extends StatefulWidget {
  final File image;
  const Results({Key? key, required this.image}) : super(key: key);

  @override
  _Results createState() => _Results();
}

class _Results extends State<Results> {
  String label = '';
  double confidence = 0.0;
  bool isLoading = true;
  String error = ''; // Add error message variable

  String firstLabel = '';
  String secondLabel = '';
  String thirdLabel = '';

  double firstScoreDouble = 0.0;
  double secondScoreDouble = 0.0;
  double thirdScoreDouble = 0.0;

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
            const Text('Processing Image...',
                style: TextStyle(fontSize: 16)),
          ],
        )
            : error.isNotEmpty
            ? Text('Error: $error',
            style: TextStyle(
                color: Colors.red, fontSize: 16))
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
                  fontStyle: FontStyle.italic),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 12),
            buildProgressBar(firstLabel, firstScoreDouble),
            buildProgressBar(secondLabel, secondScoreDouble),
            buildProgressBar(thirdLabel, thirdScoreDouble),
          ],
        ),
      ),
    );
  }

  // Helper function to create progress bars
  Widget buildProgressBar(String label, double score) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40.00),
      child: RoundedProgressBar(
        style: RoundedProgressBarStyle(
          borderWidth: 2,
          widthShadow: 3,
          colorProgress: const Color(0xFF4CAF50),
          colorProgressDark: const Color(0xFF388E3C),
          backgroundProgress: const Color(0xFFF1F8E9),
        ),
        margin: const EdgeInsets.symmetric(vertical: 8),
        borderRadius: BorderRadius.circular(24),
        percent: score,
        height: 40,
        childCenter: Text(
          '$label: ${score.toStringAsFixed(2)}%',
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}