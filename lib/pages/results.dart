import 'dart:async';
import 'package:image/image.dart' as img;
import 'package:flutter_rounded_progress_bar/rounded_progress_bar_style.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart'; // Import Lottie package
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_rounded_progress_bar/flutter_rounded_progress_bar.dart';
import 'dart:io';
import 'dart:typed_data';


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
  bool isLoading = true; // Add a boolean to track loading state

  // Declare these variables outside of initState or setState
  String firstLabel = '';
  String secondLabel = '';
  String thirdLabel = '';

  double firstScoreDouble = 0.0;
  double secondScoreDouble = 0.0;
  double thirdScoreDouble = 0.0;

  @override
  void initState() {
    super.initState();
    startImageProcessing(); // Call the function to start image processing
  }

  Future<void> startImageProcessing() async {
    // Start loading animation
    setState(() {
      isLoading = true;
    });

    // Prepare the image data
    List<int> imageBytes = await widget.image.readAsBytes();
    img.Image? image = img.decodeImage(imageBytes);
    // Print the size of the original image
    // print('Original Image Size: ${imageBytes.length / 1024} kilobytes');

    if (image!.width > 1080 || image.height > 1080) {
      // Resize the image asynchronously
      image = await resizeImage(image);
      // Encode the resized image back to bytes
      imageBytes = img.encodeJpg(image!);
      // Print a message indicating that the image is resized
      // print('Image resized: ${image.width}x${image.height}');

      // Print the size of the resized image
      // print('Resized Image Size: ${imageBytes.length / 1024} kilobytes');
    }

    // Call the function to make the API request
    await predictImage(imageBytes);
  }

  Future<img.Image?> resizeImage(img.Image image) async {
    // Resize the image to half of its original resolution
    return await Future(() => img.copyResize(
      image,
      width: image.width ~/ 2,
      height: image.height ~/ 2,
    ));
  }

  Future<void> predictImage(List<int> imageBytes) async {
    const apiUrl =
        "https://api-inference.huggingface.co/models/dima806/medicinal_plants_image_detection";
    final headers = {
      "Authorization": "Bearer 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",
    };

    // Make the API request
    final response = await http.post(
      Uri.parse(apiUrl),
      headers: headers,
      body: imageBytes,
    );

    if (response.statusCode == 200) {
      final dynamic responseData = jsonDecode(response.body);
      if (responseData is List<dynamic>) {
        // Handle list response, if applicable
        print('Response is a list: $responseData');
        setState(() {
          apiResponseList = responseData;
          firstLabel = apiResponseList?[0]['label'];
          firstScoreDouble = apiResponseList?[0]['score'] * 100.roundToDouble();
          secondLabel = apiResponseList?[1]['label'];
          secondScoreDouble =
              apiResponseList?[1]['score'] * 100.roundToDouble();
          thirdLabel = apiResponseList?[2]['label'];
          thirdScoreDouble = apiResponseList?[2]['score'] * 100.roundToDouble();
          this.label = label;
          this.confidence = confidence;
          isLoading = false;
        });
      } else if (responseData is Map<String, dynamic>) {
        // Handle map response
        final String label = responseData['label'];
        final double confidence =
        double.parse(responseData['confidence'].toString());

        setState(() {
          this.label = label;
          this.confidence = confidence;
          isLoading = false; // Set isLoading to false here
        });
      } else {
        // Handle errors
        setState(() {
          isLoading = false; // Set isLoading to false to stop loading indicator
        });

        // Show alert dialog
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('Error'),
              content: const Text('Failed to get results. Please try again.'),
              actions: [
                TextButton(
                  child: const Text('OK'),
                  onPressed: () {
                    Navigator.of(context).pop(); // Close the dialog
                  },
                ),
              ],
            );
          },
        );
      }
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
          icon: const Icon(Icons.close_rounded),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Center(
        child: isLoading
            ? Lottie.asset('assets/icons/loading.json')
            : Column(
          children: [
            Container(
              // Image container placed at the top
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
              // "Confidence Percent" text below the image
              'Confidences in Percentage :',
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  fontStyle: FontStyle.italic),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 12),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40.00),
              child: RoundedProgressBar(
                style: RoundedProgressBarStyle(
                  borderWidth: 2,
                  widthShadow: 3,
                  colorProgress: const Color(0xFF4CAF50), // Green color for progress
                  colorProgressDark: const Color(0xFF388E3C), // Darker green for shadow
                  backgroundProgress: const Color(0xFFF1F8E9), // Light green background
                ),
                margin: const EdgeInsets.symmetric(vertical: 8),
                borderRadius: BorderRadius.circular(24),
                percent:
                firstScoreDouble, // Use the calculated percentage
                height: 40,
                childCenter: Text(
                  '$firstLabel: ${firstScoreDouble.toStringAsFixed(2)}%',
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40.00),
              child: RoundedProgressBar(
                style: RoundedProgressBarStyle(
                  borderWidth: 2,
                  widthShadow: 3,
                  colorProgress: const Color(0xFF4CAF50), // Green color for progress
                  colorProgressDark: const Color(0xFF388E3C), // Darker green for shadow
                  backgroundProgress: const Color(0xFFF1F8E9), // Light green background
                ),
                margin: const EdgeInsets.symmetric(vertical: 8),
                borderRadius: BorderRadius.circular(24),
                percent: secondScoreDouble,
                height: 40,
                childCenter: Text(
                  '$secondLabel: ${secondScoreDouble.toStringAsFixed(2)}%',
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40.00),
              child: RoundedProgressBar(
                style: RoundedProgressBarStyle(
                  borderWidth: 2,
                  widthShadow: 3,
                  colorProgress: const Color(0xFF4CAF50), // Green color for progress
                  colorProgressDark: const Color(0xFF388E3C), // Darker green for shadow
                  backgroundProgress: const Color(0xFFF1F8E9), // Light green background
                ),
                margin: const EdgeInsets.symmetric(vertical: 8),
                borderRadius: BorderRadius.circular(24),
                percent: thirdScoreDouble,
                height: 40,
                childCenter: Text(
                  '$thirdLabel: ${thirdScoreDouble.toStringAsFixed(2)}%',
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
