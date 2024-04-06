import 'package:f2p_games/constants/colors.dart';
import 'package:f2p_games/data/http/http_client.dart';
import 'package:f2p_games/data/repositories/game_repository.dart';
import 'package:f2p_games/view/widgets/my_text.widget.dart';
import 'package:f2p_games/view/widgets/tab_widgets/GamesListTab/categories_grid_widget.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import '../../../data/repositories/games_store.dart';
import '../../../services/game__list_page_services.dart';
import '../../widgets/my_search_bar.widget.dart';
import '../../widgets/tab_widgets/GamesListTab/game_list_tab_bar_widget.dart';
import '../../widgets/tab_widgets/GamesListTab/games_tab_view.dart';

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
              physics: const BouncingScrollPhysics(),
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
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const MyText(
                          googleFont: GoogleFonts.michroma,
                          color: Colors.white,
                          fontSize: 14,
                          title: 'Categories',
                          weight: FontWeight.bold,
                        ),
                        LottieBuilder.asset('lib/src/assets/animation/swipe.json', 
                        height: 30, width: 30,),
                      ],
                    ),
                  ),
                  CategoriesGridView(store: store),
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


