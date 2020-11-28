/*
import 'package:flutter_riverpod/all.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:tradedepot_demo/app/signUp/data/dataSources/userRemoteDataSource.dart';
import 'package:tradedepot_demo/app/signUp/data/dataSources/user_local_data_source.dart';
import 'package:tradedepot_demo/app/signUp/data/models/user.dart';
import 'package:tradedepot_demo/app/signUp/data/repository/userRepository.dart';
import 'package:tradedepot_demo/core/connectivity/networkInfo.dart';
import 'package:tradedepot_demo/core/networkResponse/api_result.dart';


class _FakeNetworkInfo implements NetworkInfo {
  bool val  = true;

  @override
  Future<bool> get isConnected => Future.value(val);

}

class _FakeRemoteDataSource implements UserRemoteDataSource{

  User user = User(firstName: " ", lastName: " ", email: "ty@gmail.com", username: " ");
  String password = "password";


  @override
  Future<bool> signIn(String email, String password) {
    return user.email == email && this.password == password ? Future.value(true) : Future.value(false);
  }

  User get currentUser => user;

}

class _FakeLocalDataSource implements UserLocalDataSource{

  User user = User(firstName: " ", lastName: " ", email: "ty@gmail.com", username: " ");
  String password = "password";

  @override
  void cacheCurrentUser(User user) {
    this.user = user;
  }

  @override
  Future<bool> getSignedInUser(String email, String password) {
    return user.email == email && this.password == password ? Future.value(true) : Future.value(false);
  }


}

class Listener extends Mock {

  void call(User user);
}


void main() {
  group('test user repository implementation', (){
    final container = ProviderContainer(
        overrides: [
          networkInfoProvider.overrideWithProvider(Provider((ref)=> _FakeNetworkInfo())),
        ]
    );

    test('should check if device is online', () async{

      //ACT
      final result = await container.read(networkInfoProvider).isConnected;

      //ASSERT
      expect(result, true);
    });


  });

  group('when device is online', (){
    final tEmail = "ty@gmail.com";
    final fEmail = "tyy@gmail.com";
    final tPassword = "password";
    final tUser = User(firstName: "Tom", lastName: "Esan", email: "ty@ymail.com", username: "tyy");

    final container = ProviderContainer(
        overrides: [
          networkInfoProvider.overrideWithProvider(Provider((ref)=> _FakeNetworkInfo())),
          userLocalStorageProvider.overrideWithProvider(Provider((ref)=> _FakeLocalDataSource())),
          userRemoteDataProvider.overrideWithProvider(Provider((ref)=> _FakeRemoteDataSource())),
        ]
    );



    test('should return remote data when call to remote data source is successful', () async{

      //ACT
      final result = await container.read(userRepositoryProvider).signIn(tEmail, tPassword);

      //ASSERT
      expect(result, ApiResult.success(data: true));
    });

      test('should cache data locally when call to remote data source is successful', () async{

      //ACT
       await container.read(userRepositoryProvider).signIn(tEmail, tPassword);

      //ASSERT
      expect(result, false);
    });

    test('when save signed User and pass correct params', () async{
      //ACT
      container.read(userLocalStorageProvider).cacheCurrentUser(user);
      final result = await container.read(userLocalStorageProvider).getSignedInUser("ty@ymail.com", password);

      //ASSERT
      expect(result, true);
    });

    test('when save signed User and pass incorrect params', () async{
      //ACT
      container.read(userLocalStorageProvider).cacheCurrentUser(user);
      final result = await container.read(userLocalStorageProvider).getSignedInUser(tEmail, password);

      //ASSERT
      expect(result, false);
    });
  });

  group('when device is offline', (){
    final tEmail = "ty@gmail.com";
    final fEmail = "tyy@gmail.com";
    final password = " ";
    final user = User(firstName: "Tom", lastName: "Esan", email: "ty@ymail.com", username: "tyy");

    final container = ProviderContainer(
        overrides: [
          networkInfoProvider.overrideWithProvider(Provider((ref)=> _FakeNetworkInfo())),
          userLocalStorageProvider.overrideWithProvider(Provider((ref)=> _FakeLocalDataSource())),
          userRemoteDataProvider.overrideWithProvider(Provider((ref)=> _FakeRemoteDataSource())),
        ]
    );


    test('should check if device is online', () async{

      //ACT
      final result = !await container.read(networkInfoProvider).isConnected;

      //ASSERT
      expect(result, false);
    });

    test('when get signed User returns false on incorrect params', () async{
      //ACT
      final result = await container.read(userLocalStorageProvider).getSignedInUser(fEmail, password);

      //ASSERT
      expect(result, false);
    });

    test('when save signed User and pass correct params', () async{
      //ACT
      container.read(userLocalStorageProvider).cacheCurrentUser(user);
      final result = await container.read(userLocalStorageProvider).getSignedInUser("ty@ymail.com", password);

      //ASSERT
      expect(result, true);
    });

    test('when save signed User and pass incorrect params', () async{
      //ACT
      container.read(userLocalStorageProvider).cacheCurrentUser(user);
      final result = await container.read(userLocalStorageProvider).getSignedInUser(tEmail, password);

      //ASSERT
      expect(result, false);
    });
  });
}*/

import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:tradedepot_demo/app/signUp/data/dataSources/user_remote_data_source.dart';
import 'package:tradedepot_demo/app/signUp/data/dataSources/user_local_data_source.dart';
import 'package:tradedepot_demo/app/signUp/data/models/user.dart';
import 'package:tradedepot_demo/app/signUp/data/repository/user_repository_impl.dart';
import 'package:tradedepot_demo/core/connectivity/networkInfo.dart';
import 'package:tradedepot_demo/core/error/exceptions.dart';
import 'package:tradedepot_demo/core/networkExceptions/network_exceptions.dart';
import 'package:tradedepot_demo/core/networkResponse/api_result.dart';

class MockRemoteDataSource extends Mock implements UserRemoteDataSource {}
class MockLocalDataSource extends Mock implements UserLocalDataSource {}
class MockNetworkInfo extends Mock implements NetworkInfo {}

void main() {

  UserRepositoryImpl repository;
  MockRemoteDataSource mockRemoteDataSource;
  MockLocalDataSource mockLocalDataSource;
  MockNetworkInfo mockNetworkInfo;


  setUp((){
    mockNetworkInfo = MockNetworkInfo();
    mockLocalDataSource = MockLocalDataSource();
    mockRemoteDataSource = MockRemoteDataSource();
    repository = UserRepositoryImpl(networkInfo: mockNetworkInfo, userRemoteDataSource: mockRemoteDataSource, userLocalDataSource:mockLocalDataSource);
  });

  void runTestsOnline(Function body) {
    group("device is online", (){
      setUp(() {
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      });

      body();
    });
  }

  void runTestsOffline(Function body) {
    group("device is offline", (){
      setUp(() {
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => false);
      });

      body();
    });
  }

  group('getSignedIn User', () {
    final tEmail = "ty@gmail.com";
    final tPassword = "password";

    test('should check if device is online', () async {

      //arrange
      when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);

      //act
      repository.signIn(tEmail, tPassword);

      //assert
      verify(mockNetworkInfo.isConnected);

    });

    runTestsOnline(() {


      test('should return remote data when call to remote data is successful', () async {

        //arrange
        when(mockRemoteDataSource.signIn(any, any)).thenAnswer((_) async => true);

        //act
        final result = await repository.signIn(tEmail, tPassword);

        //assert
        verify(mockRemoteDataSource.signIn(tEmail, tPassword));
        expect(result, ApiResult.success(data: true));

      });

      test('should cache data locally when remote data is successful', () async {

        //arrange
        when(mockRemoteDataSource.signIn(any, any)).thenAnswer((_) async => true);

        //act
        await repository.signIn(tEmail, tPassword);
        final user = User(
            firstName: " ", lastName: " ", email: tEmail, username: "test");

        //assert
        verify(mockRemoteDataSource.signIn(tEmail, tPassword));
        verify(mockLocalDataSource.cacheCurrentUser(user));

      });

      test('should return server failure when the call to remote dataSource is unsuccessful', () async {

        //arrange
        when(mockRemoteDataSource.signIn(any, any)).thenThrow(ServerException());

        //act
        final result = await repository.signIn(tEmail, tPassword);

        //assert
        verify(mockRemoteDataSource.signIn(tEmail, tPassword));
        verifyZeroInteractions(mockLocalDataSource);
        expect(result, ApiResult.failure(error: NetworkExceptions.serverException()));

      });

    });

    runTestsOffline(() {

      test('should return locally cached data when cached data is present', () async {

        //arrange
        when(mockLocalDataSource.getSignedInUser(any, any)).thenAnswer((_) async => true);

        //act
        final result = await repository.signIn(tEmail, tPassword);

        //assert
        verifyZeroInteractions(mockRemoteDataSource);
        verify(mockLocalDataSource.getSignedInUser(tEmail, tPassword));
        expect(result, ApiResult.success(data: true));

      });

      test('should return locally cached data when cached data is not present', () async {

        //arrange
        when(mockLocalDataSource.getSignedInUser(any, any)).thenThrow(CacheException());

        //act
        final result = await repository.signIn(tEmail, tPassword);

        //assert
        verifyZeroInteractions(mockRemoteDataSource);
        verify(mockLocalDataSource.getSignedInUser(tEmail, tPassword));
        expect(result, ApiResult.failure(error: NetworkExceptions.cacheException()));

      });

    });

  });



}