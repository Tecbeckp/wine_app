// import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:flutter/material.dart';

class AppBarWidget extends StatelessWidget implements PreferredSizeWidget {
  final String title;

  AppBarWidget({
    Key? key,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      iconTheme: const IconThemeData(color: Colors.white),
      elevation: 0,
      titleSpacing: 10,
      automaticallyImplyLeading: false,
      title: Text(title),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class AppBarWidgetWithoutTitle extends StatelessWidget
    implements PreferredSizeWidget {
  AppBarWidgetWithoutTitle({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      iconTheme: const IconThemeData(color: Colors.white),
      elevation: 0.5,
      titleSpacing: 10,
      automaticallyImplyLeading: false,
      actions: [
        Row(
          children: [
            Icon(
              Icons.menu,
              color: Colors.white,
            ),
            SizedBox(
              width: 15,
            )
          ],
        )
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
