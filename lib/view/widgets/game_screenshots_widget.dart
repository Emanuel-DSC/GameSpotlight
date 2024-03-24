import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import 'my_progress_indicador_widget.dart';

class GameScreenshots extends StatelessWidget {
  const GameScreenshots({
    Key? key,
    required this.screenshots,
  }) : super(key: key);

  final List<String> screenshots;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.transparent,
      height: 170,
      width: double.infinity,
      child: screenshots.isEmpty
          ? const Center(
              child: Text(
                'No screenshots available',
                style: TextStyle(color: Colors.white),
              ),
            )
          : ListView.builder(
              physics: const BouncingScrollPhysics(),
              scrollDirection: Axis.horizontal,
              itemCount: screenshots.length,
              itemBuilder: (context, index) {
                final screenshotUrl = screenshots[index];
                return Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: ClipRRect(
                    borderRadius: const BorderRadius.all(Radius.circular(12)),
                    child: CachedNetworkImage(
                      height: 60, 
                      width: 300, 
                      fit: BoxFit.cover, 
                      imageUrl: screenshotUrl,
                      placeholder: (context, url) => const Center(
                        child: SizedBox(
                          height: 25,
                          width: 25,
                          child: MyCircularProgressIndicator()),
                      ),
                      errorWidget: (context, url, error) =>
                          const Icon(Icons.error),
                    ),
                  ),
                );
              },
            ),
    );
  }
}
