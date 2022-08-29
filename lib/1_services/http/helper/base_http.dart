import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;
import 'package:ultimate_flutter_app/1_services/http/helper/exceptions.dart';

/// this is a base class,
/// useful to make all kinds of api calls and handling all sort of exceptions
/// it either sends back response as it is or throws different Exceptions

class Server {
  Future<Either<Exception, http.Response>> get(String baseUrl, String api) async {
    Uri url = Uri.parse(baseUrl + api);
    try {
      var response = await http.get(url).timeout(const Duration(seconds: 30));
      return _processResponse(response);
    } on SocketException {
      throw NoConnectionException("No Internet connection", url.toString());
    } on TimeoutException {
      throw ApiNotRespondingException("Took longer to respond than expected.", url.toString());
    } catch (e) {
      throw UnKnownException("Took longer to respond than expected.", url.toString());
    }
  }

  Future<Either<Exception, http.Response>> post(String baseUrl, String api, dynamic payloadObj) async {
    Uri url = Uri.parse(baseUrl + api);
    var payload = {'okay': "hehe", 'pass': "padofspf"};
    try {
      var response = await http.post(url, body: payload).timeout(const Duration(seconds: 30));
      return _processResponse(response);
    } on SocketException {
      throw NoConnectionException("No Internet connection", url.toString());
    } on TimeoutException {
      throw ApiNotRespondingException("Took longer to respond than expected.", url.toString());
    }
  }

  /// TODO : implement put/patch/update method
  // Future<Either<Exception,http.Response>> put(String baseUrl, String api, dynamic payloadObj) async {
  //   Uri url = Uri.parse(baseUrl + api);
  //   var payload = json.decode(payloadObj);
  //   try {
  //     var response = await http.put(url, body: payload).timeout(const Duration(seconds: 30));
  //     return _processResponse(response);
  //   } on SocketException {
  //     throw NoConnectionException("No Internet connection", url.toString());
  //   } on TimeoutException {
  //     throw ApiNotRespondingException("Took longer to respond than expected.", url.toString());
  //   }
  // }

  /// TODO : implement delete method
  // Future<Either<Exception,http.Response>> delete(String baseUrl, String api, dynamic payloadObj) async {
  //   Uri url = Uri.parse(baseUrl + api);
  //   var payload = json.decode(payloadObj);
  //   try {
  //     var response = await http.delete(url, body: payload).timeout(const Duration(seconds: 30));
  //     return _processResponse(response);
  //   } on SocketException {
  //     throw NoConnectionException("No Internet connection", url.toString());
  //   } on TimeoutException {
  //     throw ApiNotRespondingException("Took longer to respond than expected.", url.toString());
  //   }
  // }

  /// add responses here according to api's statuses
  dynamic _processResponse(http.Response response) {
    switch (response.statusCode) {
      case 200:
        return response;
      case 404:
        throw BadRequestException(utf8.decode(response.bodyBytes), response.request?.url.toString());
      case 401:
      case 403:
        throw UnAuthorizedException(utf8.decode(response.bodyBytes), response.request?.url.toString());
      case 500:
      default:
        throw NoConnectionException("Error code : " + response.statusCode.toString(), response.request?.url.toString());
    }
  }
}
