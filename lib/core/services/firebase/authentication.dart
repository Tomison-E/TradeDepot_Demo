
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:tradedepot_demo/core/networkResponse/api_result.dart';


final authenticationProvider = Provider<AuthenticationService>((ref) => Authentication(ref.read));
final fireBaseAuthProvider = Provider((ref) => FirebaseAuth.instance);

abstract class AuthenticationService {
  Future<ApiResult<bool>> createUser(String email, String password);
  Future<ApiResult<bool>> signIn(String email, String password);
}

class Authentication implements AuthenticationService{
 Authentication(this._read,{this.url = ""});

 final Reader _read;
 final String url;


 Future<ApiResult<bool>> createUser(String email, String password) async {
   try {
     UserCredential userCredential = await _read(fireBaseAuthProvider).createUserWithEmailAndPassword(
         email: email,
         password: password
     );
     return  ApiResult.success(data: userCredential != null ? true : false);
   } on FirebaseAuthException catch (e) {
     if (e.code == 'weak-password') {
       print('The password provided is too weak.');
       return ApiResult.error(errorMsg: "The password provided is too weak.");
     } else if (e.code == 'email-already-in-use') {
       print('The account already exists for that email.');
       return ApiResult.error(errorMsg: 'The account already exists for that email.');
     }
     else{
       print('Failed with error code: ${e.code}');
       return ApiResult.error(errorMsg: 'Unable to crate account');
     }
   } catch (e) {
     print('Failed with error code: ${e.code}');
     return ApiResult.error(errorMsg: e.message);
   }
 }

 Future<ApiResult<bool>> signIn(String email, String password) async{
   try {
     UserCredential userCredential = await _read(fireBaseAuthProvider).signInWithEmailAndPassword(
         email: email,
         password: password
     );
     return ApiResult.success(data: userCredential != null ? true : false);
   } on FirebaseAuthException catch (e) {
     if (e.code == 'user-not-found') {
       print('No user found for that email.');
       return ApiResult.error(errorMsg: "The password provided is too weak.");
     } else if (e.code == 'wrong-password') {
       print('Wrong password provided for that user.');
       return ApiResult.error(errorMsg: 'Wrong password provided for that user.');
     }
     else{
       return ApiResult.error(errorMsg: 'Login Unsuccessful : Confirm Connection');
     }
   } catch (e) {
     print('Failed with error code: ${e.code} : ${e.message} ');
     return ApiResult.error(errorMsg: e.message);
   }
 }

}