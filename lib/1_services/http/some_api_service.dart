import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;

class ApiService{


  Future<Either<Exception,http.Response>> fetchSomeData() async {
    /// call Server.get() function here
    /// for now returning a future
  Future.delayed(const Duration(seconds: 4),(){
    return
  });
  }

}