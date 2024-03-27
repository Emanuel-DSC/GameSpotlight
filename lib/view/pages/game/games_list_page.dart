import 'package:f2p_games/constants/colors.dart';
import 'package:f2p_games/data/http/http_client.dart';
import 'package:f2p_games/data/repositories/game_repository.dart';
import 'package:f2p_games/services/home_page_services.dart';
import 'package:f2p_games/view/widgets/my_text.widget.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../data/models/games_models.dart';
import '../../../services/search_bar_services.dart';
import '../../widgets/games_list_widget.dart';
import '../../widgets/tab_widgets/GamesListTab/game_list_tab_bar_widget.dart';
import '../stores/games_store.dart';

class GamesListPage extends StatefulWidget {
  const GamesListPage({Key? key}) : super(key: key);

  @override
  State<GamesListPage> createState() => _GamesListPageState();
}

class _GamesListPageState extends State<GamesListPage> {
  HomePageServices homePageServices = HomePageServices();
  final GameStore store = GameStore(repository: GameRepository(client: HttpClient()));


  @override
  void initState() {
    super.initState();
    // Initially load games sorted by popularity
    store.getPopular('popularity');
    store.getAlphabetical('alphabetical');
    store.getReleaseData('release-date');
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        backgroundColor: kBgColor1,
        body: AnimatedBuilder(
          animation: Listenable.merge([store.isLoading, store.erro, store.state, store.state2, store.state3]),
          builder: (context, child) {
            if (store.isLoading.value) {
              return homePageServices.buildLoadingIndicator();
            }
            if (store.erro.value.isNotEmpty) {
              return homePageServices.buildErrorText(store.erro.value);
            }
            if (store.state.value.isEmpty || store.state2.value.isEmpty ||  store.state3.value.isEmpty) {
              return homePageServices.buildEmptyListText();
            }
            return Column(
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
                        weight: FontWeight.bold,
                      ),
                      const SizedBox(height: 20),
                      GestureDetector(
                        onTap: () {
                          showSearch(
                            context: context,
                            delegate: CustomSearchDelegate(store),
                          );
                        },
                        child: Container(
                          width: double.infinity,
                          height: 50,
                          decoration: BoxDecoration(
                            color: kSearchBarColor,
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(color: kCardColor),
                          ),
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
                                  weight: FontWeight.normal,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const GamesListTabBar(),
                const SizedBox(height: 20),
                Expanded(
                  child: TabBarView(
                    physics: NeverScrollableScrollPhysics(),
                    children: [
                      GamesList(store: store, state: store.state.value,),
                      GamesList(store: store, state: store.state2.value,),
                      GamesList(store: store, state: store.state3.value,),
                    ],
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
