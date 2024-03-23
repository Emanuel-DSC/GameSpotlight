import 'package:f2p_games/view/widgets/game_screenshots_widget.dart';
import 'package:flutter/material.dart';

import 'my_progress_indicador_widget.dart';

class ScreenshotsList extends StatelessWidget {
  const ScreenshotsList({
    super.key,
    required Future<List<String>> screenshotsFuture,
  }) : _screenshotsFuture = screenshotsFuture;

  final Future<List<String>> _screenshotsFuture;

  @override
  Widget build(BuildContext context) {
    // Show screenshots using ListView
    return FutureBuilder<List<String>>(
      future: _screenshotsFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          // While data is loading, display a circular progress indicator
          return const Center(
              child: MyCircularProgressIndicator());
        } else if (snapshot.hasError) {
          // If an error occurs, display an error message
          return const Center(
            child: Text(
              'Error loading screenshots',
              style: TextStyle(color: Colors.white),
            ),
          );
        } else {
          // If data is loaded successfully, display the screenshots
          final screenshots = snapshot.data!;
          return GameScreenshots(screenshots: screenshots);
        }
      },
    );
  }
}

