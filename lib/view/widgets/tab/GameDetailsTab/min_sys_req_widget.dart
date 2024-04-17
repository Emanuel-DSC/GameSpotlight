import 'package:f2p_games/view/widgets/my_progress_indicador_widget.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../text/my_text.widget.dart';

class MinSysReqList extends StatelessWidget {
  const MinSysReqList({
    super.key,
    required Future<Map<String, String>> minimumSysRequirementsFuture,
  }) : _minimumSysRequirementsFuture = minimumSysRequirementsFuture;

  final Future<Map<String, String>> _minimumSysRequirementsFuture;

  @override
  // Show minimum system requirements
  Widget build(BuildContext context) {
    return FutureBuilder<Map<String, String>>(
      future: _minimumSysRequirementsFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          // While data is loading, display a circular progress indicator
          return const Center(child: MyCircularProgressIndicator());
        } else if (snapshot.hasError) {
          // If an error occurs, display an error message
          return const Center(
            child: Text(
              'Error loading system requirements',
              style: TextStyle(color: Colors.white),
            ),
          );
        } else if (snapshot.data == null || snapshot.data!.isEmpty) {
          // If no data or empty data is returned, display a message indicating that system requirements are not available
          return const Center(
            child: Text(
              'System requirements not available',
              style: TextStyle(color: Colors.white),
            ),
          );
        } else {
          // If data is loaded successfully, display the system requirements
          final minSysRequirements = snapshot.data!;
          return Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 5),
              MyText(
                title:
                    'Processor: ${minSysRequirements['Processor'] ?? 'Not found'}',
                fontSize: 14.0,
                googleFont: GoogleFonts.roboto,
                color: Colors.white,
                weight: FontWeight.bold,
              ),
              const SizedBox(height: 5),
              MyText(
                title: 'Os: ${minSysRequirements['Os'] ?? 'Not found'}',
                fontSize: 14.0,
                googleFont: GoogleFonts.roboto,
                color: Colors.white,
                weight: FontWeight.bold,
              ),
              const SizedBox(height: 5),
              MyText(
                title: 'Memory: ${minSysRequirements['Memory'] ?? 'Not found'}',
                fontSize: 14.0,
                googleFont: GoogleFonts.roboto,
                color: Colors.white,
                weight: FontWeight.bold,
              ),
              const SizedBox(height: 5),
              MyText(
                title:
                    'Graphics: ${minSysRequirements['Graphics'] ?? 'Not found'}',
                fontSize: 14.0,
                googleFont: GoogleFonts.roboto,
                color: Colors.white,
                weight: FontWeight.bold,
              ),
              const SizedBox(height: 5),
              MyText(
                title:
                    'Storage: ${minSysRequirements['Storage'] ?? 'Not found'}',
                fontSize: 14.0,
                googleFont: GoogleFonts.roboto,
                color: Colors.white,
                weight: FontWeight.bold,
              ),
            ],
          );
        }
      },
    );
  }
}
