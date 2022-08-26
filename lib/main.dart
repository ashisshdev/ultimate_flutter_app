// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:go_router/go_router.dart';
import 'package:ultimate_flutter_app/app.dart';

import 'dependency_injection.dart';

void main() async {
  /// Native splash screen is implemented for both dark and light theme
  /// we will now preserve the splash screen until dependencies are injected
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle.dark.copyWith(statusBarColor: Colors.black38),
  );

  /// there are lots of initializations that should not be done in the setUpDependencies()
  /// because the sole purpose of setUpDependencies is to setUp Dependent classes and services

  // turn off the # in the URLs on the web
  GoRouter.setUrlPathStrategy(UrlPathStrategy.path);

  await setUpDependencies();

  runApp(MyApp());
}
