import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:f2p_games/constants/colors.dart';
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
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [kBgColor1, Colors.black],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          stops: const [0.3, 0.4],
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: AnimatedBuilder(
          animation:
              Listenable.merge([store.isLoading, store.erro, store.state]),
          builder: (context, child) {
            if (store.isLoading.value) {
              return Center(
                child: BackdropFilter(
                  filter: ImageFilter.blur(
                    sigmaX: 50.0,
                    sigmaY: 50.0,
                  ),
                  child: Container(
                    alignment: Alignment.center,
                    width: double.infinity,
                    height: double.infinity,
                    child: CircularProgressIndicator(
                      color: Colors.cyan,
                      backgroundColor: kBgColor1,
                    ),
                  ),
                ),
              );
            }
            if (store.erro.value.isNotEmpty) {
              return Center(
                child: Text(store.erro.value, style: const TextStyle(
                  color: Colors.amber, fontSize: 28,
                ),),
              );
            }
            if (store.state.value.isEmpty) {
              return const Center(
                child: Text('Empty list', style: TextStyle(
                  color: Colors.amber, fontSize: 28,
                ),),
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
                              builder: (context) => GameDetailPage(
                                title: item.title,
                                shortDescription: item.shortDescription,
                                thumbnail: item.thumbnail,
                                releaseDate: item.releaseDate,
                                id: item.id,
                              ),
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
                                          color: Colors.white.withOpacity(0.2),
                                          alignment: Alignment.center,
                                          width: double.infinity,
                                          height: 210,
                                          child: Center(
                                            child: CircularProgressIndicator(
                                              color: Colors.cyan,
                                              backgroundColor: kBgColor1,
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
      ),
    );
  }
}
