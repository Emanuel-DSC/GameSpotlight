import 'package:flutter/material.dart';

import '../../../../constants/colors.dart';

class GamesListTabBar extends StatelessWidget {
  const GamesListTabBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return TabBar(
      indicatorColor: kButtonColor1,
      labelColor: Colors.white,
      unselectedLabelColor: Colors.grey,
      tabs: const [
        Tab(child: Text('teste')),
        Tab(child: Text('teste2')),
        Tab(child: Text('teste3')),
    ]);
  }
}
