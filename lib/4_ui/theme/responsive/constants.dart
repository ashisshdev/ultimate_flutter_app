// Responsive Screens Breakpoints
import 'package:flutter/cupertino.dart';

const tabletBreakpoint = 700;
const desktopBreakpoint = 1100;

// helper functions to get  current device height and width
deviceWidth(context) {
  return MediaQuery.of(context).size.width;
}

deviceHeight(context) {
  return MediaQuery.of(context).size.height;
}

// default constraints
const defaultPadding = 16.0;

// helper constraints
const padding10 = 10.0;
const padding20 = 20.0;
const padding30 = 30.0;
const padding40 = 40.0;
const padding50 = 50.0;
const padding60 = 60.0;
const padding70 = 70.0;
const padding80 = 80.0;
