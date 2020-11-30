import 'package:firebase_auth/firebase_auth.dart';
import 'package:tradedepot_demo/core/error/exceptions.dart';




abstract class AuthenticationService {
  Future<bool> createUser(String email, String password);
  Future<bool> signIn(String email, String password);
  Future<User> getCurrentUser();
}

class Authentication implements AuthenticationService{
 Authentication(this._authInstance);

 final _authInstance ;



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
     final userCredential = await _authInstance.signInWithEmailAndPassword(
         email: email,
         password: password
     );
     print(userCredential);
     return userCredential != null ? true : false;
   } on FirebaseAuthException {
     throw FirebaseAuthException(message: "Invalid login credentials");
   } catch (exception) {
       throw exception;
    }
 }

  @override
  Future<User> getCurrentUser() async{
    try{
      return await _authInstance.currentUser;
    }
    on FirebaseAuthException {
      throw FirebaseAuthException(message: "Unable to get current user");
    } catch (exception) {
      throw exception;
    }
  }

}