import 'package:flutter/cupertino.dart';
import 'package:tradedepot_demo/app/profile/data/dataSource/profile_remote_data_source.dart';
import 'package:tradedepot_demo/app/profile/domain/profile_repository.dart';
import 'package:tradedepot_demo/app/signIn/data/models/user.dart';
import 'package:tradedepot_demo/core/connectivity/networkInfo.dart';
import 'package:tradedepot_demo/core/networkExceptions/network_exceptions.dart';
import 'package:tradedepot_demo/core/networkResponse/api_result.dart';


class ProfileRepositoryImpl implements ProfileRepository {
  ProfileRepositoryImpl(
      {@required this.networkInfo, @required this.profileRemoteDataSource});

  final NetworkInfo networkInfo;
  final ProfileRemoteDataSource profileRemoteDataSource;

  @override
  Future<ApiResult<User>> getUser(String email) async {
    // if (await networkInfo.isConnected) {
    try {
      final user = await profileRemoteDataSource.getUserData(email);
      return ApiResult.success(data: user);
    }
    catch (exception) {
      return ApiResult.failure(
          error: NetworkExceptions.getDioException(exception));
    }
    //else {
    //  throw NetworkExceptions.noInternetConnection();
    //}
    //}
  }
}