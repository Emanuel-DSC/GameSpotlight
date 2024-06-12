import 'package:f2p_games/src/controllers/repositories/game_repository_controller.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../utils/colors.dart';
import '../../../controllers/repositories/games_store_controller.dart';
import '../../../models/http/http_client.dart';
import '../../widgets/Tab/GamesListTab/categories_grid_widget.dart';
import '../../widgets/Tab/GamesListTab/game_list_tab_bar_widget.dart';
import '../../widgets/Tab/GamesListTab/games_tab_view.dart';
import '../../widgets/game_list_page_helpers.dart.dart';
import '../../widgets/my_search_bar.widget.dart';
import '../../widgets/text/categories_text_animation_widget.dart';
import '../../widgets/text/my_text.widget.dart';

class GamesListPage extends StatefulWidget {
  const GamesListPage({Key? key}) : super(key: key);

  @override
  State<GamesListPage> createState() => _GamesListPageState();
}

class _GamesListPageState extends State<GamesListPage> {
  GameListPageServices homePageServices = GameListPageServices();
  String genre = 'pvp';
  final GameStore store =
      GameStore(repository: GameRepositoryController(client: HttpClient()));

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
        appBar: AppBar(
          toolbarHeight: 5,
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
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
                  SizedBox(height: MediaQuery.of(context).size.height * 0.1),
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
                  const SizedBox(height: 10),
                  const CategoriesTextAndAnimation(),
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
