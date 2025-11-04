import 'package:flutter/material.dart';

import '../../../../../utils/lists.dart';
import '../../../../controllers/repositories/games_store_controller.dart';
import '../../../pages/game/categories/category_page.dart';
import '../../cards/categories_cards_widgets.dart';

class CategoriesGridView extends StatelessWidget {
  const CategoriesGridView({
    super.key,
    required this.store,
  });

  final GameStore store;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 300,
      width: double.infinity,
      child: GridView.builder(
        physics: const BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          mainAxisExtent: 220,
          crossAxisCount: 2,
          mainAxisSpacing: 10.0,
          crossAxisSpacing: 8.0,
        ),
        padding: const EdgeInsets.all(20.0),
        itemCount: 10,
        itemBuilder: (context, index) {
          String item = categoriesList[index][0];
          String cardCover = categoriesList[index][1];
          return GridCategoriesCards(
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
    );
  }
}
