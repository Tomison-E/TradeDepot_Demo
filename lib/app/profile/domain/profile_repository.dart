import 'package:tradedepot_demo/app/signIn/data/models/user.dart';
import 'package:tradedepot_demo/core/networkResponse/api_result.dart';

abstract class ProfileRepository {

  Future<ApiResult<User>> getUser(String email);

}