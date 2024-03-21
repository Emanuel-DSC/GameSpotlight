import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:f2p_games/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

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
  List<String> screenshots = [];

  @override
  void initState() {
    super.initState();
    fetchScreenshots();
  }

  Future<void> fetchScreenshots() async {
    // Fetch screenshots data for the specific game using its ID
    final response = await http.get(Uri.parse('https://www.freetogame.com/api/game?id=${widget.id}'));

    if (response.statusCode == 200) {
      final List<dynamic> screenshotsData = jsonDecode(response.body)['screenshots'];
      setState(() {
        screenshots = screenshotsData.map<String>((screenshot) => screenshot['image']).toList();
      });
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
              padding: EdgeInsets.zero, // Remove padding around the icon
              alignment:
                  Alignment.center, // Center the icon within the container
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
            color: Colors.red,
          ),
          SizedBox(
            width: double.infinity,
            height: MediaQuery.of(context).size.height * 0.35,
            child: CachedNetworkImage(
              imageUrl: widget.thumbnail ?? 'Not found',
              fit: BoxFit.fill,
              placeholder: (context, url) => Container(
                color: Colors.black,
                child: Center(
                  child: CircularProgressIndicator(
                    color: Colors.red.shade900,
                    backgroundColor: Colors.orange.shade600,
                  ),
                ),
              ),
              errorWidget: (context, url, error) => const Icon(Icons.error),
            ),
          ),
          SizedBox(
            width: double.infinity,
            height: MediaQuery.of(context).size.height * 0.35,
            child: Center(
                child: Text(
              widget.id ?? 'Not found',
              style: const TextStyle(color: Colors.amber, fontSize: 34),
            )),
          ),
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
            top: MediaQuery.of(context).size.height * 0.49,
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
                  Container(
                    color: Colors.transparent,
                    height: 300,
                    width: 500,
                    child: screenshots.isEmpty
                        ? const Center(
                            child: Text(
                              'No screenshots available',
                              style: TextStyle(color: Colors.white),
                            ),
                          )
                        : ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: screenshots.length,
                            itemBuilder: (context, index) {
                              final screenshotUrl = screenshots[index];
                              return Padding(
                                padding: const EdgeInsets.only(right: 8.0),
                                child: CachedNetworkImage(
                                  imageUrl: screenshotUrl,
                                  placeholder: (context, url) => Center(
                                    child: CircularProgressIndicator(
                                      color: Colors.red.shade900,
                                      backgroundColor: Colors.orange.shade600,
                                    ),
                                  ),
                                  errorWidget: (context, url, error) =>
                                      const Icon(Icons.error),
                                ),
                              );
                            },
                          ),
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
