import 'package:f2p_games/src/view/pages/game/categories/category_page.dart';
import 'package:f2p_games/src/view/widgets/text/my_text.widget.dart';
import 'package:f2p_games/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../utils/lists.dart';
import '../../../../controllers/repositories/games_store_controller.dart';
import '../../../widgets/cards/categories_cards_widgets.dart';

class AllCategoriesPage extends StatelessWidget {
  final GameStore store;

  const AllCategoriesPage({super.key, required this.store});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBgColor1,
      appBar: AppBar(
        backgroundColor: kBgColor1,
        elevation: 0,
        title: MyText(
            googleFont: GoogleFonts.michroma,
            color: Colors.white,
            fontSize: 16,
            title: "Categories".toUpperCase(),
            weight: FontWeight.bold),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: GridView.builder(
          itemCount: categoriesList.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisExtent: 140,
            mainAxisSpacing: 14,
            crossAxisSpacing: 14,
          ),
          itemBuilder: (context, i) {
            String name = categoriesList[i][0];
            String image = categoriesList[i][1];

            return GestureDetector(
              onTap: () {
                store.getGenres(name);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => CategoryPage(title: name, store: store),
                  ),
                );
              },
              child: Hero(
                tag: name,
                child: GridCategoriesCards(
                  title: name,
                  imageUrl: image,
                  onTap: () {
                    store.getGenres(name);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            CategoryPage(title: name, store: store),
                      ),
                    );
                  }, padding: 8, heightSize: 8,
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
