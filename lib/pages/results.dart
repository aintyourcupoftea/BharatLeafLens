import 'dart:io';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter_tflite/flutter_tflite.dart'; // Import flutter_tflite package
import 'dart:developer' as devtools;

class ResultsPage extends StatefulWidget {
  final File image;

  const ResultsPage({super.key, required this.image});

  @override
  State<ResultsPage> createState() => _ResultsPageState();
}

class _ResultsPageState extends State<ResultsPage> {
  File? filePath; // Variable to store the file path
  String label = '';
  double confidence = 0.0;

  @override
  void initState() {
    super.initState();
    _tfLiteInit(); // Initialize flutter_tflite
    _storeFilePath(); // Call the function to store the file path
  }

  Future<void> _tfLiteInit() async {
    String? res = await Tflite.loadModel(
        model: "assets/model/better.tflite",
        labels: "assets/model/better.txt",
        numThreads: 1, // defaults to 1
        isAsset:
            true, // defaults to true, set to false to load resources outside assets
        useGpuDelegate:
            false // defaults to false, set to true to use GPU delegate
        );
  }

  Future<void> _storeFilePath() async {
    final directory = await getApplicationDocumentsDirectory();
    final fileName = DateTime.now().millisecondsSinceEpoch.toString();
    filePath = await widget.image.copy('${directory.path}/$fileName');
    var imageMap = File(filePath!.path);
    setState(
      () {
        filePath = imageMap;
      },
    );
    var recognitions = await Tflite.runModelOnImage(
        path: filePath!.path, // required
        imageMean: 0.0, // defaults to 117.0
        imageStd: 255.0, // defaults to 1.0
        numResults: 2, // defaults to 5
        threshold: 0.2, // defaults to 0.1
        asynch: true // defaults to true
        );
    if (recognitions == null) {
      devtools.log("recognitions is Null");
      return;
    }
    devtools.log(recognitions.toString());
    setState(
      () {
        confidence = (recognitions[0]['confidence'] * 100);
        label = recognitions[0]['label'].toString();
      },
    );
  }

  @override
  void dispose() {
    // Dispose flutter_tflite when the widget is disposed
    Tflite.close();
    // Delete the file when the widget is disposed (when navigating back)
    if (filePath != null) {
      filePath!.delete();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text('Results'),
          centerTitle: true,
          leading: IconButton(
            icon: const Icon(Icons.close_rounded),
            onPressed: () {
              Navigator.pop(context);
            },
          )),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 300, // Adjust the width as needed
              height: 300, // Adjust the height as needed
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
            Text(
              'Plant Name: $label',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(
              'The Accuracy is: ${(confidence).toStringAsFixed(0)}%',
              style: const TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
