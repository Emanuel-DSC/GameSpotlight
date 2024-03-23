import 'dart:convert';
import 'package:f2p_games/data/http/exceptions.dart';
import 'package:f2p_games/data/http/http_client.dart';
import 'package:f2p_games/data/models/games_models.dart';

abstract class IGameRepository {
  Future<List<GameModel>> getGames();
  Future<List<String>> fetchScreenshots(String gameId);
}

class GameRepository implements IGameRepository {
  final IHttpClient client;

  GameRepository({required this.client});

  @override
  Future<List<GameModel>> getGames() async {
    try {
      final response =
          await client.get(url: 'https://www.freetogame.com/api/games');

      if (response.statusCode == 200) {
        final List<GameModel> games = [];
        final body = jsonDecode(response.body);
        body.forEach((item) {
          final GameModel game = GameModel.fromMap(item);
          games.add(game);
        });

        return games;
      } else if (response.statusCode == 404) {
        throw NotFoundException('Invalid URL');
      } else {
        throw Exception('Impossible to load the games');
      }
    } catch (e) {
      rethrow; // Rethrow the caught error
    }
  }

  // fetch LIST of images
  @override
  Future<List<String>> fetchScreenshots(String gameId) async {
    try {
      final response = await client.get(
          url: 'https://www.freetogame.com/api/game?id=$gameId');

      if (response.statusCode == 200) {
        final List<dynamic> screenshotsData =
            jsonDecode(response.body)['screenshots'];
        return screenshotsData
            .map<String>((screenshot) => screenshot['image'])
            .toList();
      } else {
        throw Exception('Impossible to load screenshots');
      }
    } catch (e) {
      rethrow; // Rethrow the caught error
    }
  }

  // fetch JSON 
  Future<Map<String, String>> fetchMinSysRequirements(String gameId) async {
    try {
      final response = await client.get(
          url: 'https://www.freetogame.com/api/game?id=$gameId');

      if (response.statusCode == 200) {
        final Map<String, dynamic> gameData = jsonDecode(response.body);
        final Map<String, String> minimumSysRequirements = {
          'os': gameData['minimum_system_requirements']['os'],
          'processor': gameData['minimum_system_requirements']['processor'],
          'memory': gameData['minimum_system_requirements']['memory'],
          'graphics': gameData['minimum_system_requirements']['graphics'],
          'storage': gameData['minimum_system_requirements']['storage'],
        };
        return minimumSysRequirements;
      } else {
        throw Exception('Impossible to load minimum system requirements');
      }
    } catch (e) {
      rethrow; // Rethrow the caught error
    }
  }
}
