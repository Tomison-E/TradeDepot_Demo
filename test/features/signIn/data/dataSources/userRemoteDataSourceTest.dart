/*
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/all.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tradedepot_demo/app/signUp/data/dataSources/userRemoteDataSource.dart';
import 'package:tradedepot_demo/core/services/firebase/authentication.dart';


 String tEmail = "ty@gmail.com";
 String tPassword = "qwerty";


 class _FakeAuthService implements AuthenticationService {


   Future<bool> createUser(String email, String password) async {
      return email==tEmail && password == tPassword ?  true : false;
   }


   Future<bool> signIn(String email, String password) async{
       if(email.isEmpty) throw FirebaseAuthException(message: "Invalid Email");
       return email == tEmail && password == tPassword ? true: false;
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
       expect(await container.read(userRemoteDataProvider).signIn(tEmail, tPassword), true);
     });

     test('signing value returns false', () async{
       expect(await container.read(userRemoteDataProvider).signIn(tEmail, "wrong Password"), false);
     });

     test('signing value returns exception', () async{
       expect(()async=> await container.read(userRemoteDataProvider).signIn("", "wrong Password"), throwsA(FirebaseAuthException(message: "Invalid Email")));
     });
   });
 }*/
