import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get_it/get_it.dart';
import 'package:ultimate_flutter_app/data/http/some_api_service.dart';
import 'package:ultimate_flutter_app/presentation/controllers/home_section2_provider.dart';
import 'package:ultimate_flutter_app/presentation/controllers/homepage_provider.dart';

import 'data/http/helper/base_http.dart';
import 'data/local/shared_prefs/shared_prefs_helper.dart';
import 'domain/repositories/some_api_service_repository.dart';

GetIt locator = GetIt.instance;

setUpDependencies() async {
  // the hierarchy goes from up to bottom
  // helpers (base http client) (SingleTons) -> services (data) (SingleTons) -> Repositories (accepting services as
  // parameters) (SingleTons) -> controllers (accepting repositories as parameters ) (Factories)

  /// there are two ways to register singletons
  // 1 normal way
  // 2 lazy way
  // example of both are :
  ///   locator.registerSingleton<SomeRepository>(SomeRepositoryImpl(locator(), locator()));
  ///   locator.registerLazySingleton<SomeRepository>(() => SomeRepositoryImpl(locator(), locator()));
  /// use lazy constructors to reduce loading time

  /// services helpers
  locator.registerLazySingleton<Server>(() => Server());

  /// actual services
  locator.registerSingleton<SharedPreferencesHelperImpl>(SharedPreferencesHelperImpl()); // no good in lazy registration
  // it will be used as soon as app is opened
  /// this is a initialization and should go into main() method but its an exception
  /// we are registering the helper class here therefore doing the initialization here
  /// instead of doing at some other place and increase chance of forgetting stuff
  /// in case we have to remove this helper service file ..
  await locator<SharedPreferencesHelperImpl>().initPrefs();

  locator.registerSingleton<SomeApiServiceImpl>(SomeApiServiceImpl());

  /// repositories
  locator.registerSingleton<SomeRepositoryImpl>(
      SomeRepositoryImpl(someApiServiceImpl: locator(), sharedPreferencesHelperImpl: locator()));

  // locator.registerLazySingleton<SomeRepository>(
  //   () => SomeRepositoryImpl(
  //     sharedPreferencesHelperImpl: locator(),
  //     someApiServiceImpl: locator(),
  //   ),
  // );

  /// controllers
  locator.registerFactory<HomePageController>(() => HomePageController());

  locator.registerFactory<HomeSection2Controller>(() => HomeSection2Controller(someRepositoryImpl: locator()));

  /// after dependency injection, native splash is removed
  /// read for more
  FlutterNativeSplash.remove();
}
