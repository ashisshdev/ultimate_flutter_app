import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:ultimate_flutter_app/utils/routes.dart';

import '../../../../controllers/home_section2_provider.dart';

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
    final section2Provider = Provider.of<HomeSection2Controller>(context, listen: false);

    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            YupButton(
              onTap: () => section2Provider.getSuccessFunction1(context),
              title: "Get - S 1",
            ),
            YupButton(
              onTap: () => section2Provider.getSuccessFunction2(context),
              title: "Get - S 2",
            ),
            YupButton(
              onTap: () => section2Provider.getFailureFunction1(context),
              title: "Get - F 1",
            ),
            YupButton(
              onTap: () => section2Provider.getFailureFunction2(context),
              title: "Get - F 2",
            ),
            YupButton(
              onTap: () => section2Provider.getFailureFunction3(context),
              title: "Get - F 3",
            ),

            /// post tests
            YupButton(
              onTap: () => section2Provider.postSuccessFunction1(context),
              title: "Post - S 1",
            ),
            YupButton(
              onTap: () => section2Provider.postFailureFunction1(context),
              title: "Post - F 1",
            ),
            YupButton(
              onTap: () => section2Provider.postFailureFunction2(context),
              title: "Post - F 2",
            ),

            /// update tests
            YupButton(
              onTap: () => section2Provider.updateSuccessFunction1(context),
              title: "update - S 1",
            ),
            YupButton(
              onTap: () => section2Provider.updateFailureFunction1(context),
              title: "update - F 1",
            ),
            YupButton(
              onTap: () => section2Provider.updateFailureFunction2(context),
              title: "update - F 2",
            ),

            /// delete tests
            YupButton(
              onTap: () => section2Provider.deleteSuccess(context),
              title: "delete - S 1",
            ),
            YupButton(
              onTap: () => section2Provider.deleteFailure(context),
              title: "delete - F 1",
            ),
          ],
        ),
      ),
    );
  }
}

class YupButton extends StatelessWidget {
  final String title;
  final VoidCallback? onTap;

  const YupButton({
    Key? key,
    required this.title,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(2),
      child: TextButton(
        onPressed: onTap,
        child: Text(title),
      ),
    );
  }
}
