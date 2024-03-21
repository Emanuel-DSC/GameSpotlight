import 'package:cached_network_image/cached_network_image.dart';
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
        animation: Listenable.merge([store.isLoading, store.erro, store.state]),
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
              child: Text('Empty list'),
            );
          }
          // If none of the above conditions are met, it means there are games to display
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: SizedBox(
              height: 470,
              child: StackedListView(
                itemCount: store.state.value.length,
                itemExtent: 210,
                builder: (context, index) {
                  final item = store.state.value[index];
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                GameDetailPage(title: item.title),
                          ),
                        );
                      },
                      child: SizedBox(
                          height: 210, // Adjust height to match itemExtent
                          width: double
                              .infinity, // Adjust width to match parent width
                          child: ClipRRect(
                              borderRadius: BorderRadius.circular(16),
                              child: CachedNetworkImage(
                                  imageUrl: item.thumbnail ?? 'Not found',
                                  fit: BoxFit.cover,
                                  placeholder: (context, url) => Container(
                                    color: Colors.black,
                                    child: Center(
                                          child: CircularProgressIndicator(
                                            color: Colors.red.shade900,
                                            backgroundColor: Colors.orange.shade600,
                                          ),
                                        ),
                                  ),
                                  errorWidget: (context, url, error) =>
                                      const Icon(Icons.error)))),
                    ),
                  );
                },
              ),
            ),
          );
        },
      ),
    );
  }
}
