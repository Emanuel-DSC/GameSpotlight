import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:f2p_games/services/add_to_favourites_services.dart';
import 'package:flutter/material.dart';

import '../buttons/app_bar_buttons_widget.dart';

class MyAppBar extends StatefulWidget implements PreferredSizeWidget {
  final String? name;
  final String? description;
  final String? cover;
  final String? publisher;
  final String? launch;
  final String? category;
  final String? id;
  final String? sysReq;
  final bool isLiked;
  const MyAppBar({
    Key? key,
    required this.name,
    required this.id,
    required this.description,
    required this.launch,
    required this.cover,
    required this.publisher,
    required this.category,
    required this.sysReq,
    this.isLiked = false, // Set default value
  }) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _MyAppBarState createState() => _MyAppBarState();

  @override
  Size get preferredSize => const Size.fromHeight(100);
}

class _MyAppBarState extends State<MyAppBar> {
  late bool _isLiked;

  @override
  void initState() {
    super.initState();
    _isLiked = widget.isLiked;
  }

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      backgroundColor: Colors.transparent,
      leading: AppBarButton(
        onTap: () => Navigator.of(context).pop(),
        icon: Icons.arrow_back_ios_new_rounded,
      ),
      actions: [
        AppBarButton(
          onTap: () async {
            bool updatedIsLiked = await SaveFavouriteServices(
              name: widget.name,
              description: widget.description,
              cover: widget.cover,
              category: widget.category,
              sysReq: widget.sysReq,
              publisher: widget.publisher,
              launch: widget.launch,
              id: widget.id,
            ).onLikeButtonTapped(_isLiked);

            setState(() {
              _isLiked = updatedIsLiked;
            });
          },
          icon: _isLiked ? EvaIcons.bookmark : EvaIcons.bookmarkOutline,
        ),
      ],
    );
  }
}
