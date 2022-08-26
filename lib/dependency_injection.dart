import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get_it/get_it.dart';
import 'package:ultimate_flutter_app/1_services/local/shared_prefs/shared_prefs_helper.dart';
import 'package:ultimate_flutter_app/3_controllers/homepage_provider.dart';

GetIt locator = GetIt.instance;

setUpDependencies() async {
  // the hierarchy goes from up to bottom
  // services (data) (SingleTons mostly) -> Repositories (accepting services as parameters)  -> controllers (accepting
  // repositories as parameters )

  /// use lazy constructors to reduce loading time

  // register services and repositories as singletons
  locator.registerSingleton(SharedPreferencesHelper());

  /// this is a initialization and should go into main() method but its an exception
  /// we are registering the helper class here therefore doing the initialization here
  /// instead of doing at some other place and increase chance of forgetting stuff
  /// in case we have to remove this helper service file ..
  await locator<SharedPreferencesHelper>().initPrefs();

  // register controllers as factories
  locator.registerFactory<HomePageController>(() => HomePageController());

  /// after dependency injection, native splash is removed
  /// read for more
  FlutterNativeSplash.remove();
}
