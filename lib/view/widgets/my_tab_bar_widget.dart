import 'package:flutter/material.dart';

import 'tab_bar_indicator_widget.dart';

class MyTabBar extends StatelessWidget {
  final bool isScrollable;
  final Color onColor;
  final Color offColor;
  final String firstTitle;
  final String secondTitle;

  const MyTabBar({
    super.key,
    required this.isScrollable,
    required this.onColor,
    required this.offColor,
    required this.firstTitle,
    required this.secondTitle,
  });

  @override
  Widget build(BuildContext context) {
    return TabBar(
        isScrollable: isScrollable,
        labelColor: onColor,
        unselectedLabelColor: offColor,
        indicator: CircleTabIndicator(color: Colors.white, radius: 4),
        tabs: [
          Tab(child: Text(firstTitle)),
          Tab(child: Text(secondTitle)),
        ]);
  }
}
