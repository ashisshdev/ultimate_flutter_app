import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ultimate_flutter_app/data/local/shared_prefs/shared_prefs_helper.dart';
import 'package:ultimate_flutter_app/presentation/ui/pages/auth/login.dart';
import 'package:ultimate_flutter_app/presentation/ui/pages/auth/signup.dart';
import 'package:ultimate_flutter_app/presentation/ui/pages/homepage/homepage.dart';
import 'package:ultimate_flutter_app/presentation/ui/pages/onboarding/onboarding_screen.dart';

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

  /// If I want to implement a page transition animation then I have to use pageBuilder instead of builder in GoRouter()

  debugLogDiagnostics: true,
  initialLocation: locator<SharedPreferencesHelperImpl>().getIsUserFirstTime()
      ? '/${allRoutes[AppPaths.welcome]}'
      : locator<SharedPreferencesHelperImpl>().getIsUserLoggedIn() ||
              locator<SharedPreferencesHelperImpl>().getAnonymousLogIn()
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
            pageBuilder: (context, state) => FadingPageTransition(child: const CartPage()),
          ),
          GoRoute(
            name: allRoutes[AppPaths.settings],
            path: '${allRoutes[AppPaths.settings]}',
            pageBuilder: (context, state) => CustomFadeAndScaleTransition(child: const SettingsPage()),
          ),
          GoRoute(
            name: allRoutes[AppPaths.about],
            path: '${allRoutes[AppPaths.about]}',
            pageBuilder: (context, state) =>
                SlidingPageTransition(direction: AxisDirection.left, child: const AboutPage()),
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
/// replace -> replace current page with new page on current stack

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

/// custom page transition animations
Offset getOffset(AxisDirection direction) {
  switch (direction) {
    case AxisDirection.up:
      return const Offset(0, 1);
    case AxisDirection.down:
      return const Offset(0, -1);
    case AxisDirection.right:
      return const Offset(-1, 0);
    case AxisDirection.left:
      return const Offset(1, 0);
    default:
      return const Offset(1, 0);
  }
}

final tween = Tween(begin: 0.0, end: 1.0).chain(CurveTween(curve: Curves.ease));

class FadingPageTransition extends CustomTransitionPage<void> {
  FadingPageTransition({
    required Widget child,
  }) : super(
            transitionsBuilder: (BuildContext context, Animation<double> animation,
                    Animation<double> secondaryAnimation, Widget child) =>
                FadeTransition(
                  opacity: animation.drive(_curveTween),
                  child: child,
                ),
            child: child);

  static final CurveTween _curveTween = CurveTween(curve: Curves.easeIn);
}

class SlidingPageTransition extends CustomTransitionPage<void> {
  final AxisDirection direction;

  SlidingPageTransition({
    required this.direction,
    required Widget child,
  }) : super(
            transitionsBuilder: (BuildContext context, Animation<double> animation,
                    Animation<double> secondaryAnimation, Widget child) =>
                SlideTransition(
                  position: Tween<Offset>(begin: getOffset(direction), end: Offset.zero).animate(animation),
                  child: child,
                ),
            child: child);
}

class CustomFadeAndScaleTransition extends CustomTransitionPage<void> {
  CustomFadeAndScaleTransition({required Widget child})
      : super(
            transitionsBuilder: (BuildContext context, Animation<double> animation,
                    Animation<double> secondaryAnimation, Widget child) =>
                ScaleTransition(scale: animation.drive(tween), child: FadeTransition(opacity: animation, child: child)),
            child: child);
}

/// can be used in case of dialog boxes ??
class CustomScaleTransition extends PageRouteBuilder {
  final Widget child;

  CustomScaleTransition({required this.child})
      : super(
            transitionDuration: const Duration(seconds: 2),
            pageBuilder: (context, animation, secondaryAnimation) => child);

  @override
  Widget buildTransitions(
          BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation, Widget child) =>
      ScaleTransition(scale: animation, child: child);
}
