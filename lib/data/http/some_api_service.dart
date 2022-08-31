import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;

import '../../dependency_injection.dart';
import 'helper/base_http.dart';

abstract class SomeApiService {
  /// get method
  Future<Either<Exception, http.Response>> getDataSuccess1();
  Future<Either<Exception, http.Response>> getDataSuccess2();
  Future<Either<Exception, http.Response>> getDataFailure1();
  Future<Either<Exception, http.Response>> getDataFailure2();
  Future<Either<Exception, http.Response>> getDataFailure3();

  /// post method
  Future<Either<Exception, http.Response>> postDataSuccess1();
  Future<Either<Exception, http.Response>> postDataSuccess2();
  Future<Either<Exception, http.Response>> postDataFailure1();
  Future<Either<Exception, http.Response>> postDataFailure2();
  Future<Either<Exception, http.Response>> postDataFailure3();

  /// put/update method
  Future<Either<Exception, http.Response>> updateDataSuccess();
  Future<Either<Exception, http.Response>> updateDataFailure1();
  Future<Either<Exception, http.Response>> updateDataFailure2();

  /// delete method
  Future<Either<Exception, http.Response>> deleteDataSuccess();
  Future<Either<Exception, http.Response>> deleteDataFailure();
}

String baseUrl = "https://reqres.in/api/";

class SomeApiServiceImpl implements SomeApiService {
  SomeApiServiceImpl._internal();
  static final SomeApiServiceImpl _instance = SomeApiServiceImpl._internal();
  factory SomeApiServiceImpl() => _instance;

  final Server _server = locator<Server>();

  /// some random api get functions
  @override
  Future<Either<Exception, http.Response>> getDataSuccess1() async {
    return await _server.get(baseUrl, "users/2");
  }

  @override
  Future<Either<Exception, http.Response>> getDataSuccess2() async {
    return await _server.get(baseUrl, "unknown/2");
  }

  @override
  Future<Either<Exception, http.Response>> getDataFailure1() async {
    // no such user exist so it will throw 404
    return await _server.get(baseUrl, "users/523");
  }

  @override
  Future<Either<Exception, http.Response>> getDataFailure2() async {
    // no such endpoint exist so it will throw error
    return await _server.get(baseUrl, "hehe");
  }

  @override
  Future<Either<Exception, http.Response>> getDataFailure3() async {
    /// disconnect internet so it throws socket exception
    return await _server.get(baseUrl, "users/25");
  }

  /// some random api post functions
  @override
  Future<Either<Exception, http.Response>> postDataSuccess1() async {
    // registering a user
    var payload = {"email": "eve.holt@reqres.in", "password": "pistol123"};
    return await _server.post(baseUrl, "register", payload);
  }

  @override
  Future<Either<Exception, http.Response>> postDataSuccess2() async {
    // creating a resource
    var payload = {"name": "morpheus", "job": "leader"};
    return await _server.post(baseUrl, "users", payload);
  }

  @override
  Future<Either<Exception, http.Response>> postDataFailure1() async {
    // creating a resource but passing wrong key
    var payload = {"name": "morpheus", "haha": "leader"};
    return await _server.post(baseUrl, "register", payload);
  }

  @override
  Future<Either<Exception, http.Response>> postDataFailure2() async {
    // unsuccessful login - not passing a password key
    var payload = {"email": "peter@klaven"};
    return await _server.post(baseUrl, "login", payload);
  }

  @override
  Future<Either<Exception, http.Response>> postDataFailure3() async {
    // no such endpoint exist so it will throw error
    var payload = {"name": "morpheus", "haha": "leader"};
    return await _server.post(baseUrl, "lmaoji", payload);
  }

  /// some random api update functions
  @override
  Future<Either<Exception, http.Response>> updateDataSuccess() async {
    var payload = {"name": "morpheus", "job": "leader"};
    return await _server.update(baseUrl, "users/2", payload);
  }

  @override
  Future<Either<Exception, http.Response>> updateDataFailure1() async {
    // passing wrong key value in payload
    var payload = {"name": "morpheus", "jobie": "lmao"};
    return await _server.update(baseUrl, "users/2", payload);
  }

  @override
  Future<Either<Exception, http.Response>> updateDataFailure2() async {
    // passing wrong endpoint
    var payload = {"name": "morpheus", "job": "leader"};
    return await _server.update(baseUrl, "lmao/2", payload);
  }

  /// some random api delete functions
  @override
  Future<Either<Exception, http.Response>> deleteDataSuccess() async {
    var payload = {};
    return await _server.delete(baseUrl, "users/2", payload);
  }

  @override
  Future<Either<Exception, http.Response>> deleteDataFailure() async {
    // passing wrong end point
    var payload = {};
    return await _server.delete(baseUrl, "lmao/2", payload);
  }
}
