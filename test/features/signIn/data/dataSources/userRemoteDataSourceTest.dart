import 'package:flutter_riverpod/all.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tradedepot_demo/app/signUp/data/dataSources/userRemoteDataSource.dart';
import 'package:tradedepot_demo/core/networkResponse/api_result.dart';
import 'package:tradedepot_demo/core/services/firebase/authentication.dart';


 String tEmail = "ty@gmail.com";
 String tPassword = "qwerty";


 class _FakeAuthService implements AuthenticationService {


   Future<ApiResult<bool>> createUser(String email, String password) async {
      return email==tEmail && password == tPassword ? ApiResult.success(data: true) : ApiResult.success(data: false);
   }


   Future<ApiResult<bool>> signIn(String email, String password) async{
     try {
       return email == tEmail && password == tPassword ? ApiResult.success(
           data: true) : ApiResult.success(data: false);
     }
     catch(e){
       return ApiResult.error(errorMsg: "failed");
     }
   }
 }

 void main() {
   group('test Remote DataSource', (){
     final container = ProviderContainer(
       overrides: [
         authenticationProvider.overrideWithProvider(Provider((ref)=> _FakeAuthService()))
       ]
     );



     test('signing value returns true ', () async{
       expect(await container.read(userRemoteDataProvider).signIn(tEmail, tPassword), ApiResult.success(data: true));
     });

     test('signing value returns false', () async{
       expect(await container.read(userRemoteDataProvider).signIn(tEmail, "wrong Password"), ApiResult.success(data: false));
     });
   });
 }