import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'min_sys_req_widget.dart';
import 'my_text.widget.dart';

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
            child: FutureBuilder<String>(
              future: description,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const CircularProgressIndicator();
                } else if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                } else {
                  return MyText(
                    title: snapshot.data ?? 'Description not available',
                    fontSize: 14.0,
                    googleFont: GoogleFonts.michroma,
                    color: Colors.grey.shade300,
                    weight: FontWeight.bold,
                  );
                }
              },
            ),
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
