import 'dart:convert';

import 'package:f2p_games/data/http/exceptions.dart';
import 'package:f2p_games/data/http/http_client.dart';
import 'package:f2p_games/data/models/games_models.dart';

abstract class IGameRepository {
  Future<List<GameModel>> getGames();
}

class GameRepository implements IGameRepository {
  final IHttpClient client;

  GameRepository({required this.client});

  @override
  Future<List<GameModel>> getGames() async {
    final response =
        await client.get(url: 'https://www.freetogame.com/api/games');

    if (response.statusCode == 200) {
      final List<GameModel> games = [];
      final body = jsonDecode(response.body);
      body.map(() {}).toList().map((item) {
        final GameModel game = GameModel.fromMap(item);
        games.add(game);
      }).toList();

      return games;
    } else if (response.statusCode == 404) {
      throw NotFoundException('Invalid URL');
    } else {
      throw Exception('Impossible to load the games');
    }
  }
}
