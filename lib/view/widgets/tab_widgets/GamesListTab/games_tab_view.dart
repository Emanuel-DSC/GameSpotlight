import 'package:flutter/material.dart';

import '../../../../data/repositories/games_store.dart';
import '../../games_list_widget.dart';

class GamesTabView extends StatelessWidget {
  const GamesTabView({
    super.key,
    required this.store,
  });

  final GameStore store;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 300,
      width: double.infinity,
      child: TabBarView(
        physics: const NeverScrollableScrollPhysics(),
        children: [
          GamesList(
            store: store,
            state: store.state.value,
          ),
          GamesList(
            store: store,
            state: store.state2.value,
          ),
          GamesList(
            store: store,
            state: store.state3.value,
          ),
        ],
      ),
    );
  }
}
