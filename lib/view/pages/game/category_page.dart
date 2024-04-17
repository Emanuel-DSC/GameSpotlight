import 'package:f2p_games/constants/colors.dart';
import 'package:f2p_games/view/pages/home/home_page.dart';
import 'package:flutter/material.dart';
import '../../../data/repositories/games_store.dart';
import '../../widgets/Tab/GamesListTab/categories_games_list_widget.dart';
import '../../widgets/Tab/GamesListTab/categories_grid_widget.dart';
import '../../widgets/my_progress_indicador_widget.dart';
import '../../widgets/text/categories_text_animation_widget.dart';

class CategoryPage extends StatelessWidget {
  final String title;
  final GameStore store;

  const CategoryPage({
    Key? key,
    required this.title,
    required this.store,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: store.getGenres(title), // Fetch the genres
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(
              child: MyCircularProgressIndicator(),
            ),
          );
        } else if (snapshot.hasError) {
          // If there's an error fetching data, display the error message
          return Scaffold(
            body: Center(
              child: Text("Error: ${snapshot.error}"),
            ),
          );
        } else {
          // If data is successfully fetched, display the games list
          return Scaffold(
            backgroundColor: kBgColor1,
            appBar: AppBar(
              backgroundColor: kBgColor1,
              leading: GestureDetector(
                child: const Icon(
                  Icons.arrow_back_ios,
                  color: Colors.white,
                ),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              title: Text(title.toUpperCase()),
              actions: [
                IconButton(
                  icon: const Icon(
                    Icons.home,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => const HomePage(),
                      ),
                    );
                  },
                )
              ],
            ),
            body: Column(
              children: [
                const SizedBox(height: 10),
                CategoriesGamesList(store: store, state: store.state4.value),
                const CategoriesTextAndAnimation(),
                CategoriesGridView(store: store),
              ],
            ),
          );
        }
      },
    );
  }
}
