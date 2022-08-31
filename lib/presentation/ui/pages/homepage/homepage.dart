import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:ultimate_flutter_app/presentation/ui/pages/homepage/section1/section1_home.dart';
import 'package:ultimate_flutter_app/presentation/ui/pages/homepage/section2/section2_explore.dart';
import 'package:ultimate_flutter_app/presentation/ui/pages/homepage/section3/section3_activity.dart';
import 'package:ultimate_flutter_app/presentation/ui/pages/homepage/section4/section4_profile.dart';
import 'package:ultimate_flutter_app/utils/routes.dart';

import '../../../controllers/homepage_provider.dart';

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
            children: const [
              HomePageSection1(),
              HomePageSection2(),
              HomePageSection3(),
              HomePageSection4(),
            ],
          ),

          /// some fancy bottom nav bar can also be used here
          /// such as :
          /// https://pub.dev/packages/curved_navigation_bar
          ///https://pub.dev/packages/dot_navigation_bar
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
                label: 'Home',
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

List<PreferredSizeWidget> appBars = [const AppBar1(), const AppBar2(), const AppBar3(), const AppBar4()];
