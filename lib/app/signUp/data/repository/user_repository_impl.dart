import 'package:flutter/material.dart';
import 'package:tradedepot_demo/app/signUp/data/dataSources/user_remote_data_source.dart';
import 'package:tradedepot_demo/app/signUp/data/dataSources/user_local_data_source.dart';
import 'package:tradedepot_demo/app/signUp/data/models/user.dart';
import 'package:tradedepot_demo/app/signUp/domain/user_repository.dart';
import 'package:tradedepot_demo/core/connectivity/networkInfo.dart';
import 'package:tradedepot_demo/core/error/exceptions.dart';
import 'package:tradedepot_demo/core/networkExceptions/network_exceptions.dart';
import 'package:tradedepot_demo/core/networkResponse/api_result.dart';

class UserRepositoryImpl implements UserRepository{
  UserRepositoryImpl({@required this.networkInfo, @required this.userRemoteDataSource, @required this.userLocalDataSource});
  final NetworkInfo networkInfo;
  final UserLocalDataSource userLocalDataSource;
  final UserRemoteDataSource userRemoteDataSource;

  @override
  Future<ApiResult<bool>> signIn(String email, String password) async {
    if (await networkInfo.isConnected) {
      try {
        userRemoteDataSource.signIn(email, password);
        final user = User(
            firstName: " ", lastName: " ", email: email, username: "test");
        userLocalDataSource.cacheCurrentUser(user);
        return Future.value(ApiResult.success(data: true));
      } on ServerException {
        return ApiResult.failure(error: NetworkExceptions.serverException());
      }
    }

    else {
      try {
        final localResult = await userLocalDataSource.getSignedInUser(
            email, password);
        return ApiResult.success(data: localResult);
      } on  CacheException {
        return ApiResult.failure(error: NetworkExceptions.cacheException());
      }
    }
  }


}

