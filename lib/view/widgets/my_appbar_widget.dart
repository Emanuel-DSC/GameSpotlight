import 'package:flutter/material.dart';

import 'app_bar_widgets/app_bar_buttons_widget.dart';

class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  const MyAppBar({
    super.key,
  });

  @override
  Size get preferredSize => const Size.fromHeight(100);

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
            onTap: () => Navigator.of(context).pop(), icon: Icons.bookmark_add_outlined),
      ],
    );
  }
}
