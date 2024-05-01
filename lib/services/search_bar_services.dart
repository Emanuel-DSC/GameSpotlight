import 'package:carousel_slider/carousel_slider.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../constants/colors.dart';
import '../data/repositories/games_store.dart';
import '../view/pages/game/game_detail_page.dart';
import '../view/widgets/cards/search_cards_widget.dart';

class CustomSearchDelegate extends SearchDelegate {
  final GameStore store;
  static List<String> searchTerms = [];

  CustomSearchDelegate(this.store);

  // create a list view of game cards to search bar suggestions and results
  Widget _buildGameCardList(List<String> matchQuery) {
    return ScrollConfiguration(
      // remove glow after scrolled til the end
      behavior: const ScrollBehavior().copyWith(overscroll: false),
      child: CarouselSlider.builder(
        options: CarouselOptions(
          scrollPhysics: const BouncingScrollPhysics(),
          scrollDirection: Axis.vertical,
          padEnds: false,
          enableInfiniteScroll: false,
          height: double.infinity,
          viewportFraction: 0.2,
        ),
        itemCount: matchQuery.length,
        itemBuilder: (context, index, realIndex) {
          final String result = matchQuery[index];
          final item = store.state5.value.firstWhere((item) =>
              item.title.toString().toLowerCase() == result.toLowerCase());
          return GameCardList(
            item: item,
            onTap: () => Navigator.push(
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
              ),
            ),
            fit: BoxFit.cover,
          );
        },
      ),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    final List<String> matchQuery = searchTerms
        .where((term) => term.toLowerCase().contains(query.toLowerCase()))
        .toList();

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: _buildGameCardList(matchQuery),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final List<String> matchQuery = searchTerms
        .where((term) => term.toLowerCase().contains(query.toLowerCase()))
        .toList();

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: _buildGameCardList(matchQuery),
    );
  }

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () {
        close(context, null);
      },
      icon: const Icon(EvaIcons.arrowIosBackOutline),
    );
  }

  // get every title from api and add to search bar
  void updateSearchTerms(List items) {
    searchTerms.clear();
    for (var item in items) {
      searchTerms.add(item.title.toString());
    }
  }

  //style
  @override
  ThemeData appBarTheme(BuildContext context) {
    return ThemeData(
      scaffoldBackgroundColor: kBgColor1,
      textTheme: TextTheme(
        // Use this to change the query's text style
        titleLarge: GoogleFonts.roboto(
          color: Colors.white,
          fontSize: 18,
        ),
        titleMedium: GoogleFonts.michroma(
          color: Colors.white,
          fontSize: 14,
        ),
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: kBgColor1,
        elevation: 0,
      ),
      inputDecorationTheme: InputDecorationTheme(
        border: InputBorder.none,
        hintStyle: GoogleFonts.roboto(color: Colors.grey, fontSize: 16),
      ),
      textSelectionTheme: TextSelectionThemeData(
        cursorColor: kButtonColor1,
      ),
    );
  }
}
