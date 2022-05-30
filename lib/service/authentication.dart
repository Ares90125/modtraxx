import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AuthenticationHelper {
  final FirebaseAuth firebaseAuth;
  //FirebaseAuth instance
  AuthenticationHelper(this.firebaseAuth);
  //Constuctor to initalize the FirebaseAuth instance
  
  final FirebaseAuth _auth = FirebaseAuth.instance;
  //Using Stream to listen to Authentication State
  Stream<User?> get authState => firebaseAuth.idTokenChanges();

  get user => _auth.currentUser;

  //SIGN UP METHOD
  Future signUp({required String email, required String password}) async {
    try {
      await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      FirebaseFirestore.instance.collection("users").doc(user.uid).set({
        'email': email,
        'uid': user.uid,
        'created_at': DateTime.now(),
        'current_streak': 1,
        'longest_streak': 1,
        'latest_log_time': DateTime.now()
      });
      return 'success';
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        return ('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        return ('The account already exists for that email.');
      }
    } catch (e) {
      return (e);
    }
  }

  //SIGN IN METHOD
  Future signIn({required String email, required String password}) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      return 'success';
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        return ('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        return ('Wrong password provided for that user.');
      }
    }
  }

  //SIGN OUT METHOD
  Future signOut() async {
    await _auth.signOut();
    return ('signout');
  }
}
