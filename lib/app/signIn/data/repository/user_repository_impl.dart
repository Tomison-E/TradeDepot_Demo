import 'package:flutter/material.dart';
import 'package:tradedepot_demo/app/signIn/data/dataSources/user_remote_data_source.dart';
import 'package:tradedepot_demo/app/signIn/data/dataSources/user_local_data_source.dart';
import 'package:tradedepot_demo/app/signIn/data/models/user.dart';
import 'package:tradedepot_demo/app/signIn/domain/user_repository.dart';
import 'package:tradedepot_demo/core/connectivity/networkInfo.dart';
import 'package:tradedepot_demo/core/networkExceptions/network_exceptions.dart';
import 'package:tradedepot_demo/core/networkResponse/api_result.dart';
import 'package:firebase_auth/firebase_auth.dart' as Auth;

class UserRepositoryImpl implements UserRepository{
  UserRepositoryImpl({@required this.networkInfo, @required this.userRemoteDataSource, @required this.userLocalDataSource});
  final NetworkInfo networkInfo;
  final UserLocalDataSource userLocalDataSource;
  final UserRemoteDataSource userRemoteDataSource;

  @override
  Future<ApiResult<bool>> signIn(String email, String password) async {
    if (await networkInfo.isConnected) {
      try {
        final isSignedUser = await userRemoteDataSource.signIn(email, password);
        if(isSignedUser){
          final user = User(
              firstName: " ", lastName: " ", email: email, username: "test");
          userLocalDataSource.cacheCurrentUser(user);
          return ApiResult.success(data: true);
        } else {
          return ApiResult.success(data: false);
        }

      }  catch(exception){
        return ApiResult.failure(error: NetworkExceptions.getDioException(exception));
      }
    }

    else {
      try {
        final localResult = await userLocalDataSource.getSignedInUser(
            email, password);
        return ApiResult.success(data: localResult);
      } catch(exception){
        return ApiResult.failure(error: NetworkExceptions.getDioException(exception));
      }
    }
  }

  @override
  Future<ApiResult<Auth.User>> getCurrentUser() async{
    if (await networkInfo.isConnected) {
      try{
        final user = await userRemoteDataSource.getCurrentUser();
        return ApiResult.success(data: user);
      }
      catch(exception){
        return ApiResult.failure(error: NetworkExceptions.getDioException(exception));
      }
    }
    else {
      return ApiResult.failure(error: NetworkExceptions.noInternetConnection());
    }
  }

 /* @override
  Auth.User getCurrentUser() {
    return GetIt.I<Auth.FirebaseAuth>().currentUser;
  }*/




}

