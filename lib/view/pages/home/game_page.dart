import 'package:f2p_games/constants/colors.dart';
import 'package:f2p_games/view/widgets/game_page_tab.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../data/http/http_client.dart';
import '../../../data/repositories/game_repository.dart';
import '../../widgets/game_cover_widget.dart';
import '../../widgets/min_sys_req_widget.dart';
import '../../widgets/my_appbar_widget.dart';
import '../../widgets/my_button_widget.dart';
import '../../widgets/screenshots_widget.dart';


class GameDetailPage extends StatefulWidget {
  final String? title;
  final String? thumbnail;
  final String? releaseDate;
  final String? shortDescription;
  final String? id;
  final String? gameUrl;
  final String? genre;
  final String? publisher;

  const GameDetailPage({
    Key? key,
    required this.title,
    required this.thumbnail,
    required this.releaseDate,
    required this.shortDescription,
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
  late Future<Map<String, String>> _minimumSysRequirementsFuture;
  late Future<List<String>> _screenshotsFuture;

  @override
  void initState() {
    super.initState();
    _screenshotsFuture = repository.fetchScreenshots(widget.id ?? 'none');
    _minimumSysRequirementsFuture =
        repository.fetchMinSysRequirements(widget.id ?? 'none');
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
                    colors: [Colors.transparent, kBgColor1, kBgColor1],
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
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.title ?? 'Not found',
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      widget.releaseDate ?? 'Not found',
                      style: const TextStyle(
                        fontSize: 12,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      widget.genre ?? 'Not found',
                      style: const TextStyle(
                        fontSize: 12,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      widget.publisher ?? 'Not found',
                      style: const TextStyle(
                        fontSize: 12,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 20),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Text(
                        widget.shortDescription ?? 'Not found',
                        textAlign: TextAlign.justify,
                        maxLines: 10,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 16,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    MyButton(launchUrl: _launchUrl),
                    const SizedBox(height: 10),
                    // Show screenshots using ListView
                    // ScreenshotsList(screenshotsFuture: _screenshotsFuture),
                    // Show minimum system requirements
                    MinSysReqList(minimumSysRequirementsFuture: _minimumSysRequirementsFuture),
                    TabBar(
                      isScrollable: false,
                      indicatorColor: Colors.red,
                      labelColor: Colors.amber,
                      unselectedLabelColor: Colors.green,
                      
                      tabs: [
                        Tab(child: Text('Teste')),
                        Tab(child: Text('Teste2')),
                    ]),
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




