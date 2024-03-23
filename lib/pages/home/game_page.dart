import 'dart:ui';

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
  final String? genre;
  final String? publisher;

  const GameDetailPage({
    Key? key,
    required this.title,
    required this.thumbnail,
    required this.releaseDate,
    required this.shortDescription,
    required this.id,
    required this.gameUrl,
    required this.genre,
    required this.publisher,
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
    _minimumSysRequirementsFuture =
        repository.fetchMinSysRequirements(widget.id ?? 'none');
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
          child: ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: BackdropFilter(
              filter: ImageFilter.blur(
                sigmaX: 100.0,
                sigmaY: 100.0,
              ),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.grey.withOpacity(0.1),
                  border: Border.all(color: Colors.grey.withOpacity(0.1)),
                  borderRadius: BorderRadius.circular(12),
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
        ),
      ),
      body: Stack(
        children: [
          Container(
            height: double.infinity,
            color: Colors.black,
          ),
          GameCover(widget: widget),
          Positioned.fill(
            child: DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.transparent, kBgColor1, kBgColor1],
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
                    widget.genre ?? 'Not found',
                    style: const TextStyle(
                      fontSize: 12,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    widget.publisher ?? 'Not found',
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
                      gradient: LinearGradient(
                        colors: [kButtonColor1, kButtonColor2],
                        begin: Alignment.bottomLeft,
                        end: Alignment.topRight,
                        stops: const [0.3, 0.7],
                      ),
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: kButtonColor1.withOpacity(0.5),
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
                          backgroundColor: MaterialStateProperty.all<Color>(
                              Colors.transparent),
                          foregroundColor:
                              MaterialStateProperty.all<Color>(Colors.white),
                          shape: MaterialStateProperty.all(
                              RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12))),
                          padding: MaterialStateProperty.all(
                            const EdgeInsets.symmetric(vertical: 12.0),
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
                        return Center(child: MyCircularProgressIndicator());
                      } else if (snapshot.hasError) {
                        // If an error occurs, display an error message
                        return Center(
                          child: Text(
                            'Error loading system requirements',
                            style: TextStyle(color: Colors.white),
                          ),
                        );
                      } else if (snapshot.data == null ||
                          snapshot.data!.isEmpty) {
                        // If no data or empty data is returned, display a message indicating that system requirements are not available
                        return Center(
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
