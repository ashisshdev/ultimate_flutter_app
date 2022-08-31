import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../../utils/routes.dart';
import '../../../shared/themeicon_widget.dart';

class AppBar3 extends StatelessWidget implements PreferredSizeWidget {
  const AppBar3({Key? key}) : super(key: key);

  @override
  Size get preferredSize => const Size.fromHeight(60);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: const Text("Home page section 3"),
      centerTitle: true,
      actions: [
        IconButton(
            onPressed: () {
              context.goNamed(allRoutes[AppPaths.cart]!);
            },
            icon: const Icon(Icons.add_shopping_cart))
      ],
    );
  }
}

class HomePageSection3 extends StatelessWidget {
  const HomePageSection3({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.yellow,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          ThemeIconsTray(),
        ],
      ),
    );
  }
}
