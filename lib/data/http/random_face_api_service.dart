import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;

import 'helper/base_http.dart';

abstract class RandomFaceApiService {
  Future<Either<Exception, http.Response>> fetchRandomFace();
  Future<Either<Exception, http.Response>> fetchRandomMaleFace();
  Future<Either<Exception, http.Response>> fetchRandomFemaleFace();
  Future<Either<Exception, http.Response>> fetchRandomYoungFella();
  Future<Either<Exception, http.Response>> fetchRandomOldFella();
}

class RandomFaceApiServiceImpl implements RandomFaceApiService {
  @override
  Future<Either<Exception, http.Response>> fetchRandomFace() async {
    String baseUrl = "https://fakeface.rest/face/json";
    String api = '?gender=female&minimum_age=35';
    var response = await Server().get(baseUrl, api);
    return response;
  }

  @override
  Future<Either<Exception, http.Response>> fetchRandomFemaleFace() {
    // TODO: implement fetchRandomFemaleFace
    throw UnimplementedError();
  }

  @override
  Future<Either<Exception, http.Response>> fetchRandomMaleFace() {
    // TODO: implement fetchRandomMaleFace
    throw UnimplementedError();
  }

  @override
  Future<Either<Exception, http.Response>> fetchRandomOldFella() {
    // TODO: implement fetchRandomOldFella
    throw UnimplementedError();
  }

  @override
  Future<Either<Exception, http.Response>> fetchRandomYoungFella() {
    // TODO: implement fetchRandomYoungFella
    throw UnimplementedError();
  }
}
