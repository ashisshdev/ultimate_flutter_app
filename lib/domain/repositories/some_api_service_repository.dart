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
  final SomeApiServiceImpl _someApiServiceImpl;
  final SharedPreferencesHelperImpl _sharedPreferencesHelperImpl;

  SomeRepositoryImpl(this._someApiServiceImpl, this._sharedPreferencesHelperImpl);
}
