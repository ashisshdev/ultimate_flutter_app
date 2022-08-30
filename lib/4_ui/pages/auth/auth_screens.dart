import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../../1_services/local/shared_prefs/shared_prefs_helper.dart';
import '../../../3_controllers/homepage_provider.dart';
import '../../../dependency_injection.dart';
import '../../../utils/routes.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Login Page"),
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
                              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                                  content: Text("Login success but "
                                      "user token not saved successfully ")));
                            }
                          });
                        } else {
                          ScaffoldMessenger.of(context)
                              .showSnackBar(const SnackBar(content: Text("Some Error while login")));
                        }
                      });
                    },
                    child: const Text("Login\n(email,phone,google,facebook,twitter etc..)")),
                const SizedBox(
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
                          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Some Error")));
                        }
                      });
                    },
                    child: const Text("Anonymous Login")),
                const SizedBox(
                  height: 150,
                ),
                TextButton(
                    onPressed: () {
                      context.pushNamed(allRoutes[AppPaths.signin]!);
                    },
                    child: const Text("Create an account?"))
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
        title: const Text("SignIn Page"),
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
                              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                                  content: Text("Login success but "
                                      "user token not saved successfully ")));
                            }
                          });
                        } else {
                          ScaffoldMessenger.of(context)
                              .showSnackBar(const SnackBar(content: Text("Some Error while login")));
                        }
                      });
                    },
                    child: const Text("Login\n(email,phone,google,facebook,twitter etc..)")),
                const SizedBox(
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
