import 'package:mockito/mockito.dart';
import 'package:tradedepot_demo/app/signUp/data/dataSources/user_local_data_source.dart';
import 'package:tradedepot_demo/app/signUp/data/models/user.dart';
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

      final call = await localSource.getSignedInUser(tEmail, tPassword);

      //assert
      expect(()  =>  localSource.getSignedInUser(tEmail, tPassword), throwsA(CacheException()));
      verify(mockSharedPref.read(key));

    });

    test("should call SharedPreferences to cache the data", () async{
      Map<String,dynamic> json= User(firstName: " ", lastName: " ", email: tEmail, username: "AB").toJson();
      // act
       when(mockSharedPref.read(key)).thenReturn(json);
       await localSource.getSignedInUser(tEmail, tPassword);

      //assert
      verify(mockSharedPref.save(key, json));

    });
  });
}