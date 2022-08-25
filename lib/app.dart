// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:ultimate_flutter_app/1_services/local/shared_prefs/shared_prefs_helper.dart';
import 'package:ultimate_flutter_app/3_controllers/homepage_provider.dart';
import 'package:ultimate_flutter_app/4_ui/shared/themeicon_widget.dart';
import 'package:ultimate_flutter_app/4_ui/theme/themes_data.dart';
import 'package:ultimate_flutter_app/dependency_injection.dart';

final goRouter = GoRouter(
  debugLogDiagnostics: true,
  initialLocation: locator<SharedPreferencesHelper>().getIsUserFirstTime()
      ? '/'
      : locator<SharedPreferencesHelper>().getIsUserLoggedIn() || locator<SharedPreferencesHelper>().getAnonymousLogIn()
          ? 'home'
          : 'login',
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const WelcomePage(),
    ),
    GoRoute(
      path: 'login',
      builder: (context, state) => const LoginPage(),
    ),
    GoRoute(
      path: 'home',
      builder: (context, state) => const HomePage(),
    ),
    GoRoute(
      path: 'modal',
      builder: (context, state) => const HomePage2(),
    ),
    GoRoute(
      path: 'modal',
      builder: (context, state) => const HomePage3(),
    ),
  ],
);

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  /// this is where the app will start when splash screen is done
  /// we will provide MultiProvider widget as a parent of MaterialApp

  /// checking system theme and setting initial theme accordingly because for first time theme data would be null
  getCurrentTheme() {
    String? themeName = locator<SharedPreferencesHelper>().getTheme();
    if (themeName == null) {
      final isPlatformDark = WidgetsBinding.instance!.window.platformBrightness == Brightness.dark;
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
              theme: theme

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

class WelcomePage extends StatelessWidget {
  const WelcomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    /// gotta integrate change theme option in this page flow
    return ThemeSwitchingArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("welcome page"),
          centerTitle: true,
        ),
        body: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(top: 70),
              child: Text("HEHE set the shared prefs to is user first time false"),
            ),
            Padding(
              padding: EdgeInsets.only(top: 20),
              child: TextButton(
                child: Text("Move forward now "),
                onPressed: () async {
                  await locator<SharedPreferencesHelper>().setIsUserFirstTime().then((value) async {
                    if (value) {
                      locator<SharedPreferencesHelper>().getIsUserLoggedIn() ||
                              locator<SharedPreferencesHelper>().getAnonymousLogIn()
                          ? Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => HomePage()))
                          : Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => LoginPage()));
                    }
                  });
                },
              ),
            ),
            SizedBox(
              height: 30,
            ),
            ThemeIconsTray(),
          ],
        ),
      ),
    );
  }
}

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Login Page"),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Center(
            child: Column(
              children: [
                TextButton(
                    onPressed: () {
                      /// after login/signIn  Process set isLogged = true
                      /// also save some user Token
                      locator<SharedPreferencesHelper>().setIsUserLoggedIn(loggedIn: true).then((value) {
                        if (value) {
                          locator<SharedPreferencesHelper>().setAnonymousLogIn(loggedIn: false);
                          locator<SharedPreferencesHelper>().setUserToken("someUserToken").then((value) {
                            if (value) {
                              Navigator.of(context)
                                  .pushReplacement(MaterialPageRoute(builder: (context) => HomePage()));
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                  content: Text("Login success but "
                                      "user token not saved successfully ")));
                            }
                          });
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Some Error while login")));
                        }
                      });
                    },
                    child: Text("Login\n(email,phone,google,facebook,twitter etc..)")),
                SizedBox(
                  height: 50,
                ),
                TextButton(
                    onPressed: () {
                      /// set anonymous true and save all user data locally
                      /// no user token will be saved
                      /// if he creates an account in future then his data will be sent to server
                      locator<SharedPreferencesHelper>().setAnonymousLogIn(loggedIn: true).then((value) {
                        if (value) {
                          Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => HomePage()));
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Some Error")));
                        }
                      });
                    },
                    child: Text("Anonymous Login"))
              ],
            ),
          )
        ],
      ),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ThemeSwitchingArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("Home page"),
          centerTitle: true,
        ),
        body: Column(
          children: [
            SizedBox(
              height: 50,
            ),
            Text(locator<SharedPreferencesHelper>().getAnonymousLogIn() ? "true anonymous" : "false anonymous"),
            Text(locator<SharedPreferencesHelper>().getUserToken() ?? "no token available "),
            SizedBox(
              height: 50,
            ),
            TextButton(
                onPressed: () {
                  /// here I have to clean all sharedPrefs values except isFirstTime and then remove all views from the
                  /// stack and redirect user to LogIn Page
                  locator<SharedPreferencesHelper>().clearPreferenceValuesExceptWelcome().then((value) {
                    if (value) {
                      Navigator.of(context).pushAndRemoveUntil(
                          MaterialPageRoute(builder: (context) => LoginPage()), (Route<dynamic> route) => false);
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Some Error")));
                    }
                  });
                },
                child: Text("Log Out")),
            SizedBox(
              height: 100,
            ),
            ThemeIconsTray()
          ],
        ),
      ),
    );
  }
}

class HomePage2 extends StatelessWidget {
  const HomePage2({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ThemeSwitchingArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("Home page 2"),
          centerTitle: true,
        ),
        body: Column(
          children: [
            SizedBox(
              height: 50,
            ),
            Text(locator<SharedPreferencesHelper>().getAnonymousLogIn() ? "true anonymous" : "false anonymous"),
            Text(locator<SharedPreferencesHelper>().getUserToken() ?? "no token available "),
            SizedBox(
              height: 50,
            ),
            TextButton(
                onPressed: () {
                  /// here I have to clean all sharedPrefs values except isFirstTime and then remove all views from the
                  /// stack and redirect user to LogIn Page
                  locator<SharedPreferencesHelper>().clearPreferenceValuesExceptWelcome().then((value) {
                    if (value) {
                      Navigator.of(context).pushAndRemoveUntil(
                          MaterialPageRoute(builder: (context) => LoginPage()), (Route<dynamic> route) => false);
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Some Error")));
                    }
                  });
                },
                child: Text("Log Out")),
            SizedBox(
              height: 100,
            ),
            ThemeIconsTray()
          ],
        ),
      ),
    );
  }
}

class HomePage3 extends StatelessWidget {
  const HomePage3({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ThemeSwitchingArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("Home page 3"),
          centerTitle: true,
        ),
        body: Column(
          children: [
            SizedBox(
              height: 50,
            ),
            Text(locator<SharedPreferencesHelper>().getAnonymousLogIn() ? "true anonymous" : "false anonymous"),
            Text(locator<SharedPreferencesHelper>().getUserToken() ?? "no token available "),
            SizedBox(
              height: 50,
            ),
            TextButton(
                onPressed: () {
                  /// here I have to clean all sharedPrefs values except isFirstTime and then remove all views from the
                  /// stack and redirect user to LogIn Page
                  locator<SharedPreferencesHelper>().clearPreferenceValuesExceptWelcome().then((value) {
                    if (value) {
                      Navigator.of(context).pushAndRemoveUntil(
                          MaterialPageRoute(builder: (context) => LoginPage()), (Route<dynamic> route) => false);
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Some Error")));
                    }
                  });
                },
                child: Text("Log Out")),
            SizedBox(
              height: 100,
            ),
            ThemeIconsTray()
          ],
        ),
      ),
    );
  }
}
