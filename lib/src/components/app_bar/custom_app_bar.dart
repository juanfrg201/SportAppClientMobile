import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  @override
  Widget build(BuildContext context) {

    final colors = Theme.of(context).colorScheme;

    return AppBar(
      title: const Text("To do List", style: TextStyle(color: Colors.white)),
      backgroundColor: colors.primary,
      elevation: 50.0,
      leading: Builder(
        builder: (BuildContext context) {
          return IconButton(
            icon: const Icon(Icons.menu),
            tooltip: 'Menu Icon',
            onPressed: () {
              Scaffold.of(context).openDrawer();
            },
          );
        },
      ),
      systemOverlayStyle: SystemUiOverlayStyle.light,
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}