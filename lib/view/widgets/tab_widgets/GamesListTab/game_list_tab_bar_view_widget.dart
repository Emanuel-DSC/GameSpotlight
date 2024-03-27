import 'package:f2p_games/view/pages/stores/games_store.dart';
import 'package:f2p_games/view/widgets/my_progress_indicador_widget.dart';
import 'package:flutter/material.dart';

import '../../../../data/models/games_models.dart';
import '../../games_list_widget.dart';

class GameListTabView {
  final GameStore store;

  GameListTabView(this.store);

  Widget buildGamesListFutureBuilder(Future<List<GameModel>> Function() getGamesFunction) {
    return FutureBuilder<List<GameModel>>(
      future: getGamesFunction(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const MyCircularProgressIndicator(); // Placeholder while loading
        }
        if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        }
        if (snapshot.hasData) {
          return GamesList(store: store, state: const [],);
        }
        return const MyCircularProgressIndicator();
      },
    );
  }
}
