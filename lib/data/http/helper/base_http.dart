import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;
import 'package:ultimate_flutter_app/data/http/helper/exceptions.dart';

/// there can be lots of fetch data and post,put,delete calls in the app
/// we should not rewrite http.get, http.delete again and again and fill the urls everytime
/// a simple solution is using a base helper class to make all those http calls
/// this is a base class,
/// useful to make all kinds of api calls and handling all sort of exceptions
/// it either sends back response as it is or throws different Exceptions

class Server {
  /// it is singleton so everytime an instance of this class is create then memory will not be allocated to that object
  Server._internal();

  static final Server _instance = Server._internal();

  factory Server() => _instance;

  Future<Either<Exception, http.Response>> get(String baseUrl, String api) async {
    Uri url = Uri.parse(baseUrl + api);
    // try {
    //   var response = await http.get(url).timeout(const Duration(seconds: 30));
    //   return _processResponse(response);
    // } on SocketException {
    //   throw NoConnectionException("No Internet connection", url.toString());
    // } on TimeoutException {
    //   throw ApiNotRespondingException("Took longer to respond than expected.", url.toString());
    // } catch (e) {
    //   print("lmao here");
    //   print(e);
    //   throw UnKnownException("Took longer to respond than expected.", url.toString());
    // }

    try {
      var response = await http.get(url).timeout(const Duration(seconds: 30));
      return _processResponse(response);
    } on SocketException {
      return Left(NoConnectionException("No Internet connection", url.toString()));
    } on TimeoutException {
      return Left(ApiNotRespondingException("Took longer to respond than expected.", url.toString()));
    } on FormatException {
      return Left(FormatException("API format incorrect", url.toString()));
    } catch (e) {
      print("lmao here in get method");
      return Left(UnKnownException("Took longer to respond than expected.", url.toString()));
    }
  }

  Future<Either<Exception, http.Response>> post(String baseUrl, String api, dynamic payloadObj) async {
    Uri url = Uri.parse(baseUrl + api);

    try {
      var response = await http.post(url, body: payloadObj).timeout(const Duration(seconds: 30));
      return _processResponse(response);
    } on SocketException {
      return Left(NoConnectionException("No Internet connection", url.toString()));
    } on TimeoutException {
      return Left(ApiNotRespondingException("Took longer to respond than expected.", url.toString()));
    } catch (e) {
      print("lmao here in post method");
      return Left(UnKnownException("Took longer to respond than expected.", url.toString()));
    }
  }

  Future<Either<Exception, http.Response>> update(String baseUrl, String api, dynamic payloadObj) async {
    Uri url = Uri.parse(baseUrl + api);
    try {
      var response = await http.patch(url, body: payloadObj).timeout(const Duration(seconds: 30));
      return _processResponse(response);
    } on SocketException {
      return Left(NoConnectionException("No Internet connection", url.toString()));
    } on TimeoutException {
      return Left(ApiNotRespondingException("Took longer to respond than expected.", url.toString()));
    } catch (e) {
      print("lmao here in update method");
      return Left(UnKnownException("Took longer to respond than expected.", url.toString()));
    }
  }

  Future<Either<Exception, http.Response>> delete(String baseUrl, String api, dynamic payloadObj) async {
    Uri url = Uri.parse(baseUrl + api);
    var payload = json.decode(payloadObj);
    try {
      var response = await http.delete(url, body: payload).timeout(const Duration(seconds: 30));
      print("Hereee");
      return _processResponse(response);
    } on SocketException {
      return Left(NoConnectionException("No Internet connection", url.toString()));
    } on TimeoutException {
      return Left(ApiNotRespondingException("Took longer to respond than expected.", url.toString()));
    } catch (e) {
      print("lmao here in delete method");
      return Left(UnKnownException("Took longer to respond than expected.", url.toString()));
    }
  }

  /// add responses here according to api's statuses
  Either<Exception, http.Response> _processResponse(http.Response response) {
    print("Okay here we are");
    switch (response.statusCode) {
      case 200:
        print("yup this is it");
        return Right(response);

      /// when a resource is deleted successfully then 204 is returned
      case 204:
        print("hehe here");
        print(response.body);
        return Right(response);
      case 404:
        return Left(BadRequestException(utf8.decode(response.bodyBytes), response.request?.url.toString()));
      case 401:
      case 403:
        throw Left(UnAuthorizedException(utf8.decode(response.bodyBytes), response.request?.url.toString()));
      case 500:
      default:
        throw Left(
            UnKnownException("Error code : " + response.statusCode.toString(), response.request?.url.toString()));
    }
  }
}
