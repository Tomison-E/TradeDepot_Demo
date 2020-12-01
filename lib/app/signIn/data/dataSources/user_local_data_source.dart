import 'package:tradedepot_demo/app/signIn/data/models/user.dart';
import 'package:tradedepot_demo/core/error/exceptions.dart';
import 'package:tradedepot_demo/core/local_storage/sharedPref.dart';

abstract class UserLocalDataSource{

  Future<bool> getSignedInUser(String email, String password);

  void cacheCurrentUser(User user);

}

/*abstract class CacheDataStorage{

  Future<bool> readUser(String email, String password);

  void saveUser(User user);

}

class CacheDataStorageImpl implements CacheDataStorage{
  @override
  Future<bool> readUser(String email, String password) async{
    final userJson = await SharedPref.read("user") ?? User(firstName: "", lastName: "", email: "XXXXXXX", username: "");
    User user = User.fromJson(userJson);
    if(user.email == email) {
      return true;
    }
    else {
      throw CacheException();
    }
  }

  @override
  void saveUser(User user) {
    final userJson = user.toJson();
    SharedPref.save("user", userJson);
  }

}

final cacheDataStorageProvider = Provider<CacheDataStorage>((ref) => CacheDataStorageImpl());
final userLocalStorageProvider = Provider<UserLocalDataSource>((ref) => UserLocalDataSourceImpl(ref.read));*/

class UserLocalDataSourceImpl implements UserLocalDataSource{
  UserLocalDataSourceImpl(this._pref);

  final SharedPref _pref;

  @override
    void cacheCurrentUser(User user) {
    final userJson = user.toJson();
    _pref.save("user", userJson);
  }

  @override
  Future<bool> getSignedInUser(String email, String password) async{
      final userJson = _pref.read("user");
      if(userJson != null) {
        if (User
            .fromJson(userJson)
            .email == email) {
          return true;
        }
        else {
          return false;
        }
      }
      else {
        throw CacheException();}
  }


}
