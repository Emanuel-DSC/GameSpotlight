import 'dart:convert';
import 'package:f2p_games/data/http/exceptions.dart';
import 'package:f2p_games/data/http/http_client.dart';
import 'package:f2p_games/data/models/games_models.dart';

abstract class IGameRepository {
  Future<List<GameModel>> getEveryGame();
  Future<List<GameModel>> getGames(String sorting);
  Future<List<GameModel>> getGamesGenres(String sorting);
  Future<List<String>> fetchScreenshots(String gameId);
}

class GameRepository implements IGameRepository {
  final IHttpClient client;

  GameRepository({required this.client});

  // fetch games and pass variable of sorting
  @override
  Future<List<GameModel>> getGames(String sorting) async {
    try {
      final response =
          await client.get(url: 'https://www.freetogame.com/api/games?sort-by=$sorting');

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
  
  // fetch every games 
  @override
  Future<List<GameModel>> getEveryGame() async {
    try {
      final response =
          await client.get(url:'https://www.freetogame.com/api/games');

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

  // fetch genres
  @override
  Future<List<GameModel>> getGamesGenres(String sorting) async {
    try {
      final response =
          await client.get(url: 'https://www.freetogame.com/api/games?category=$sorting');

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

  // fetch system required JSON
  Future<Map<String, String>> fetchMinSysRequirements(String gameId) async {
    try {
      final response = await client.get(
          url: 'https://www.freetogame.com/api/game?id=$gameId');

      if (response.statusCode == 200) {
        final Map<String, dynamic> gameData = jsonDecode(response.body);

        // Check if 'minimum_system_requirements' key exists and is not null
        if (gameData.containsKey('minimum_system_requirements') &&
            gameData['minimum_system_requirements'] != null) {
          final Map<String, String> minSysRequirements = {
            'OS': gameData['minimum_system_requirements']['os'] ?? 'Not found',
            'Processor': gameData['minimum_system_requirements']['processor'] ??
                'Not found',
            'Memory': gameData['minimum_system_requirements']['memory'] ??
                'Not found',
            'Graphics': gameData['minimum_system_requirements']['graphics'] ??
                'Not found',
            'Storage': gameData['minimum_system_requirements']['storage'] ??
                'Not found',
          };
          return minSysRequirements;
        } else {
          // If minimum system requirements data is not available, return empty map
          return {};
        }
      } else {
        throw Exception('Impossible to load minimum system requirements');
      }
    } catch (e) {
      rethrow; // Rethrow the caught error
    }
  } 
  
    // fetch description
   Future<String> fetchDescription(String gameId) async {
    try {
      final response = await client.get(
          url: 'https://www.freetogame.com/api/game?id=$gameId');

      if (response.statusCode == 200) {
        final Map<String, dynamic> gameData = jsonDecode(response.body);

        // Check if 'description' key exists and is not null
        if (gameData.containsKey('description') && gameData['description'] != null) {
          return gameData['description'];
        } else {
          // If description is not available, return a default value
          return 'Description not available';
        }
      } else {
        throw Exception('Impossible to load game description');
      }
    } catch (e) {
      rethrow; // Rethrow the caught error
    }
  }
}

