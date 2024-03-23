import 'package:f2p_games/constants/colors.dart';
import 'package:f2p_games/view/widgets/my_progress_indicador_widget.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../data/http/http_client.dart';
import '../../data/repositories/game_repository.dart';
import '../../view/widgets/game_cover_widget.dart';
import '../../view/widgets/game_screenshots_widget.dart';

class GameDetailPage extends StatefulWidget {
  final String? title;
  final String? thumbnail;
  final String? releaseDate;
  final String? shortDescription;
  final String? id;
  final String? gameUrl;

  const GameDetailPage({
    Key? key,
    required this.title,
    required this.thumbnail,
    required this.releaseDate,
    required this.shortDescription,
    required this.id,
    required this.gameUrl,
  }) : super(key: key);

  @override
  State<GameDetailPage> createState() => _GameDetailPageState();
}

class _GameDetailPageState extends State<GameDetailPage> {
  final repository = GameRepository(client: HttpClient());
  late Future<Map<String, String>> _minimumSysRequirementsFuture;
  late Future<List<String>> _screenshotsFuture;

  @override
  void initState() {
    super.initState();
    _screenshotsFuture = repository.fetchScreenshots(widget.id ?? 'none');
    _minimumSysRequirementsFuture = repository.fetchMinSysRequirements(widget.id ?? 'none');
  }

  Future<void> _launchUrl() async {
    if (!await launchUrl(Uri.parse(widget.gameUrl ?? 'No link found'))) {
      throw Exception('Could not launch url');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(color: kBgColor1),
              color: Colors.black.withOpacity(0.8),
              borderRadius: BorderRadius.circular(20),
            ),
            child: IconButton(
              padding: EdgeInsets.zero,
              alignment: Alignment.center,
              icon: const Icon(Icons.arrow_back_ios_new_rounded),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ),
        ),
      ),
      body: Stack(
        children: [
          Container(
            height: double.infinity,
            color: Colors.black,
          ),
          GameCover(widget: widget),
          const Positioned.fill(
            child: DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.transparent, Colors.black, Colors.black],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  stops: [0.25, 0.35, 3],
                ),
              ),
            ),
          ),
          Positioned(
            top: MediaQuery.of(context).size.height * 0.29,
            width: MediaQuery.of(context).size.width,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.title ?? 'Not found',
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    widget.releaseDate ?? 'Not found',
                    style: const TextStyle(
                      fontSize: 12,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    widget.releaseDate ?? 'Not found',
                    style: const TextStyle(
                      fontSize: 12,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Text(
                      widget.shortDescription ?? 'Not found',
                      textAlign: TextAlign.justify,
                      maxLines: 10,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(35),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.cyanAccent.withOpacity(0.5),
                          spreadRadius: 0.05,
                          blurRadius: 10,
                          offset: const Offset(
                              0, 3), // Offset (horizontal, vertical)
                        ),
                      ],
                    ),
                    child: ElevatedButton(
                      onPressed: () {
                        _launchUrl();
                      },
                      style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all<Color>(Colors.cyan),
                          foregroundColor:
                              MaterialStateProperty.all<Color>(Colors.white),
                          shape: MaterialStateProperty.all(
                              RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20))),
                          padding: MaterialStateProperty.all(
                            const EdgeInsets.symmetric(vertical: 10.0),
                          )),
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('Play now'),
                          Icon(Icons.arrow_forward_outlined),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  const Text(
                    'Screenshots',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 10),
                  
                  // Show screenshots using ListView
                  FutureBuilder<List<String>>(
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
                  ),
                  // Show minimum system requirements
                  FutureBuilder<Map<String, String>>(
                    future: _minimumSysRequirementsFuture,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        // While data is loading, display a circular progress indicator
                        return const Center(
                            child: MyCircularProgressIndicator());
                      } else if (snapshot.hasError) {
                        // If an error occurs, display an error message
                        return const Center(
                          child: Text(
                            'Error loading system requirements',
                            style: TextStyle(color: Colors.white),
                          ),
                        );
                      } else {
                        // If data is loaded successfully, display the system requirements
                        final minSysRequirements = snapshot.data!;
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Minimum System Requirements',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            SizedBox(height: 5),
                            Text(
                              'Processor: ${minSysRequirements['Processor'] ?? 'Not found'}',
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.white,
                              ),
                            ),
                            // Add more Text widgets to display other system requirements if needed
                          ],
                        );
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
