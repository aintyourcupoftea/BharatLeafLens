import 'dart:async';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart'; // Import Lottie package
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'dart:io';

List<dynamic>? apiResponseList;

class ResultsPage extends StatefulWidget {

  final File image;
  const ResultsPage({Key? key, required this.image}) : super(key: key);

  @override
  _ResultsPageState createState() => _ResultsPageState();
}

class _ResultsPageState extends State<ResultsPage> {
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
    predictImage(); // Call the API prediction function
  }

  Future<void> predictImage() async {
    const apiUrl = "https://api-inference.huggingface.co/models/dima806/medicinal_plants_image_detection";
    final headers = {
      "Authorization": "Bearer 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",
    };

    // Prepare the image data
    final imageBytes = await widget.image.readAsBytes();

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
          secondScoreDouble = apiResponseList?[1]['score'] * 100.roundToDouble();
          thirdLabel = apiResponseList?[2]['label'];
          thirdScoreDouble = apiResponseList?[2]['score'] * 100.roundToDouble();
          this.label = label;
          this.confidence = confidence;
          isLoading = false;
        });
      } else if (responseData is Map<String, dynamic>) {
        // Handle map response
        final String label = responseData['label'];
        final double confidence = double.parse(responseData['confidence'].toString());

        setState(() {
          this.label = label;
          this.confidence = confidence;
          isLoading = false; // Set isLoading to false here
        });
      } else {
        // Handle unexpected response format
        throw Exception('Unexpected response format: $responseData');
      }
    } else {
      // Handle errors
      throw Exception('Failed to get results. Status code: ${response.statusCode}');
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Plant Prediction Results', style: GoogleFonts.merriweather(),),
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
            Container( // Image container placed at the top
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
            const Text( // "Confidence Percent" text below the image
              'Confidences in Percentage :',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, fontStyle: FontStyle.italic),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 12),
            Text( // "Confidence Percent" text below the image
              '$firstLabel : ${firstScoreDouble.toStringAsFixed(2)}',
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
              textAlign: TextAlign.center,
            ),
            Text( // "Confidence Percent" text below the image
              '$secondLabel : ${secondScoreDouble.toStringAsFixed(2)}',
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
              textAlign: TextAlign.center,
            ),
            Text( // "Confidence Percent" text below the image
              '$thirdLabel : ${thirdScoreDouble.toStringAsFixed(2)}',
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
