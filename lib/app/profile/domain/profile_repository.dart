import 'package:tradedepot_demo/app/signIn/data/models/user.dart';

abstract class ProfileRepository {

  Future<User> getUser(String email);

}