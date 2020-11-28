/*
import 'package:flutter_riverpod/all.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tradedepot_demo/app/signUp/data/dataSources/user_local_data_source.dart';
import 'package:tradedepot_demo/app/signUp/data/models/user.dart';

class _FakeCacheDataStorage implements CacheDataStorage{
  @override
  _FakeCacheDataStorage(){
    this.user = User(firstName: "Tom", lastName: "Esan", email: "ty@gmail.com", username: "tyy");
  }
   User user;

  Future<bool> readUser(String email, String password) {
    if(user.email == email) return Future.value(true);

    return Future.value(false);
  }

  @override
  void saveUser(User user) {
    this.user = user;
  }

}


void main() {
  group('test Local DataSource', (){
    final tEmail = "ty@gmail.com";
    final fEmail = "tyy@gmail.com";
    final password = " ";
    final user = User(firstName: "Tom", lastName: "Esan", email: "ty@ymail.com", username: "tyy");

    final container = ProviderContainer(
        overrides: [
          cacheDataStorageProvider.overrideWithProvider(Provider((ref)=> _FakeCacheDataStorage()))
        ]
    );


    test('when get signed User returns true on correct params', () async{

      //ACT
      final result = await container.read(userLocalStorageProvider).getSignedInUser(tEmail, password);

      //ASSERT
      expect(result, true);
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
