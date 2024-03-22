import 'dart:convert';

import 'package:f2p_games/constants/colors.dart';
import 'package:f2p_games/view/widgets/my_progress_indicador_widget.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../../view/widgets/game_cover_widget.dart';
import '../../view/widgets/game_screenshots_widget.dart';

class GameDetailPage extends StatefulWidget {
  final String? title;
  final String? thumbnail;
  final String? releaseDate;
  final String? shortDescription;
  final String? id;

  const GameDetailPage({
    Key? key,
    required this.title,
    required this.thumbnail,
    required this.releaseDate,
    required this.shortDescription,
    required this.id,
  }) : super(key: key);

  @override
  State<GameDetailPage> createState() => _GameDetailPageState();
}

class _GameDetailPageState extends State<GameDetailPage> {
  late Future<List<String>> _screenshotsFuture;

  @override
  void initState() {
    super.initState();
    _screenshotsFuture = fetchScreenshots();
  }

  Future<List<String>> fetchScreenshots() async {
    // Fetch screenshots data for the specific game using its ID
    final response = await http.get(Uri.parse('https://www.freetogame.com/api/game?id=${widget.id}'));

    if (response.statusCode == 200) {
      final List<dynamic> screenshotsData = jsonDecode(response.body)['screenshots'];
      return screenshotsData.map<String>((screenshot) => screenshot['image']).toList();
    } else {
      throw Exception('Impossible to load screenshots');
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
                          child: MyCircularProgressIndicator()
                        );
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
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}



