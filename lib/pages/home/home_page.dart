import 'package:f2p_games/data/http/http_client.dart';
import 'package:f2p_games/data/repositories/game_repository.dart';
import 'package:flutter/material.dart';
import 'package:stacked_listview/stacked_listview.dart';

import '../stores/games_store.dart';
import 'game_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final GameStore store =
      GameStore(repository: GameRepository(client: HttpClient()));

  @override
  void initState() {
    super.initState();
    store.getGames();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: AnimatedBuilder(
            animation:
                Listenable.merge([store.isLoading, store.erro, store.state]),
            builder: (context, child) {
              if (store.isLoading.value) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              if (store.erro.value.isNotEmpty) {
                return Center(
                  child: Text(store.erro.value),
                );
              }
              if (store.state.value.isEmpty) {
                return const Center(
                  child: Text('Nenhum item na lista'),
                );
              }
              // If none of the above conditions are met, it means there are games to display
              return StackedListView(
                itemCount: store.state.value.length,
                itemExtent: 300,
                builder: (context, index) {
                  final item = store.state.value[index];
                  return Column(
                    children: [
                      TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  GameDetailPage(title: item.title),
                            ),
                          );
                        },
                        child: Text(item.title ?? 'Not found'),
                      ),
                      Text(item.releaseDate ?? 'Not found'),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(16),
                        child: Image.network(item.thumbnail ?? 'Not found'),
                      ),
                    ],
                  );
                },
              );
            }));
  }
}
