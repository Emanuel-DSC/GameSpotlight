import 'package:f2p_games/data/http/exceptions.dart';
import 'package:f2p_games/data/models/games_models.dart';
import 'package:f2p_games/data/repositories/game_repository.dart';
import 'package:flutter/material.dart';

class GameStore {
  final IGameRepository? repository;

  final ValueNotifier<bool> isLoading = ValueNotifier<bool>(false);
  final ValueNotifier<List<GameModel>> state = ValueNotifier<List<GameModel>>([]);
  final ValueNotifier<List<GameModel>> state2 = ValueNotifier<List<GameModel>>([]);
  final ValueNotifier<List<GameModel>> state3 = ValueNotifier<List<GameModel>>([]);
  final ValueNotifier<String> erro = ValueNotifier<String>('');

  GameStore({this.repository});

  Future<void> getPopular(String sorting) async {
    isLoading.value = true;

    try {
      final result = await repository!.getGames(sorting);
      state.value = result;
    } on NotFoundException catch (e) {
      erro.value = e.message;
    } catch (e) {
      erro.value = e.toString();
    }

    isLoading.value = false;
  }
  Future<void> getReleaseData(String sorting) async {
    isLoading.value = true;

    try {
      final result = await repository!.getGames(sorting);
      state2.value = result;
    } on NotFoundException catch (e) {
      erro.value = e.message;
    } catch (e) {
      erro.value = e.toString();
    }

    isLoading.value = false;
  }
  Future<void> getAlphabetical(String sorting) async {
    isLoading.value = true;

    try {
      final result = await repository!.getGames(sorting);
      state3.value = result;
    } on NotFoundException catch (e) {
      erro.value = e.message;
    } catch (e) {
      erro.value = e.toString();
    }

    isLoading.value = false;
  }
}
