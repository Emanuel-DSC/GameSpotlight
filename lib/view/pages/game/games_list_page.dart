import 'package:f2p_games/constants/colors.dart';
import 'package:f2p_games/data/http/http_client.dart';
import 'package:f2p_games/data/repositories/game_repository.dart';
import 'package:f2p_games/services/home_page_services.dart';
import 'package:f2p_games/view/widgets/my_text.widget.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../services/search_bar_services.dart';
import '../../widgets/games_list_widget.dart';
import '../stores/games_store.dart';

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
        animation: Listenable.merge([store.isLoading, store.erro, store.state]),
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
            physics: const NeverScrollableScrollPhysics(),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                SizedBox(height: MediaQuery.of(context).size.height * 0.1),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const MyText(
                            googleFont: GoogleFonts.michroma,
                            color: Colors.white,
                            fontSize: 24,
                            title: 'Game Spotlight',
                            weight: FontWeight.bold),
                        const SizedBox(height: 20),
                        GestureDetector(
                          onTap: () {
                            showSearch(
                                context: context,
                                delegate: CustomSearchDelegate(store));
                          },
                          child: Container(
                            width: double.infinity,
                            height: 50,
                            decoration: BoxDecoration(
                                color: kSearchBarColor,
                                borderRadius: BorderRadius.circular(16),
                                border: Border.all(color: kCardColor)),
                            child: const Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Icon(
                                    Icons.search_outlined,
                                    color: Colors.grey,
                                  ),
                                  SizedBox(width: 10),
                                  MyText(
                                      googleFont: GoogleFonts.roboto,
                                      color: Colors.grey,
                                      fontSize: 14,
                                      title: 'Search free game',
                                      weight: FontWeight.normal),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ]),
                ),
                const SizedBox(height: 20),
                GamesList(store: store),
              ],
            ),
          );
        },
      ),
    );
  }
}

