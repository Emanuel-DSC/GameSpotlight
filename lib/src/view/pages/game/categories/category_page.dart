import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:f2p_games/src/view/widgets/text/my_text.widget.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../utils/colors.dart';
import '../../../../controllers/repositories/games_store_controller.dart';
import '../../../widgets/Tab/GamesListTab/categories_grid_widget.dart';
import '../../../widgets/my_progress_indicador_widget.dart';
import '../../../widgets/tab/GamesListTab/categories_games_list_widget.dart';
import '../../../widgets/text/categories_text_animation_widget.dart';
import '../../home/home_page.dart';

class CategoryPage extends StatelessWidget {
  final String title;
  final GameStore store;

  const CategoryPage({
    super.key,
    required this.title,
    required this.store,
  });

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
              elevation: 0,
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
              title: MyText(googleFont: GoogleFonts.poppins, color: Colors.white,
              fontSize: 18, title: title.toUpperCase(), weight: FontWeight.bold),
              actions: [
                IconButton(
                  icon: const Icon(
                    EvaIcons.homeOutline,
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
                CategoriesTextAndAnimation(store: store),
                CategoriesGridView(store: store),
              ],
            ),
          );
        }
      },
    );
  }
}
