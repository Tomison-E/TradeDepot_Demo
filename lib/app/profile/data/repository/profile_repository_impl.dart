import 'package:flutter/cupertino.dart';
import 'package:tradedepot_demo/app/profile/data/dataSource/profile_remote_data_source.dart';
import 'package:tradedepot_demo/app/profile/domain/profile_repository.dart';
import 'package:tradedepot_demo/app/signIn/data/models/user.dart';
import 'package:tradedepot_demo/core/connectivity/networkInfo.dart';


class ProfileRepositoryImpl implements ProfileRepository {
  ProfileRepositoryImpl(
      {@required this.networkInfo, @required this.profileRemoteDataSource});

  final NetworkInfo networkInfo;
  final ProfileRemoteDataSource profileRemoteDataSource;

  @override
  Future<User> getUser(String email) async {
   // if (await networkInfo.isConnected) {
      final user = await profileRemoteDataSource.getUserData(email);
      return user;
    }
    //else {
    //  throw NetworkExceptions.noInternetConnection();
    //}
  //}
}