import 'package:tradedepot_demo/core/error/exceptions.dart';
import 'package:tradedepot_demo/core/services/firebase/authentication.dart';


abstract class UserRemoteDataSource {

  Future<bool> signIn(String email, String password);

}

class UserRemoteDataSourceImpl implements UserRemoteDataSource{
  UserRemoteDataSourceImpl(this._authService);
  final AuthenticationService _authService;


  @override
  Future<bool> signIn(String email, String password) {
    final signedUser = _authService.signIn(email, password);
    if(signedUser == null) throw ServerException();
    return signedUser ;
  }

}



//final userRemoteDataProvider = Provider<UserRemoteDataSource>((ref) => UserRemoteDataSourceImpl(ref.read));