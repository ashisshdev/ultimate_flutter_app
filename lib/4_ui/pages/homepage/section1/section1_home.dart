import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../utils/routes.dart';

class AppBar1 extends StatelessWidget implements PreferredSizeWidget {
  const AppBar1({Key? key}) : super(key: key);

  @override
  Size get preferredSize => const Size.fromHeight(60);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: const Text("Home page section 1"),
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

class HomePageSection1 extends StatelessWidget {
  const HomePageSection1({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.green,
    );
  }
}
