import 'package:tradedepot_demo/core/networkResponse/api_result.dart';

abstract class UserRepository {

  Future<ApiResult<bool>> signIn(String email, String password);

}



