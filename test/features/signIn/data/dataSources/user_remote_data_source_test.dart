import 'package:mockito/mockito.dart';
import 'package:tradedepot_demo/app/signUp/data/dataSources/user_remote_data_source.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tradedepot_demo/core/error/exceptions.dart';
import 'package:tradedepot_demo/core/services/firebase/authentication.dart';

class MockAuthService extends Mock implements AuthenticationService{}


void main() {
  UserRemoteDataSourceImpl remoteSource;
  MockAuthService mockAuthService;


  setUp(() {
    mockAuthService = MockAuthService();
    remoteSource = UserRemoteDataSourceImpl(mockAuthService);
  });

  group("signedIn User", () {
    final tEmail = "ty@gmail.com";
    final tPassword = "password";

    test("should perform a get request to authenticate user", () async{
      //arrange
      when(mockAuthService.signIn(tEmail, tPassword)).thenAnswer((_) => Future.value(true));
      // act

       remoteSource.signIn(tEmail, tPassword);

      //assert
      verify(mockAuthService.signIn(tEmail, tPassword));

    });

    test("should return true when authentication is successful", () async{
      //arrange
      when(mockAuthService.signIn(tEmail, tPassword)).thenAnswer((_) => Future.value(true));
      // act

      final result = await remoteSource.signIn(tEmail, tPassword);

      //assert
      verify(mockAuthService.signIn(tEmail, tPassword));
      expect(result, true);

    });

    test("should return false when authentication is not successful", () async{
      //arrange
      when(mockAuthService.signIn(tEmail, tPassword)).thenAnswer((_) => Future.value(false));
      // act

      final result = await remoteSource.signIn(tEmail, tPassword);

      //assert
      verify(mockAuthService.signIn(tEmail, tPassword));
      expect(result, false);

    });

    test("should throw server exception when authentication returns null", () async{
      //arrange
      when(mockAuthService.signIn(tEmail, tPassword)).thenAnswer((_) => null);
      // act

      //assert
      verify(mockAuthService.signIn(tEmail, tPassword));
      expect(()async=> await remoteSource.signIn(tEmail, tPassword), throwsA(ServerException()));

    });

  });
}