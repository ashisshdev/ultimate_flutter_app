import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;
import 'package:ultimate_flutter_app/data/http/some_api_service.dart';
import 'package:ultimate_flutter_app/data/local/shared_prefs/shared_prefs_helper.dart';

abstract class SomeRepository {
  Future<Either<Exception, http.Response>> getSuccess1();
  Future<Either<Exception, http.Response>> getSuccess2();
  Future<Either<Exception, http.Response>> getFailure1();
  Future<Either<Exception, http.Response>> getFailure2();
  Future<Either<Exception, http.Response>> getFailure3();

  Future<Either<Exception, http.Response>> postSuccess1();
  Future<Either<Exception, http.Response>> postSuccess2();
  Future<Either<Exception, http.Response>> postFailure1();
  Future<Either<Exception, http.Response>> postFailure2();
  Future<Either<Exception, http.Response>> postFailure3();

  Future<Either<Exception, http.Response>> updateSuccess();
  Future<Either<Exception, http.Response>> updateFailure1();
  Future<Either<Exception, http.Response>> updateFailure2();

  Future<Either<Exception, http.Response>> deleteSuccess();
  Future<Either<Exception, http.Response>> deleteFailure();
}

class SomeRepositoryImpl implements SomeRepository {
  final SomeApiServiceImpl someApiServiceImpl;
  final SharedPreferencesHelperImpl sharedPreferencesHelperImpl;

  /// this is where we understand the importance of repositories
  /// suppose we have to send user token while making a api call
  /// then we can directly take it from sharedPrefs here instead of requesting it from the controllers
  /// another scenario could be using a local db like hive or shared_prefs where we can check if we already have some
  /// data to show to the user and then make a fetchLatestData() request once user hits refresh
  /// this is what caching data is ..

  SomeRepositoryImpl({required this.someApiServiceImpl, required this.sharedPreferencesHelperImpl});

  @override
  Future<Either<Exception, http.Response>> getSuccess1() async {
    print("\nrunning success get method 1 in repo");

    /// perform some local db function?
    return await someApiServiceImpl.getDataSuccess1();

    /// perform some local db function?
  }

  @override
  Future<Either<Exception, http.Response>> getSuccess2() async {
    /// perform some local db function?
    return await someApiServiceImpl.getDataSuccess2();

    /// perform some local db function?
  }

  @override
  Future<Either<Exception, http.Response>> getFailure1() async {
    /// perform some local db function?
    return await someApiServiceImpl.getDataFailure1();

    /// perform some local db function?
  }

  @override
  Future<Either<Exception, http.Response>> getFailure2() async {
    /// perform some local db function?
    return await someApiServiceImpl.getDataFailure2();

    /// perform some local db function?
  }

  @override
  Future<Either<Exception, http.Response>> getFailure3() async {
    /// perform some local db function?
    /// do some modelling demodling (fromJson,toJson)
    /// do some encrypting, decrypting
    return await someApiServiceImpl.getDataFailure3();

    /// perform some local db function?
  }

  @override
  Future<Either<Exception, http.Response>> postSuccess1() async {
    return await someApiServiceImpl.postDataSuccess1();
  }

  @override
  Future<Either<Exception, http.Response>> postSuccess2() async {
    throw UnimplementedError();
  }

  @override
  Future<Either<Exception, http.Response>> postFailure1() async {
    return await someApiServiceImpl.postDataFailure1();
  }

  @override
  Future<Either<Exception, http.Response>> postFailure2() async {
    return await someApiServiceImpl.postDataSuccess2();
  }

  @override
  Future<Either<Exception, http.Response>> postFailure3() async {
    throw UnimplementedError();
  }

  @override
  Future<Either<Exception, http.Response>> updateSuccess() async {
    return await someApiServiceImpl.updateDataSuccess();
  }

  @override
  Future<Either<Exception, http.Response>> updateFailure1() async {
    return await someApiServiceImpl.updateDataFailure1();
  }

  @override
  Future<Either<Exception, http.Response>> updateFailure2() async {
    return await someApiServiceImpl.updateDataFailure2();
  }

  @override
  Future<Either<Exception, http.Response>> deleteSuccess() async {
    return await someApiServiceImpl.deleteDataSuccess();
  }

  @override
  Future<Either<Exception, http.Response>> deleteFailure() async {
    return await someApiServiceImpl.deleteDataFailure();
  }
}
