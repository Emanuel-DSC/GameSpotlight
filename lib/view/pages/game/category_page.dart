import 'package:f2p_games/constants/colors.dart';
import 'package:f2p_games/view/widgets/tab_widgets/GamesListTab/categories_games_list_widget.dart';
import 'package:flutter/material.dart';
import '../../../data/repositories/games_store.dart';
import '../../widgets/my_progress_indicador_widget.dart';
import '../../widgets/tab_widgets/GamesListTab/categories_grid_widget.dart';

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
            appBar: AppBar(),
            body: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                children: [
                  const SizedBox(height: 20),
                  CategoriesGamesList(store: store, state: store.state4.value),
                  const SizedBox(height: 20),
                  CategoriesGridView(store: store),
                  const SizedBox(height: 70,),
                ],
              ),
            ),
          );
        }
      },
    );
  }
}
