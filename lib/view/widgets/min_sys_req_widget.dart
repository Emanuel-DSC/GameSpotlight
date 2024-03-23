import 'package:f2p_games/view/widgets/my_progress_indicador_widget.dart';
import 'package:flutter/material.dart';

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
        } else if (snapshot.data == null ||
            snapshot.data!.isEmpty) {
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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Minimum System Requirements',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 5),
              Text(
                'Processor: ${minSysRequirements['Processor'] ?? 'Not found'}',
                style: const TextStyle(
                  fontSize: 14,
                  color: Colors.white,
                ),
              ),
              Text(
                'Os: ${minSysRequirements['Os'] ?? 'Not found'}',
                style: const TextStyle(
                  fontSize: 14,
                  color: Colors.white,
                ),
              ),
              Text(
                'Memory: ${minSysRequirements['Memory'] ?? 'Not found'}',
                style: const TextStyle(
                  fontSize: 14,
                  color: Colors.white,
                ),
              ),
              Text(
                'Graphics: ${minSysRequirements['Graphics'] ?? 'Not found'}',
                style: const TextStyle(
                  fontSize: 14,
                  color: Colors.white,
                ),
              ),
              Text(
                'Storage: ${minSysRequirements['Storage'] ?? 'Not found'}',
                style: const TextStyle(
                  fontSize: 14,
                  color: Colors.white,
                ),
              ),
              // Add more Text widgets to display other system requirements if needed
            ],
          );
        }
      },
    );
  }
}
