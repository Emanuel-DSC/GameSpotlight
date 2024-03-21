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
    try {
      final response = await client.get(url: 'https://www.freetogame.com/api/games');
      print('API Response: ${response.body}');

      if (response.statusCode == 200) {
        final List<GameModel> games = [];
        final body = jsonDecode(response.body);
        body.forEach((item) {
          final GameModel game = GameModel.fromMap(item);
          games.add(game);
        });

        print('Parsed Games: $games');

        return games;
      } else if (response.statusCode == 404) {
        throw NotFoundException('Invalid URL');
      } else {
        throw Exception('Impossible to load the games');
      }
    } catch (e) {
      print('Error fetching games: $e');
      rethrow; // Rethrow the caught error
    }
  }
}
