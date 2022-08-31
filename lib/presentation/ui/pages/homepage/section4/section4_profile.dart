import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ultimate_flutter_app/data/local/shared_prefs/shared_prefs_helper.dart';
import 'package:ultimate_flutter_app/dependency_injection.dart';
import 'package:ultimate_flutter_app/utils/routes.dart';

class AppBar4 extends StatelessWidget implements PreferredSizeWidget {
  const AppBar4({Key? key}) : super(key: key);

  @override
  Size get preferredSize => const Size.fromHeight(60);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: const Text("Home page section 4"),
      centerTitle: true,
      actions: [
        IconButton(
            onPressed: () {
              GoRouter.of(context).goNamed(allRoutes[AppPaths.cart]!);
              // context.go(allRoutes[AppPaths.cart]!);
            },
            icon: const Icon(Icons.add_shopping_cart))
      ],
    );
  }
}

class HomePageSection4 extends StatelessWidget {
  const HomePageSection4({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(
            height: 50,
          ),
          locator<SharedPreferencesHelperImpl>().getIsUserLoggedIn()
              ? TextButton(
                  onPressed: () {
                    context.pushNamed(allRoutes[AppPaths.editprofile]!,
                        params: <String, String>{'usertoken': locator<SharedPreferencesHelperImpl>().getUserToken()!});
                  },
                  child: const Text("uer is properly logged in Go to editProfile"))
              : const Text("Not logged in properly"),
          const SizedBox(
            height: 50,
          ),
          locator<SharedPreferencesHelperImpl>().getAnonymousLogIn()
              ? TextButton(
                  onPressed: () {
                    /// we are not pushing user so that he can come back if the changes his mind to logIn
                    /// and if he logs in then the stack will be rebuilt again with home in root
                    context.pushNamed(allRoutes[AppPaths.login]!);
                  },
                  child:
                      const Text("user is anonymously logged in, cant go to edit profile page, logIn properly now? "))
              : Container(),
          const SizedBox(
            height: 100,
          ),
          TextButton(
              onPressed: () {
                locator<SharedPreferencesHelperImpl>().clearPreferenceValuesExceptWelcome().then((value) {
                  if (value) {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Logged out")));

                    context.goNamed(allRoutes[AppPaths.login]!);
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Error logging out")));
                  }
                });
              },
              child: const Text("LogOut")),
        ],
      ),
    );
  }
}
