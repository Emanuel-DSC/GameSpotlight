import 'package:f2p_games/data/models/games_models.dart';

abstract class IGameRepository {
  Future<List<GameModel>> getGames();
}

class GameRepository implements IGameRepository{
  @override
  Future<List<GameModel>> getGames() {
    // TODO: implement getGames
    throw UnimplementedError();
  }
}