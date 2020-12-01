import 'package:firebase_auth/firebase_auth.dart' as Auth;
import 'package:tradedepot_demo/core/error/exceptions.dart';
import 'package:tradedepot_demo/core/services/firebase/authentication.dart';


abstract class UserRemoteDataSource {

  Future<bool> signIn(String email, String password);
  Future<Auth.User> getCurrentUser();

}

class UserRemoteDataSourceImpl implements UserRemoteDataSource{
  UserRemoteDataSourceImpl(this._authService);
  final AuthenticationService _authService;


  @override
  Future<bool> signIn(String email, String password) async{
    try {
      final signedUser = await _authService.signIn(email, password);
      if (signedUser == null) throw ServerException();
      return signedUser;
    }
    catch(exception){
      throw exception;
    }
  }

  @override
  Future<Auth.User> getCurrentUser() async{
    try {
      final user = await _authService.getCurrentUser();
      if (user == null) throw ServerException();
      return user;
    }
    catch(exception){
      throw exception;
    }
  }

}



//final userRemoteDataProvider = Provider<UserRemoteDataSource>((ref) => UserRemoteDataSourceImpl(ref.read));