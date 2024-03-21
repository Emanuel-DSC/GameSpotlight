import 'package:f2p_games/data/http/exceptions.dart';
import 'package:f2p_games/data/models/games_models.dart';
import 'package:f2p_games/data/repositories/game_repository.dart';
import 'package:flutter/material.dart';

class GameStore {
  final IGameRepository repository;

  // variável reativa para loading
  final ValueNotifier<bool> isLoading = ValueNotifier<bool>(false);

  // variável reativa para o state
  final ValueNotifier<List<GameModel>> state = ValueNotifier<List<GameModel>>([]);

  // variavel reativa para o erro
  final ValueNotifier<String> erro = ValueNotifier<String>('');

  GameStore({required this.repository});

  Future<void> getGames() async {
    isLoading.value = true;

    try {
      final result = await repository.getGames();
      state.value = result;
    } on NotFoundException catch (e) {
      erro.value = e.message;
    } catch (e) {
      erro.value = e.toString();
    }

    isLoading.value = false;
  }
}
