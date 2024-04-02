import 'package:f2p_games/constants/colors.dart';
import 'package:f2p_games/constants/lists.dart';
import 'package:f2p_games/data/http/http_client.dart';
import 'package:f2p_games/data/repositories/game_repository.dart';
import 'package:f2p_games/view/widgets/my_text.widget.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../data/repositories/games_store.dart';
import '../../../services/game__list_page_services.dart';
import '../../widgets/cards/categories_cards_widgets.dart';
import '../../widgets/my_search_bar.widget.dart';
import '../../widgets/tab_widgets/GamesListTab/game_list_tab_bar_widget.dart';
import '../../widgets/tab_widgets/GamesListTab/games_tab_view.dart';
import 'category_page.dart';

class GamesListPage extends StatefulWidget {
  const GamesListPage({Key? key}) : super(key: key);

  @override
  State<GamesListPage> createState() => _GamesListPageState();
}

class _GamesListPageState extends State<GamesListPage> {
  GameListPageServices homePageServices = GameListPageServices();
  String genre = 'pvp';
  final GameStore store =
      GameStore(repository: GameRepository(client: HttpClient()));

  @override
  void initState() {
    super.initState();
    store.getPopular('popularity');
    store.getAlphabetical('alphabetical');
    store.getReleaseData('release-date');
    store.getGenres(genre);
    store.getEveryGame();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        backgroundColor: kBgColor1,
        body: AnimatedBuilder(
          animation: Listenable.merge([
            store.isLoading,
            store.erro,
            store.state,
            store.state2,
            store.state3,
            store.state4,
          ]),
          builder: (context, child) {
            if (store.isLoading.value) {
              return homePageServices.buildLoadingIndicator();
            }
            if (store.erro.value.isNotEmpty) {
              return homePageServices.buildErrorText(store.erro.value);
            }
            if (store.state.value.isEmpty ||
                store.state2.value.isEmpty ||
                store.state3.value.isEmpty ||
                store.state4.value.isEmpty) {
              return homePageServices.buildEmptyListText();
            }
            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: MediaQuery.of(context).size.height * 0.07),
                  const Padding(
                    padding: EdgeInsets.only(left: 20.0),
                    child: MyText(
                      googleFont: GoogleFonts.michroma,
                      color: Colors.white,
                      fontSize: 24,
                      title: 'Game Spotlight',
                      weight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: MySearchBar(store: store),
                  ),
                  const SizedBox(height: 10),
                  const Padding(
                    padding: EdgeInsets.only(left: 20.0),
                    child: GamesListTabBar(),
                  ),
                  const SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.only(left: 15.0),
                    child: GamesTabView(store: store),
                  ),
                  const SizedBox(height: 20),
                  const Padding(
                    padding: EdgeInsets.only(left: 20.0),
                    child: MyText(
                      googleFont: GoogleFonts.michroma,
                      color: Colors.white,
                      fontSize: 14,
                      title: 'Categories',
                      weight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    height: 300,
                    width: double.infinity,
                    child: GridView.builder(
                      physics: const BouncingScrollPhysics(),
                      scrollDirection: Axis.horizontal,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                              mainAxisExtent: 220,
                              crossAxisCount: 2,
                              mainAxisSpacing: 10.0,
                              crossAxisSpacing: 8.0,
                              ),
                      padding: const EdgeInsets.all(20.0),
                      itemCount: categoriesList.length,
                      itemBuilder: (context, index) {
                        String item = categoriesList[index][0];
                        String cardCover = categoriesList[index][1];
                        return CategoriesCards(
                            item: item,
                            imageUrl: cardCover,
                            onTap: () {
                              // pass genre name to getGenres
                              store.getGenres(item);
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => CategoryPage(
                                    title: item,
                                    store: store,
                                  ),
                                ),
                              );
                            });
                      },
                    ),
                  ),
                  const SizedBox(height: 70),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
