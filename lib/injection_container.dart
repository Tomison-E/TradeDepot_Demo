import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';
import 'package:tradedepot_demo/app/signUp/data/dataSources/user_remote_data_source.dart';
import 'package:tradedepot_demo/app/signUp/data/dataSources/user_local_data_source.dart';
import 'package:tradedepot_demo/app/signUp/data/repository/user_repository_impl.dart';
import 'package:tradedepot_demo/app/signUp/domain/useCases/auth.dart';
import 'package:tradedepot_demo/app/signUp/domain/user_repository.dart';
import 'package:tradedepot_demo/core/connectivity/networkInfo.dart';
import 'package:tradedepot_demo/core/local_storage/sharedPref.dart';
import 'package:tradedepot_demo/core/services/api/api.dart';
import 'package:tradedepot_demo/core/services/firebase/authentication.dart';
final sl = GetIt.instance;

void init() {
  /// FEATURES

  // Use Cases
  sl.registerLazySingleton(() => Auth(sl()));



/// REPOSITORY
  sl.registerLazySingleton<UserRepository>(() => UserRepositoryImpl(networkInfo: sl(), userRemoteDataSource: sl(), userLocalDataSource: sl()));


/// DATA
  sl.registerLazySingleton<UserLocalDataSource>(() => UserLocalDataSourceImpl(sl()));
  sl.registerLazySingleton<UserRemoteDataSource>(() => UserRemoteDataSourceImpl(sl()));

  ///CORE
 sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));

 ///
  final String baseUrl = " ";
  sl.registerLazySingleton<SharedPref>(() =>SharedPref());
  sl.registerLazySingleton<AuthenticationService>(() => Authentication(sl()));
  sl.registerLazySingleton(() => FirebaseAuth.instance);
  sl.registerLazySingleton(() => DataConnectionChecker());
  sl.registerLazySingleton(() => ApiClient(sl(), baseUrl));
  sl.registerLazySingleton(() => Dio());









  ///EXTERNAL
}




void initFeatures(){

}