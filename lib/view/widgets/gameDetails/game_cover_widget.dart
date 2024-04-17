import 'package:cached_network_image/cached_network_image.dart';
import 'package:f2p_games/view/widgets/my_progress_indicador_widget.dart';
import 'package:flutter/material.dart';

import '../../pages/game/game_detail_page.dart';



class GameCover extends StatelessWidget {
  const GameCover({
    super.key,
    required this.widget,
  });

  final GameDetailPage widget;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: MediaQuery.of(context).size.height * 0.35,
      child: CachedNetworkImage(
        imageUrl: widget.thumbnail ?? 'Not found',
        fit: BoxFit.fill,
        placeholder: (context, url) => Container(
          color: Colors.black,
          child: const Center(
            child: MyCircularProgressIndicator()
          ),
        ),
        errorWidget: (context, url, error) => const Icon(Icons.error),
      ),
    );
  }
}
