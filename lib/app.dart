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
                          ? context.goNamed(allRoutes[AppPaths.home]!)
                          : context.goNamed(allRoutes[AppPaths.login]!);
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
                              Provider.of<HomePageController>(context, listen: false).changeIndex(0);
                              context.goNamed(allRoutes[AppPaths.home]!);
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
                          context.goNamed(allRoutes[AppPaths.home]!);
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Some Error")));
                        }
                      });
                    },
                    child: Text("Anonymous Login")),
                SizedBox(
                  height: 150,
                ),
                TextButton(
                    onPressed: () {
                      context.pushNamed(allRoutes[AppPaths.signin]!);
                    },
                    child: Text("Create an account?"))
              ],
            ),
          )
        ],
      ),
    );
  }
}

class SignInPage extends StatelessWidget {
  const SignInPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("SignIn Page"),
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
                          locator<SharedPreferencesHelper>()
                              .setUserToken("someNewUserToken - yes new signUp")
                              .then((value) {
                            if (value) {
                              context.goNamed(allRoutes[AppPaths.home]!);
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
                //   TextButton(
                //       onPressed: () {
                //         /// set anonymous true and save all user data locally
                //         /// no user token will be saved
                //         /// if he creates an account in future then his data will be sent to server
                //         locator<SharedPreferencesHelper>().setAnonymousLogIn(loggedIn: true).then((value) {
                //           if (value) {
                //             Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => HomePage()));
                //           } else {
                //             ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Some Error")));
                //           }
                //         });
                //       },
                //       child: Text("Anonymous Login"))
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
    final homePageProvider = Provider.of<HomePageController>(context, listen: true);

    Future<bool> _onWillPop() async {
      /// check if user is on main page of home screen
      /// if yes then return true
      /// else set the _current index to 0

      if (homePageProvider.currentIndex != 0) {
        homePageProvider.changeIndex(0);
        return false;
      } else {
        return true;
      }
    }

    return ThemeSwitchingArea(
      child: WillPopScope(
        onWillPop: _onWillPop,
        child: Scaffold(
          appBar: appBars[homePageProvider.currentIndex],
          drawer: Drawer(
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                const DrawerHeader(
                  decoration: BoxDecoration(
                    color: Colors.blue,
                  ),
                  child: Text('Drawer Header'),
                ),
                ListTile(
                  title: const Text('Go to settings'),
                  onTap: () {
                    context.goNamed(allRoutes[AppPaths.settings]!);
                  },
                ),
                ListTile(
                  title: const Text('Go to about'),
                  onTap: () {
                    context.goNamed(allRoutes[AppPaths.about]!);

                    /// on web, the drawer does not go back when we click on one of its item
                    /// so this next line will ensure that
                  },
                ),
              ],
            ),
          ),

          /// here a Page view can also be used instead of Indexed Stack and that will give us the ability to
          /// navigate between homepage sections by swiping
          /// for that we will have to utilize AutomaticKeepAliveClientMixin
          body: IndexedStack(
            index: homePageProvider.currentIndex,
            children: [
              HomePageSection1(),
              HomePageSection2(),
              HomePageSection3(),
              HomePageSection4(),
            ],
          ),
          bottomNavigationBar: BottomNavigationBar(
            elevation: 0.6,
            backgroundColor: Colors.deepPurple,
            currentIndex: homePageProvider.currentIndex, //New
            onTap: homePageProvider.changeIndex,
            //     (index){
            //   homePageProvider.changeIndex(index);
            // },
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: 'Calls',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.explore_outlined),
                label: 'Explore',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.favorite),
                label: 'Activity',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.person),
                label: 'Profile',
              ),
            ],
          ),
        ),
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

List<PreferredSizeWidget> appBars = [AppBar1(), AppBar2(), AppBar3(), AppBar4()];

class AppBar1 extends StatelessWidget implements PreferredSizeWidget {
  const AppBar1({Key? key}) : super(key: key);

  @override
  Size get preferredSize => Size.fromHeight(60);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text("Home page section 1"),
      centerTitle: true,
      actions: [
        IconButton(
            onPressed: () {
              context.goNamed(allRoutes[AppPaths.cart]!);
            },
            icon: Icon(Icons.add_shopping_cart))
      ],
    );
  }
}

class AppBar2 extends StatelessWidget implements PreferredSizeWidget {
  const AppBar2({Key? key}) : super(key: key);

  @override
  Size get preferredSize => Size.fromHeight(60);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text("Home page section 2"),
      centerTitle: true,
      actions: [
        IconButton(
            onPressed: () {
              context.goNamed(allRoutes[AppPaths.cart]!);
            },
            icon: Icon(Icons.add_shopping_cart))
      ],
    );
  }
}

class AppBar3 extends StatelessWidget implements PreferredSizeWidget {
  const AppBar3({Key? key}) : super(key: key);

  @override
  Size get preferredSize => Size.fromHeight(60);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text("Home page section 3"),
      centerTitle: true,
      actions: [
        IconButton(
            onPressed: () {
              context.goNamed(allRoutes[AppPaths.cart]!);
            },
            icon: Icon(Icons.add_shopping_cart))
      ],
    );
  }
}

class AppBar4 extends StatelessWidget implements PreferredSizeWidget {
  const AppBar4({Key? key}) : super(key: key);

  @override
  Size get preferredSize => Size.fromHeight(60);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text("Home page section 4"),
      centerTitle: true,
      actions: [
        IconButton(
            onPressed: () {
              context.goNamed(allRoutes[AppPaths.cart]!);
            },
            icon: Icon(Icons.add_shopping_cart))
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

class HomePageSection2 extends StatelessWidget {
  const HomePageSection2({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.red,
      body: Container(
        child: Center(
          child: TextButton(
            onPressed: () {
              context.pushNamed(allRoutes[AppPaths.cart]!);
            },
            child: Text("Go to cart"),
          ),
        ),
      ),
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
        children: [
          ThemeIconsTray(),
        ],
      ),
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
          SizedBox(
            height: 50,
          ),
          locator<SharedPreferencesHelper>().getIsUserLoggedIn()
              ? TextButton(
                  onPressed: () {
                    context.pushNamed(allRoutes[AppPaths.editprofile]!,
                        params: <String, String>{'usertoken': locator<SharedPreferencesHelper>().getUserToken()!});
                  },
                  child: Text("uer is properly logged in Go to editProfile"))
              : Text("Not logged in properly"),
          SizedBox(
            height: 50,
          ),
          locator<SharedPreferencesHelper>().getAnonymousLogIn()
              ? TextButton(
                  onPressed: () {
                    /// we are not pushing user so that he can come back if the changes his mind to logIn
                    /// and if he logs in then the stack will be rebuilt again with home in root
                    context.pushNamed(allRoutes[AppPaths.login]!);
                  },
                  child: Text("user is anonymously logged in, cant go to edit profile page, logIn properly now? "))
              : Container(),
          SizedBox(
            height: 100,
          ),
          TextButton(
              onPressed: () {
                locator<SharedPreferencesHelper>().clearPreferenceValuesExceptWelcome().then((value) {
                  if (value) {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Logged out")));

                    context.goNamed(allRoutes[AppPaths.login]!);
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Error logging out")));
                  }
                });
              },
              child: Text("LogOut")),
        ],
      ),
    );
  }
}

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
  EditProfilePage({Key? key, required this.usertoken}) : super(key: key);

  String? usertoken;

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
