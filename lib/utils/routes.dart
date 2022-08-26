import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../1_services/local/shared_prefs/shared_prefs_helper.dart';
import '../app.dart';
import '../dependency_injection.dart';

/// creating this enum and allRoutes map for the sake of avoiding possible mistakes I might make while swithcing
/// between pages and making typos

// its actually easy
// enums contains all the possible routes
// allRoutes map gives all those routes names
// we are using this allRoutes in 2 places...
// (i) - to set name of route in GoRoute()
// (ii) - to set path of route in GoRoute()

/// if someone else is reading this code and you have a better implementation please tell I feel like this one is
/// a little complex for a 5 year old

// apart from this we will use this while navigating between screens as
// context.goNamed(allRoutes[AppPaths.welcome]) OR context.pushNamed(allRoutes[AppPaths.welcome])
// mind that I have used context.goNamed and context.pushNamed here instead of basic context.go and context.push

enum AppPaths { welcome, login, signin, home, cart, settings, editprofile, about, error404 }

final Map<AppPaths, String> allRoutes = {
  AppPaths.welcome: 'welcome',
  AppPaths.login: 'login',
  AppPaths.signin: 'signin',
  AppPaths.home: 'home',
  AppPaths.cart: 'cart',
  AppPaths.settings: 'settings',
  AppPaths.editprofile: 'editprofile',
  AppPaths.about: 'about',
  AppPaths.error404: 'error404'
};

final goRouter = GoRouter(
  /// all absolute paths (starting paths home,welcome,login)should start with a '/' and sub paths have to avoid it

  debugLogDiagnostics: true,
  initialLocation: locator<SharedPreferencesHelper>().getIsUserFirstTime()
      ? '/${allRoutes[AppPaths.welcome]}'
      : locator<SharedPreferencesHelper>().getIsUserLoggedIn() || locator<SharedPreferencesHelper>().getAnonymousLogIn()
          ? '/${allRoutes[AppPaths.home]}'
          : '/${allRoutes[AppPaths.login]}',
  errorBuilder: (context, state) => const ErrorPage(),
  routes: [
    GoRoute(
      name: allRoutes[AppPaths.welcome],
      path: '/${allRoutes[AppPaths.welcome]}',
      builder: (context, state) => const WelcomePage(),
    ),
    GoRoute(
        name: allRoutes[AppPaths.login],
        path: '/${allRoutes[AppPaths.login]}',
        builder: (context, state) => const LoginPage(),
        routes: [
          GoRoute(
            name: allRoutes[AppPaths.signin],
            path: '${allRoutes[AppPaths.signin]}',
            builder: (context, state) => const SignInPage(),
          ),
        ]),
    GoRoute(
        name: allRoutes[AppPaths.home],
        path: '/${allRoutes[AppPaths.home]}',
        builder: (context, state) => const HomePage(),
        routes: [
          GoRoute(
            name: allRoutes[AppPaths.cart],
            path: '${allRoutes[AppPaths.cart]}',
            builder: (context, state) => const CartPage(),
          ),
          GoRoute(
            name: allRoutes[AppPaths.settings],
            path: '${allRoutes[AppPaths.settings]}',
            builder: (context, state) => const SettingsPage(),
          ),
          GoRoute(
            name: allRoutes[AppPaths.about],
            path: '${allRoutes[AppPaths.about]}',
            builder: (context, state) => const AboutPage(),
          ),
          GoRoute(
              name: allRoutes[AppPaths.editprofile],
              path: '${allRoutes[AppPaths.editprofile]}/:usertoken',
              builder: (context, state) {
                return EditProfilePage(
                  usertoken: state.params['usertoken'],
                );
              }),
        ]),
    GoRoute(
      name: allRoutes[AppPaths.error404],
      path: '/${allRoutes[AppPaths.error404]}',
      builder: (context, state) => const ErrorPage(),
    ),
  ],

  /// official docs of go_router also describes a redirect parameter
  // https://gorouter.dev/redirection
  // to use provider and redirect user based on authState and its actually good
  // but we are using shared_prefs and its working well
  // so no need to create an extra provider and increase complexity
  // we just need to take care of the fact that we need to
  // empty shared_prefs on userLogout and use context.push(/login)
  // and that will do the job just fine
);

/// I keep forgetting that
/// go -> removes entire stack and push a new page
/// push -> stacks new page above current page

class ErrorPage extends StatelessWidget {
  const ErrorPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Error 404"),
      ),
      body: Center(
          child: TextButton(
        onPressed: () {
          context.pushNamed(allRoutes[AppPaths.home]!);
        },
        child: const Text("Lmao go to home? "),
      )),
    );
  }
}
