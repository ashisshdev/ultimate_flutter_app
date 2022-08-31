import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ultimate_flutter_app/utils/routes.dart';


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

    final Section2Provider =

    return Scaffold(
      backgroundColor: Colors.red,
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(8),
              child: TextButton(
                onPressed: () {

                },
                child: const Text("Go to cart"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
