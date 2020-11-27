
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:tradedepot_demo/core/networkResponse/api_result.dart';


final authenticationProvider = Provider<AuthenticationService>((ref) => Authentication(ref.read));
final fireBaseAuthProvider = Provider((ref) => FirebaseAuth.instance);

abstract class AuthenticationService {
  Future<bool> createUser(String email, String password);
  Future<bool> signIn(String email, String password);
}

class Authentication implements AuthenticationService{
 Authentication(this._read,{this.url = ""});

 final Reader _read;
 final String url;


 Future<bool> createUser(String email, String password) async {
   try {
     UserCredential userCredential = await _read(fireBaseAuthProvider).createUserWithEmailAndPassword(
         email: email,
         password: password
     );
     return  userCredential != null ? true : false;
   } on FirebaseAuthException catch (exception) {
       throw exception;
   } catch (exception) {
     throw exception;
   }
 }

 Future<bool> signIn(String email, String password) async{
   try {
     UserCredential userCredential = await _read(fireBaseAuthProvider).signInWithEmailAndPassword(
         email: email,
         password: password
     );
     return userCredential != null ? true : false;
   } on FirebaseAuthException catch (exception) {
       throw exception;
    } catch (exception) {
       throw exception;
    }
 }

}