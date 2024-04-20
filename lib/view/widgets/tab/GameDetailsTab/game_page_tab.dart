import 'package:flutter/material.dart';

import '../../GameDetails/screenshots_widget.dart';
import 'description_widget.dart';
import 'min_sys_req_widget.dart';

class DetailGamePageTabView extends StatelessWidget {
  final Future<Map<String, String>> minSysReq;
  final Future<String> description;
  final Future<List<String>> screenshots;

  const DetailGamePageTabView({
    super.key,
    required this.minSysReq,
    required this.description,
    required this.screenshots,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TabBarView(physics: const BouncingScrollPhysics(), children: [
        Center(
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            // Show description requirements
            child: DescriptionList(description: description),
          ),
        ),
        Center(
          child: SingleChildScrollView(
            child: Column(
              children: [
                // Show minimum system requirements
                MinSysReqList(minimumSysRequirementsFuture: minSysReq),
              ],
            ),
          ),
        ),
        Center(
          child: SingleChildScrollView(
            child: Column(
              children: [
                // Show screenshots using ListView
                ScreenshotsList(screenshotsFuture: screenshots),
              ],
            ),
          ),
        ),
      ]),
    );
  }
}
