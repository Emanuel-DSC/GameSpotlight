import 'package:f2p_games/constants/colors.dart';
import 'package:f2p_games/data/http/http_client.dart';
import 'package:f2p_games/data/repositories/game_repository.dart';
import 'package:f2p_games/view/widgets/my_text.widget.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../data/repositories/games_store.dart';
import '../../../services/game__list_page_services.dart';
import '../../../services/search_bar_services.dart';
import '../../widgets/games_list_widget.dart';
import '../../widgets/my_search_bar.widget.dart';
import '../../widgets/tab_widgets/GamesListTab/game_list_tab_bar_widget.dart';
import '../../widgets/tab_widgets/GamesListTab/games_tab_view.dart';

class GamesListPage extends StatefulWidget {
  const GamesListPage({Key? key}) : super(key: key);

  @override
  State<GamesListPage> createState() => _GamesListPageState();
}

class _GamesListPageState extends State<GamesListPage> {
  List<bool> _isSelectedList = List.filled(39, false); // Initialize with false for each chip
  String genre = 'pvp';
  GameListPageServices homePageServices = GameListPageServices();
  final GameStore store =
      GameStore(repository: GameRepository(client: HttpClient()));

  @override
  void initState() {
    super.initState();
    // Initially load games sorted by popularity
    store.getPopular('popularity');
    store.getAlphabetical('alphabetical');
    store.getReleaseData('release-date');
    store.getGenres(genre);
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
            return Column(
              children: [
                SizedBox(height: MediaQuery.of(context).size.height * 0.07),
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
                        child: const MySearchBar(),
                      ),
                    ],
                  ),
                ),
                // const SizedBox(height: 10),
                // const GamesListTabBar(),
                // const SizedBox(height: 20),
                // GamesTabView(store: store),
                Wrap(
                  children: [
                    // Repeat for each genre
                    for (int index = 0; index < 39; index++)
                      ChoiceChip(
                        label: Text(
                          _getGenreFromIndex(index),
                          style: TextStyle(
                            fontSize: 20,
                            color: _isSelectedList[index]
                                ? Colors.white
                                : Colors.black,
                          ),
                        ),
                        selected: _isSelectedList[index],
                        selectedColor: Colors.purple,
                        onSelected: (newBoolValue) {
                          setState(() {
                            _isSelectedList =
                                List.filled(39, false); // Deselect all chips
                            _isSelectedList[index] = newBoolValue;
                            genre = _getGenreFromIndex(index); // Convert index to genre
                            store.getGenres(genre);
                          });
                        },
                      ),
                  ],
                ),
                SizedBox(
                  height: 150,
                  width: 200,
                  child: GamesList(
                    store: store,
                    state: store.state4.value,
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


// Function to convert chip index to genre
  String _getGenreFromIndex(int index) {
    // List of all genres
    List<String> genres = [
      'mmorpg', 'shooter', 'strategy', 'moba', 'racing', 'sports', 'social',
      'sandbox', 'open-world', 'survival', 'pvp', 'pve', 'pixel', 'voxel',
      'zombie', 'turn-based', 'first-person', 'third-Person', 'top-down',
      'tank', 'space', 'sailing', 'side-scroller', 'superhero', 'permadeath',
      'card', 'battle-royale', 'mmo', 'mmofps', 'mmotps', '3d', '2d', 'anime',
      'fantasy', 'sci-fi', 'fighting', 'action-rpg', 'action', 'military',
      'martial-arts', 'flight', 'low-spec', 'tower-defense', 'horror', 'mmorts'
    ];
    // Return the genre corresponding to the index
    return genres[index];
  }
