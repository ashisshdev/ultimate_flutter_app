import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:flutter/material.dart';
import 'package:ultimate_flutter_app/data/local/shared_prefs/shared_prefs_helper.dart';
import 'package:ultimate_flutter_app/dependency_injection.dart';
import 'package:ultimate_flutter_app/presentation/ui/app_theme/themes_data.dart';

class ThemeIconsTray extends StatelessWidget {
  const ThemeIconsTray({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ThemeIcon(color: Colors.pink.shade300, name: "pink"),
        const ThemeIcon(color: Colors.deepPurpleAccent, name: "darkBlue"),
        const ThemeIcon(color: Colors.deepOrangeAccent, name: "halloween"),
        const ThemeIcon(color: Colors.black, name: "dark"),
        const ThemeIcon(color: Colors.white, name: "light"),
      ],
    );
  }
}

class ThemeIcon extends StatelessWidget {
  final Color color;
  final String name;

  const ThemeIcon({Key? key, required this.color, required this.name}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bool isActive = ThemeModelInheritedNotifier.of(context).theme == allThemes[name];

    return ThemeSwitcher(
      builder: (BuildContext context) {
        return InkWell(
          onTap: isActive
              ? () {}
              : () {
                  locator<SharedPreferencesHelperImpl>().setTheme(name).then((value) {
                    if (value) {
                      String theme = locator<SharedPreferencesHelperImpl>().getTheme()!;

                      ThemeSwitcher.of(context).changeTheme(theme: allThemes[theme]!);
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                          content: Text("Error saving theme and changing "
                              "it")));
                    }
                  });
                },
          child: Container(
            height: 50,
            width: 50,
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
                gradient: isActive
                    ? const LinearGradient(
                        colors: [Colors.green, Colors.white, Colors.pink, Colors.yellow, Colors.black])
                    : null,
                borderRadius: const BorderRadius.all(Radius.circular(40))),
            alignment: Alignment.center,
            child: Container(
              decoration: BoxDecoration(color: color, borderRadius: const BorderRadius.all(Radius.circular(40))),
            ),
          ),
        );
      },
    );
  }
}
