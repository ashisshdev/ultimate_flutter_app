// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ultimate_flutter_app/1_services/local/shared_prefs/shared_prefs_helper.dart';
import 'package:ultimate_flutter_app/3_controllers/homepage_provider.dart';
import 'package:ultimate_flutter_app/4_ui/theme/themes_data.dart';
import 'package:ultimate_flutter_app/dependency_injection.dart';
import 'package:ultimate_flutter_app/utils/routes.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  /// this is where the app will start when splash screen is done
  /// we will provide MultiProvider widget as a parent of MaterialApp

  /// checking system theme and setting initial theme accordingly because for first time theme data would be null
  getCurrentTheme() {
    String? themeName = locator<SharedPreferencesHelper>().getTheme();
    if (themeName == null) {
      final isPlatformDark = WidgetsBinding.instance.window.platformBrightness == Brightness.dark;
      themeName = isPlatformDark ? 'light' : 'dark';
    }
    return allThemes[themeName];
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        /// this can look tedious here, I can define a list of these providers in dependency_injection.dart file and
        /// provide that list here to make code more readable
        ChangeNotifierProvider<HomePageController>(create: (_) => locator<HomePageController>()),
      ],
      child: ThemeProvider(
        initTheme: getCurrentTheme(),
        builder: (_, theme) {
          return MaterialApp.router(
              routeInformationParser: goRouter.routeInformationParser,
              routerDelegate: goRouter.routerDelegate,
              routeInformationProvider: goRouter.routeInformationProvider,
              theme: theme

              /// integrate custom route transitions here in theming
              /// https://medium.com/geekculture/defining-custom-page-transitions-in-flutter-e2972a464be

              /// now here we will decide if user is first time and loggedIn or anonynosmy loggedIn or what
              /// and we will show on-boarding or homescreen or accordingly
              /// but first routes !!
              // home: locator<SharedPreferencesHelper>().getIsUserFirstTime()
              //     ? WelcomePage()
              //     : locator<SharedPreferencesHelper>().getIsUserLoggedIn() ||
              //             locator<SharedPreferencesHelper>().getAnonymousLogIn()
              //         ? HomePage()
              //         : LoginPage()
              );
        },
      ),
    );
  }
}

// class HomePageSection1 extends StatelessWidget {
//   const HomePageSection1({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       color: Colors.green,
//     );
//   }
// }
//
// class HomePageSection2 extends StatelessWidget {
//   const HomePageSection2({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       color: Colors.yellow,
//     );
//   }
// }
//
// class HomePageSection3 extends StatelessWidget {
//   const HomePageSection3({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       color: Colors.redAccent,
//     );
//   }
// }
//
// class HomePageSection4 extends StatelessWidget {
//   const HomePageSection4({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       color: Colors.blue,
//     );
//   }
// }

class CartPage extends StatelessWidget {
  const CartPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Cart Screen"),
      ),
    );
  }
}

class AboutPage extends StatelessWidget {
  const AboutPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("About App Screen"),
      ),
    );
  }
}

class SettingsPage extends StatelessWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("SettingsPage Screen"),
      ),
    );
  }
}

class EditProfilePage extends StatelessWidget {
  const EditProfilePage({Key? key, required this.usertoken}) : super(key: key);

  final String? usertoken;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("EditProfilePage Screen"),
      ),
      body: Center(
        child: Column(
          children: [
            Text("Only is visible if user is properly logged in"),
            SizedBox(
              height: 50,
            ),
            Text(usertoken ?? "No user token"),
            SizedBox(
              height: 50,
            ),
          ],
        ),
      ),
    );
  }
}
