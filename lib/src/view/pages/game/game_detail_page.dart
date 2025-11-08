import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../utils/colors.dart';
import '../../../controllers/repositories/game_repository_controller.dart';

import '../../../models/http/http_client.dart';
import '../../widgets/GameDetails/game_cover_widget.dart';
import '../../widgets/GameDetails/game_header_widget.dart';
import '../../widgets/Tab/GameDetailsTab/game_details_tab_bar.dart';
import '../../widgets/Tab/GameDetailsTab/game_page_tab.dart';
import '../../widgets/appBar/my_appbar_widget.dart';
import '../../widgets/buttons/my_button_widget.dart';
import '../../widgets/text/my_text.widget.dart';

class GameDetailPage extends StatefulWidget {
  final String? title;
  final String? thumbnail;
  final String? releaseDate;
  final String? description;
  final String? shortDescription;
  final String? id;
  final String? gameUrl;
  final String? genre;
  final String? publisher;

  const GameDetailPage({
    super.key,
    required this.title,
    required this.thumbnail,
    required this.releaseDate,
    required this.description,
    this.shortDescription,
    required this.id,
    required this.gameUrl,
    required this.genre,
    required this.publisher,
  });

  @override
  State<GameDetailPage> createState() => _GameDetailPageState();
}

class _GameDetailPageState extends State<GameDetailPage> {
  final repository = GameRepositoryController(client: HttpClient());
  final ScrollController controller = ScrollController();
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
      length: 3,
      child: Scaffold(
        extendBodyBehindAppBar: true,
        backgroundColor: kBgColor2,
        appBar: MyAppBar(
          category: widget.genre,
          cover: widget.thumbnail,
          description: widget.description,
          shortDescription: widget.shortDescription,
          launch: widget.releaseDate,
          name: widget.title,
          publisher: widget.publisher,
          sysReq: _minSysReqFuture.toString(),
          id: widget.id,
        ),
        body: Column(
          children: [
            GameCover(widget: widget),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    Center(
                      child: MyText(
                        title: widget.title ?? 'Not found',
                        fontSize: 24.0,
                        googleFont: GoogleFonts.poppins,
                        color: Colors.white,
                        weight: FontWeight.normal,
                      ),
                    ),
                    const SizedBox(height: 10),
                    GameHeader(widget: widget),
                    const SizedBox(height: 20),
                    MyButton(launchUrl: _launchUrl),
                    const SizedBox(height: 20),
                    const SizedBox(height: 10),
                    const GameDetailsTabBar(
                      firstTitle: 'Screenshots',
                      secondTitle: 'About',
                      thitrdTitle: 'Min Sys Requirements',
                    ),
                    Expanded(
                      child: DetailGamePageTabView(
                        minSysReq: _minSysReqFuture,
                        description: _description,
                        screenshots: _screenshotsFuture,
                        controller: controller,
                      ),
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
