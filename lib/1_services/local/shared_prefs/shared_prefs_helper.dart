import 'package:shared_preferences/shared_preferences.dart';

enum SharedPrefsKeys { isUserFirstTime, isUserLoggedIn, anonymousLogIn, theme, userToken }

class SharedPreferencesHelper {
  // private constructor
  SharedPreferencesHelper._internal();

  // single instance -- singleton
  static final SharedPreferencesHelper _instance = SharedPreferencesHelper._internal();

  // everytime I create an instance of this class then this specfic instance will be utilised instead of creating a
  // new instance everytime
  factory SharedPreferencesHelper() => _instance;

  static late SharedPreferences _prefs;

  /// initializing this so we can reduce the time to fetch data from shared prefs
  /// the get methods will now be fast as they no longer need to be async
  /// very Important to be either called in main or while injecting dependencies !!
  initPrefs() async {
    _prefs = await SharedPreferences.getInstance();
    print("\n ->> yeashhhh prefs initialised <<- \n");
  }

  Future<bool> setIsUserFirstTime() async {
    return await setBool(SharedPrefsKeys.isUserFirstTime.toString(), false);
  }

  bool getIsUserFirstTime() {
    /// if the value is null that means user opened the app for the first time.
    return getBool(SharedPrefsKeys.isUserFirstTime.toString()) ?? true;
  }

  Future setTheme(String newTheme) async {
    return await setString(SharedPrefsKeys.theme.toString(), newTheme);
  }

  String? getTheme() {
    return getString(SharedPrefsKeys.theme.toString());
  }

  // Future<bool> setIsLightTheme({required bool isLightTheme}) async {
  //   return await setBool(SharedPrefsKeys.isLightTheme.toString(), isLightTheme);
  // }
  //
  // bool? getIsLightTheme() {
  //   return getBool(SharedPrefsKeys.isLightTheme.toString());
  // }

  Future<bool> setIsUserLoggedIn({required bool loggedIn}) async {
    return await setBool(SharedPrefsKeys.isUserLoggedIn.toString(), loggedIn);
  }

  bool getIsUserLoggedIn() {
    /// if the value is null or false then both means same thing
    return getBool(SharedPrefsKeys.isUserLoggedIn.toString()) ?? false;
  }

  Future<bool> setAnonymousLogIn({required bool loggedIn}) async {
    return await setBool(SharedPrefsKeys.anonymousLogIn.toString(), loggedIn);
  }

  bool getAnonymousLogIn() {
    /// if the value is null or false then both means same thing
    return getBool(SharedPrefsKeys.anonymousLogIn.toString()) ?? false;
  }

  Future<bool> setUserToken(String token) async {
    return await setString(SharedPrefsKeys.userToken.toString(), token);
  }

  String? getUserToken() {
    return getString(SharedPrefsKeys.userToken.toString());
  }

  /// Danger Zone - clears everything
  /// only use when user signsOut
  Future<bool> clearPreferenceValuesExceptWelcome() async {
    return await removeAllExceptWelcome();
  }

  /// How to use sharedPreference anywhere in the app??
  /// to get stuff, call
  /// locator<SharedPreferencesHelper>().someGetMethod();
  /// to set stuff, call
  /// await locator<SharedPreferencesHelper>().setSetMethod(someParameter).then((value) {
  ///   if set successfully -> value will be true;
  ///   else will -> value will be false;
  ///  });

  /// all helper methods
  /// -- Do Not Touch --
  //sets
  // all set methods returns bool
  // true if the set operation is successful
  // false is the value is not saved in sharedprefs

  static Future<bool> setBool(String key, bool value) async => await _prefs.setBool(key, value);

  static Future<bool> setDouble(String key, double value) async => await _prefs.setDouble(key, value);

  static Future<bool> setInt(String key, int value) async => await _prefs.setInt(key, value);

  static Future<bool> setString(String key, String value) async => await _prefs.setString(key, value);

  static Future<bool> setStringList(String key, List<String> value) async => await _prefs.setStringList(key, value);

  //gets
  bool? getBool(String key) => _prefs.getBool(key);

  static double? getDouble(String key) => _prefs.getDouble(key);

  static int? getInt(String key) => _prefs.getInt(key);

  static String? getString(String key) => _prefs.getString(key);

  static List<String>? getStringList(String key) => _prefs.getStringList(key);

  //deletes..
  static Future<bool> remove(String key) async => await _prefs.remove(key);

  static Future<bool> removeAllExceptWelcome() async {
    await remove(SharedPrefsKeys.anonymousLogIn.toString());
    await remove(SharedPrefsKeys.isUserLoggedIn.toString());
    await remove(SharedPrefsKeys.userToken.toString());
    return true;
  }

  static Future<bool> clear() async => await _prefs.clear();
}
