import 'package:carousel_slider/carousel_slider.dart';
import 'package:f2p_games/constants/colors.dart';
import 'package:f2p_games/data/http/http_client.dart';
import 'package:f2p_games/data/repositories/game_repository.dart';
import 'package:f2p_games/services/home_page_services.dart';
import 'package:f2p_games/view/widgets/game_card_widget.dart';
import 'package:flutter/material.dart';

import '../stores/games_store.dart';
import 'game_page.dart';

class GamesListPage extends StatefulWidget {
  const GamesListPage({Key? key}) : super(key: key);

  @override
  State<GamesListPage> createState() => _GamesListPageState();
}

class _GamesListPageState extends State<GamesListPage> {
  HomePageServices homePageServices = HomePageServices();
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
      backgroundColor: kBgColor1,
      body: AnimatedBuilder(
        animation:
            Listenable.merge([store.isLoading, store.erro, store.state]),
        builder: (context, child) {
          if (store.isLoading.value) {
            return homePageServices.buildLoadingIndicator();
          }
          if (store.erro.value.isNotEmpty) {
            return homePageServices.buildErrorText(store.erro.value);
          }
          if (store.state.value.isEmpty) {
            return homePageServices.buildEmptyListText();
          }
          // If none of the above conditions are met, it means there are games to display
          return SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                    height: 540,
                    child: CarouselSlider.builder(
                      options: CarouselOptions(height: 250),
                      itemCount: store.state.value.length,
                      itemBuilder: (context, index, realIndex) {
                        final item = store.state.value[index];
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 8.0),
                          child: GameCard(item: item, onTap: () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => GameDetailPage(
                                    title: item.title,
                                    thumbnail: item.thumbnail,
                                    releaseDate: item.releaseDate,
                                    id: item.id,
                                    gameUrl: item.url,
                                    genre: item.genre,
                                    publisher: item.publisher,
                                    description: '',
                                  ),
                                ),),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
