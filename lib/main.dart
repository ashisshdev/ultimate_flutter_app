// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
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
  await setUpDependencies();
  runApp(MyApp());
}
