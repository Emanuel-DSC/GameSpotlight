import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';

import '../../../services/favourites_services.dart';
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
      leading: Padding(
        padding: const EdgeInsets.all(4.0),
        child: AppBarButton(
          onTap: () => Navigator.of(context).pop(),
          icon: Icons.arrow_back_ios_new_rounded,
        ),
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: AnimatedSwitcher(
            transitionBuilder: (child, animation) {
              return ScaleTransition(scale: animation, child: child);
            },
            duration: const Duration(milliseconds: 300),
            child: _isLiked
                ? AppBarButton(
                    key: const Key('bookmark_icon'),
                    onTap: _onBookmarkPressed,
                    icon: EvaIcons.bookmark)
                : AppBarButton(
                    key: const Key('bookmark_outline_icon'),
                    onTap: _onBookmarkPressed,
                    icon: EvaIcons.bookmarkOutline),
          ),
        ),
      ],
    );
  }

  // save/remove game's info and change state of saved or not
  void _onBookmarkPressed() async {
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
  }
}
