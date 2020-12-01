import 'package:firebase_auth/firebase_auth.dart' as Auth;
import 'package:tradedepot_demo/core/networkResponse/api_result.dart';

abstract class UserRepository {

  Future<ApiResult<bool>> signIn(String email, String password);
  Future<ApiResult<Auth.User>> getCurrentUser();

}



