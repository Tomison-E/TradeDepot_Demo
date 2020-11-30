
import 'package:tradedepot_demo/app/signIn/data/models/user.dart';
import 'package:tradedepot_demo/core/error/exceptions.dart';
import 'package:tradedepot_demo/core/services/firebase/firebase_client.dart';

abstract class ProfileRemoteDataSource {

  Future<User> getUserData(String email);

}


  class ProfileRemoteDataSourceImpl implements ProfileRemoteDataSource{
  ProfileRemoteDataSourceImpl(this._fireBaseClient);

  final FireBaseClient _fireBaseClient;
  final String collection = "users";
  final String field = "email";

  @override
  Future<User> getUserData(String email) async{
    try {
      final user = await _fireBaseClient.getWhere(collection, field, email);
      if (user == null) throw ServerException();
      return User.fromJson(user.docs.first.data());
    }
    catch(exception){
      throw exception;
    }
  }



}