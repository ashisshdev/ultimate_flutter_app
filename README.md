# ultimate_flutter_app

A flutter project to display all the aspects of developing applicatins with Flutter. (CrossPlatform, AppArchitech, StateManagement, Localization and much more)

I guess I figured out the ultimate flutter folder structure, data flow and all other stuff. This is a project where i will try implementing everything



Routes
SharedPrefs
AnimatedTheming

APIs 101 (base, exceptions, dartz, repositories , abstractions )
Authentication - post Method
get posts - get Method (caching with sqflite)
post post - post Method
update user info - Update method
delete account - delete Method

local Notifications 101

stateManagement with Provider (base controllers with state enum (initial,loading,success,error)


after above all Need to change provider with bloc
and do stateManagement with Bloc 101

only after that I will be able to start working on portfolio level apps !!!



----

2-3 big apps (with different approaches like provider/bloc, MVVP/packages etc) with tests
many UIs - lots of UIs
and 1 miniApps App - apiNinja complete apis - with tests

----------------
Notes while implementing animated theme switcher

1 get current system theme by checking brightness of the app
    final isPlatformDark = WidgetsBinding.instance!.window.platformBrightness == Brightness.dark;
    final initTheme = isPlatformDark ? darkTheme : lightTheme;

2 wrap material app inside ThemeProvider

3 wrap scaffold of the pages that have the capability to switch themes

4 use ThemeModelInheritedNotifier.of(context).theme == allThemes[name],
to check if current theme is some specific theme

5 to switch themes
wrap the switching widget inside     ThemeSwitcher(
onTap:(){},
builder: (){})
// can provide custom clipper as well
box change effect or circular effect ..

6 use to switch themes
ThemeSwitcher.of(context).changeTheme(theme: allThemes[name]);


Notes of go_router


next step is to implement reposonsiveness using this
https://pub.dev/packages/flutter_screenutil
https://dhruvnakum.xyz/how-to-make-a-pixel-perfect-flutter-application


----------------


## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://flutter.dev/docs/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://flutter.dev/docs/cookbook)

For help getting started with Flutter, view our
[online documentation](https://flutter.dev/docs), which offers tutorials,
samples, guidance on mobile development, and a full API reference.
