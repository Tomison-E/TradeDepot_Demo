import 'package:firebase_auth/firebase_auth.dart';




abstract class AuthenticationService {
  Future<bool> createUser(String email, String password);
  Future<bool> signIn(String email, String password);
}

class Authentication implements AuthenticationService{
 Authentication(this._authInstance,{this.url = ""});

 final _authInstance ;
 final String url;


 Future<bool> createUser(String email, String password) async {
   try {
     UserCredential userCredential = await _authInstance.createUserWithEmailAndPassword(
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
     UserCredential userCredential = await _authInstance.signInWithEmailAndPassword(
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