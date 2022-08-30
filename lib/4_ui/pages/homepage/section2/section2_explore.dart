import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../utils/routes.dart';

class AppBar2 extends StatelessWidget implements PreferredSizeWidget {
  const AppBar2({Key? key}) : super(key: key);

  @override
  Size get preferredSize => const Size.fromHeight(60);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: const Text("Home page section 2"),
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

class HomePageSection2 extends StatelessWidget {
  const HomePageSection2({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.red,
      body: Center(
        child: TextButton(
          onPressed: () {
            context.goNamed(allRoutes[AppPaths.cart]!);
          },
          child: const Text("Go to cart"),
        ),
      ),
    );
  }
}
