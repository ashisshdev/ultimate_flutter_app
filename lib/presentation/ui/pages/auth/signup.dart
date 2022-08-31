import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../data/local/shared_prefs/shared_prefs_helper.dart';
import '../../../../dependency_injection.dart';
import '../../../../utils/routes.dart';

List<String> genders = ["Male", "Female", "Other"];

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
                Form(
                  child: Column(
                    children: [],
                  ),
                ),
                TextButton(
                    onPressed: () {
                      /// after login/signIn  Process set isLogged = true
                      /// also save some user Token

                      /// register user on api
                      /// then save user token
                      /// then set shared_prefs and stuff etc..
                      locator<SharedPreferencesHelperImpl>().setIsUserLoggedIn(loggedIn: true).then((value) {
                        if (value) {
                          locator<SharedPreferencesHelperImpl>().setAnonymousLogIn(loggedIn: false);
                          locator<SharedPreferencesHelperImpl>()
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
              ],
            ),
          )
        ],
      ),
    );
  }
}
