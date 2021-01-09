import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_quiz_maker_app/models/userdata.dart';

class AuthService{

  FirebaseAuth _auth = FirebaseAuth.instance;

  UserData _userFromFirebaseUser(User user){
    return user != null ? UserData(uid: user.uid) : null;
  }

  Future  signInEmailandPassword(String email, String password) async{
    try{
       UserCredential userCredential = await _auth.signInWithEmailAndPassword(
          email: email, password: password
      );
       User user = userCredential.user;

       return _userFromFirebaseUser(user);

    }on FirebaseAuthException catch(e){
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
      }
    }catch (e) {
      print(e.toString());
    }
  }

  Future signUpWithEmailandPassword(String email, String password) async{
    try{
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
          email: email, password: password
      );
      User user = userCredential.user;

      return _userFromFirebaseUser(user);

    }on FirebaseAuthException catch(e){
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
    }catch(e){
      print(e.toString());
    }
  }

  Future signOut() async{
    try{
      return _auth.signOut();
    }catch(e){
      print(e.toString());
      return null;
    }
  }
}