import 'package:f2p_games/view/widgets/tab_widgets/description_widget.dart';
import 'package:f2p_games/view/widgets/tab_widgets/min_sys_req_widget.dart';
import 'package:flutter/material.dart';


class GamePageTabView extends StatelessWidget {
  final Future<Map<String, String>> minSysReq;
  final Future<String> description;

  const GamePageTabView({
    super.key,
    required this.minSysReq,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TabBarView(children: [
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
      ]),
    );
  }
}

