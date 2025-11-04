import 'package:flutter/material.dart';
import '../../../../../utils/lists.dart';
import '../../../../controllers/repositories/games_store_controller.dart';
import '../../../widgets/cards/categories_cards_widgets.dart';
import 'category_page.dart';

class AllCategoriesPage extends StatelessWidget {
  final GameStore store;

  const AllCategoriesPage({super.key, required this.store});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Todas as categorias")),
      body: GridView.builder(
        padding: const EdgeInsets.all(20),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: .9,
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
        ),
        itemCount: categoriesList.length,
        itemBuilder: (_, index) {
          String item = categoriesList[index][0];
          String cardCover = categoriesList[index][1];

          return GridCategoriesCards(
            item: item,
            imageUrl: cardCover,
            onTap: () {
              store.getGenres(item);
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => CategoryPage(
                    title: item,
                    store: store,
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
