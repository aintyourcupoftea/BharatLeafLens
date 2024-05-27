import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PlantInformationPage extends StatelessWidget {
  final String plantName;

  const PlantInformationPage({Key? key, required this.plantName}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _loadPlantData(context),
      builder: (context, AsyncSnapshot<List<dynamic>> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Color(0xFFA1887F)), // More earthy tone
            ),
          );
        }
        if (snapshot.hasError || !snapshot.hasData) {
          return _buildErrorScreen();
        }

        final plantData = snapshot.data!;
        final currentPlantData = plantData.firstWhere(
              (plant) => plant['name'] == plantName,
          orElse: () => null,
        );

        if (currentPlantData == null) {
          return _buildErrorScreen(message: 'Plant not found');
        }

        return Scaffold(
          backgroundColor: Color(0xFFF9F8F8), // Slightly off-white for warmth
          appBar: AppBar(
            leading: IconButton(
              icon: Icon(Icons.arrow_back, color: Colors.white),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            title: Text(
              'Plant Information',
              style: GoogleFonts.lora( // More stylized font for title
                fontSize: 24,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
            centerTitle: true,
            backgroundColor: Color(0xFF33691E), // Richer, deeper green
            elevation: 0,
          ),
          body: SingleChildScrollView(
            padding: EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Text(
                    currentPlantData['name'],
                    style: GoogleFonts.montserrat( // Modern yet readable font
                      fontSize: 32,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF33691E),
                    ),
                  ),
                ),
                SizedBox(height: 30),
                _buildSection('Scientific Name', currentPlantData['scientific_name']),
                _buildSection('Family', currentPlantData['family']),
                _buildDescriptionSection(currentPlantData['description']),
                _buildPropertySection('Medicinal Properties', currentPlantData['medicinal_properties']),
                SizedBox(height: 40), // More bottom spacing
              ],
            ),
          ),
        );
      },
    );
  }

  // Helper function to build the error screen
  Widget _buildErrorScreen({String message = 'Error loading data'}) {
    return Scaffold(
      appBar: AppBar(title: Text("Plant Info"), centerTitle: true),
      body: Center(child: Text(message)),
    );
  }

  Widget _buildSection(String title, String content) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: GoogleFonts.roboto(
            fontSize: 18,
            fontWeight: FontWeight.w500,
            color: Color(0xFF5D4037), // Dark brown for titles
          ),
        ),
        SizedBox(height: 8),
        Text(
          content,
          style: GoogleFonts.roboto(fontSize: 16),
        ),
        SizedBox(height: 20),
      ],
    );
  }

  // Separate section for Description to customize styling
  Widget _buildDescriptionSection(String description) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Description',
          style: GoogleFonts.roboto(
            fontSize: 18,
            fontWeight: FontWeight.w500,
            color: Color(0xFF5D4037),
          ),
        ),
        SizedBox(height: 8),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Text(
            description,
            style: GoogleFonts.roboto(fontSize: 16),
            textAlign: TextAlign.justify,
          ),
        ),
        SizedBox(height: 20),
      ],
    );
  }

  Widget _buildPropertySection(String title, List<dynamic> properties) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: GoogleFonts.roboto(
            fontSize: 18,
            fontWeight: FontWeight.w500,
            color: Color(0xFF5D4037),
          ),
        ),
        SizedBox(height: 12),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: properties.map((property) =>
                Padding(
                  padding: const EdgeInsets.only(bottom: 6.0),
                  child: Text("•  $property", style: GoogleFonts.roboto(fontSize: 16)),
                )
            ).toList(),
          ),
        ),
      ],
    );
  }

  Future<List<dynamic>> _loadPlantData(BuildContext context) async {
    final jsonString =
    await DefaultAssetBundle.of(context).loadString('assets/plantinfo/plant_data.json');
    return json.decode(jsonString);
  }
}