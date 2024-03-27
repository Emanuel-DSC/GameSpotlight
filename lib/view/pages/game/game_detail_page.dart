import 'package:f2p_games/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../data/http/http_client.dart';
import '../../../data/repositories/game_repository.dart';
import '../../widgets/app_bar_widgets/my_appbar_widget.dart';
import '../../widgets/game_details_widgets/game_cover_widget.dart';
import '../../widgets/game_details_widgets/screenshots_widget.dart';
import '../../widgets/my_button_widget.dart';
import '../../widgets/my_text.widget.dart';
import '../../widgets/tab_widgets/game_page_tab.dart';
import '../../widgets/tab_widgets/my_tab_bar_widget.dart';

class GameDetailPage extends StatefulWidget {
  final String? title;
  final String? thumbnail;
  final String? releaseDate;
  final String? description;
  final String? id;
  final String? gameUrl;
  final String? genre;
  final String? publisher;

  const GameDetailPage({
    Key? key,
    required this.title,
    required this.thumbnail,
    required this.releaseDate,
    required this.description,
    required this.id,
    required this.gameUrl,
    required this.genre,
    required this.publisher,
  }) : super(key: key);

  @override
  State<GameDetailPage> createState() => _GameDetailPageState();
}

class _GameDetailPageState extends State<GameDetailPage> {
  final repository = GameRepository(client: HttpClient());
  late Future<Map<String, String>> _minSysReqFuture;
  late Future<List<String>> _screenshotsFuture;
  late Future<String> _description;

  @override
  void initState() {
    super.initState();
    _screenshotsFuture = repository.fetchScreenshots(widget.id ?? 'none');
    _minSysReqFuture = repository.fetchMinSysRequirements(widget.id ?? 'none');
    _description = repository.fetchDescription(widget.id ?? 'none');
  }

  Future<void> _launchUrl() async {
    if (!await launchUrl(Uri.parse(widget.gameUrl ?? 'No link found'))) {
      throw Exception('Could not launch url');
    }
  }

  @override
  Widget build(BuildContext context) {
    
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: const MyAppBar(),
        body: Stack(
          children: [
            Container(
              height: double.infinity,
              color: Colors.black,
            ),
            GameCover(widget: widget),
            Positioned.fill(
              child: DecoratedBox(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Colors.transparent, Colors.black, kBgColor1],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    stops: const [0.25, 0.35, 3],
                  ),
                ),
              ),
            ),
            Positioned(
              top: MediaQuery.of(context).size.height * 0.29,
              width: MediaQuery.of(context).size.width,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    const SizedBox(
                      height: 24,
                    ),
                    Center(
                      child: MyText(
                        title: widget.title ?? 'Not found',
                        fontSize: 24.0,
                        googleFont: GoogleFonts.zenDots,
                        color: Colors.white,
                        weight: FontWeight.normal,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Wrap(
                      alignment: WrapAlignment.spaceEvenly,
                      runAlignment: WrapAlignment.spaceEvenly,
                      spacing: 12,
                      children: [
                        MyText(
                          title: // get only year from release
                              (widget.releaseDate != null &&
                                      widget.releaseDate!.isNotEmpty)
                                  ? DateTime.parse(widget.releaseDate!)
                                      .year
                                      .toString()
                                  : 'XXXX',
                          fontSize: 12.0,
                          googleFont: GoogleFonts.michroma,
                          color: Colors.grey,
                          weight: FontWeight.bold,
                        ),
                        MyText(
                          title: widget.genre ?? 'Not found',
                          fontSize: 12.0,
                          googleFont: GoogleFonts.michroma,
                          color: Colors.grey,
                          weight: FontWeight.bold,
                        ),
                        MyText(
                          title: widget.publisher ?? 'Not found',
                          fontSize: 12.0,
                          googleFont: GoogleFonts.michroma,
                          color: Colors.grey,
                          weight: FontWeight.bold,
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    MyButton(launchUrl: _launchUrl),
                    const SizedBox(height: 20),
                    // Show screenshots using ListView
                    ScreenshotsList(screenshotsFuture: _screenshotsFuture),
                    const SizedBox(height: 10),
                    const MyTabBar(
                        firstTitle: 'About',
                        secondTitle: 'Minimum System Requirements',
                        isScrollable: true,
                        offColor: Colors.grey,
                        onColor: Colors.white),
                    // show tab bar content
                    SizedBox(
                      height: 160,
                      child: GamePageTabView(
                          minSysReq: _minSysReqFuture,
                          description: _description),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
