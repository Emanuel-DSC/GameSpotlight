import 'package:flutter/material.dart';

import '../../GameDetails/screenshots_widget.dart';
import 'description_widget.dart';
import 'min_sys_req_widget.dart';

class DetailGamePageTabView extends StatelessWidget {
  final Future<Map<String, String>> minSysReq;
  final Future<String> description;
  final Future<List<String>> screenshots;
  final ScrollController controller;

  const DetailGamePageTabView({
    super.key,
    required this.minSysReq,
    required this.description,
    required this.screenshots,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return TabBarView(physics: const BouncingScrollPhysics(), children: [
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
      MediaQuery.removePadding(
        context: context,
        removeTop: true,
        child: Scrollbar(
          thumbVisibility: true,
          controller: controller,
          thickness: 3,
          radius: const Radius.circular(30),
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: SingleChildScrollView(
                controller: controller,
                physics: const BouncingScrollPhysics(),
                // Show description requirements
                child: DescriptionList(description: description),
              ),
            ),
          ),
        ),
      ),
      Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                // Show minimum system requirements
                MinSysReqList(minimumSysRequirementsFuture: minSysReq),
              ],
            ),
          ),
        ),
      ),
    ]);
  }
}
