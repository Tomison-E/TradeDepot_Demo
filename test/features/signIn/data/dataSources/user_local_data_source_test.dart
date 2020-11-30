import 'package:flutter/material.dart';
import 'package:mockito/mockito.dart';
import 'package:tradedepot_demo/app/signIn/data/dataSources/user_local_data_source.dart';
import 'package:tradedepot_demo/app/signIn/data/models/user.dart';
import 'package:tradedepot_demo/core/error/exceptions.dart';
import 'package:tradedepot_demo/core/local_storage/sharedPref.dart';
import 'package:flutter_test/flutter_test.dart';

class MockSharedPref extends Mock implements SharedPref{}


void main() {
  UserLocalDataSourceImpl localSource;
  MockSharedPref mockSharedPref;


  setUp(() {
    mockSharedPref = MockSharedPref();
    localSource = UserLocalDataSourceImpl(mockSharedPref);
  });

  group("signedIn User", () {
    final tEmail = "ty@gmail.com";
    final tPassword = "password";
    Map<String,dynamic> userJson = User(firstName: " ", lastName: " ", email: tEmail, username: "AB").toJson();
    final key = "user";


    test("should get User value from SharedPreferences when there is one in the cache", () async{
      //arrange
      when(mockSharedPref.read(key)).thenReturn(userJson);
      // act

      final result = await localSource.getSignedInUser(tEmail, tPassword);

      //assert
      verify(mockSharedPref.read(key));
      expect(result, true);

    });

    test("should throw a cache exception when there is no cached value", () async{

      //arrange
      when(mockSharedPref.read(key)).thenReturn(null);
      // act

      //assert
      expect(() async =>  await localSource.getSignedInUser(tEmail, tPassword), throwsA(isInstanceOf<CacheException>()));
      verify(mockSharedPref.read(key));

    });

    test("should call SharedPreferences to cache the data", () async{
      User user = User(firstName: " ", lastName: " ", email: tEmail, username: "AB");
      // act
      localSource.cacheCurrentUser(user);

      //assert
      verify(mockSharedPref.save(key, user.toJson()));

    });
  });
}