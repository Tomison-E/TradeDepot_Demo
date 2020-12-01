import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';
import 'package:tradedepot_demo/app/profile/domain/useCases/get_user.dart';
import 'package:tradedepot_demo/app/signIn/data/dataSources/user_remote_data_source.dart';
import 'package:tradedepot_demo/app/signIn/data/dataSources/user_local_data_source.dart';
import 'package:tradedepot_demo/app/signIn/data/repository/user_repository_impl.dart';
import 'package:tradedepot_demo/app/signIn/domain/useCases/auth.dart';
import 'package:tradedepot_demo/app/signIn/domain/useCases/get_current_user.dart';
import 'package:tradedepot_demo/core/connectivity/networkInfo.dart';
import 'package:tradedepot_demo/core/local_storage/sharedPref.dart';
import 'package:tradedepot_demo/core/services/api/api.dart';
import 'package:tradedepot_demo/core/services/firebase/authentication.dart';

import 'package:tradedepot_demo/app/signIn/domain/user_repository.dart';
import 'package:tradedepot_demo/core/services/firebase/firebase_client.dart';

import 'app/profile/data/dataSource/profile_remote_data_source.dart';
import 'app/profile/data/repository/profile_repository_impl.dart';
import 'app/profile/domain/profile_repository.dart';

var sl = GetIt.instance;

void init(){
  /// FEATURES
  ///
  final String baseUrl = " ";
  final fireBaseAuth = FirebaseAuth.instance;
  final fireStore = FirebaseFirestore.instance;

   sl.registerSingleton(DataConnectionChecker());
   sl.registerSingleton(fireBaseAuth);
   sl.registerSingleton(fireStore);
   sl.registerSingleton(Dio());
   sl.registerSingleton(SharedPref());


   sl.registerLazySingleton<AuthenticationService>(()=>Authentication(sl<FirebaseAuth>()));
   sl.registerLazySingleton<FireBaseClient>(()=>FireBaseClient(sl<FirebaseFirestore>()));
   sl.registerLazySingleton<NetworkInfo>(()=>NetworkInfoImpl(sl<DataConnectionChecker>()));
   sl.registerLazySingleton(()=>ApiClient(sl<Dio>(), baseUrl));


  sl.registerLazySingleton<UserLocalDataSource>( ()=>UserLocalDataSourceImpl(sl<SharedPref>()));
  sl.registerLazySingleton<UserRemoteDataSource>(()=>UserRemoteDataSourceImpl(sl<AuthenticationService>()));
  sl.registerLazySingleton<ProfileRemoteDataSource>(()=>ProfileRemoteDataSourceImpl(sl<FireBaseClient>()));
   // Use Cases
  sl.registerLazySingleton<UserRepository>(()=>UserRepositoryImpl(networkInfo: sl<NetworkInfo>(), userRemoteDataSource: sl<UserRemoteDataSource>(), userLocalDataSource: sl<UserLocalDataSource>()));
  sl.registerLazySingleton<ProfileRepository>(()=>ProfileRepositoryImpl(networkInfo: sl<NetworkInfo>(), profileRemoteDataSource: sl<ProfileRemoteDataSource>()));

  sl.registerLazySingleton(()=>GetCurrentUser(sl<UserRepository>()));
  sl.registerLazySingleton((()=>Authenticate(sl<UserRepository>())));
  sl.registerLazySingleton((()=>GetUser(sl<ProfileRepository>())));
}



void initFeatures(){}