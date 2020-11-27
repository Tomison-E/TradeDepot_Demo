import 'package:flutter_riverpod/all.dart';
import 'package:tradedepot_demo/core/networkResponse/api_result.dart';
import 'package:tradedepot_demo/core/services/firebase/authentication.dart';


abstract class UserRemoteDataSource {

  Future<ApiResult<bool>> signIn(String email, String password);

}

class UserRemoteDataSourceImpl implements UserRemoteDataSource{
  UserRemoteDataSourceImpl(this._read);
  final Reader _read;


  @override
  Future<ApiResult<bool>> signIn(String email, String password) {
    final auth = _read(authenticationProvider);
    return auth.signIn(email, password);
  }

}



final userRemoteDataProvider = Provider((ref) => UserRemoteDataSourceImpl(ref.read));