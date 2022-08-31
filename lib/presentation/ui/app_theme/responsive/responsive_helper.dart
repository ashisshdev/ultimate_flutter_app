import 'package:flutter/material.dart';

import 'constants.dart';

class Responsive extends StatelessWidget {
  final Widget mobileScaffold;
  final Widget? tabletScaffold;
  final Widget desktopScaffold;

  const Responsive({
    Key? key,
    required this.mobileScaffold,
    this.tabletScaffold,
    required this.desktopScaffold,
  }) : super(key: key);

  // functions that will help in case of deciding constraints for independent widgets
  static bool isMobile(BuildContext context) => MediaQuery.of(context).size.width < tabletBreakpoint;

  static bool isTablet(BuildContext context) =>
      MediaQuery.of(context).size.width < desktopBreakpoint && MediaQuery.of(context).size.width >= tabletBreakpoint;

  static bool isDesktop(BuildContext context) => MediaQuery.of(context).size.width >= desktopBreakpoint;

  @override
  Widget build(BuildContext context) {
    final Size _size = MediaQuery.of(context).size;
    // If our width is more than 1100 then we consider it a desktop
    if (_size.width >= desktopBreakpoint) {
      return desktopScaffold;
    }
    // If width it less then 1100 and more then 850 we consider it as tablet
    else if (_size.width >= tabletBreakpoint && tabletScaffold != null) {
      return tabletScaffold!;
    }
    // Or less then that we called it mobile
    else {
      return mobileScaffold;
    }
  }
}
