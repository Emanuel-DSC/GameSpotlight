import 'package:f2p_games/view/widgets/my_progress_indicador_widget.dart';
import 'package:flutter/material.dart';

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
                    child: Image.network(
                      screenshotUrl,
                      height: 60,
                      width: 300,
                      fit: BoxFit.cover,
                      loadingBuilder: (BuildContext context, Widget child,
                          ImageChunkEvent? loadingProgress) {
                        if (loadingProgress == null) {
                          return child;
                        } else {
                          return const Center(
                            child: SizedBox(
                                height: 50,
                                width: 50,
                                child: MyCircularProgressIndicator()),
                          );
                        }
                      },
                      errorBuilder: (BuildContext context, Object error,
                          StackTrace? stackTrace) {
                        return Container(
                            color: Colors.red,
                            height: 60,
                            width: 300,
                            child: const Center(
                                child: Icon(Icons.error_outline,
                                    color: Colors.white)));
                      },
                    ),
                  ),
                );
              },
            ),
    );
  }
}
