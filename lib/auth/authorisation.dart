import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../database/databaseMethod.dart';
import '../database/userLocalData.dart';

class AuthMethods {
  final FirebaseAuth auth = FirebaseAuth.instance;

  getCurrentUser() async {
    return auth.currentUser;
  }

  signInWithGoogle(BuildContext context) async {
    try {
      final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
      final GoogleSignIn _googleSignIn = GoogleSignIn();

      final GoogleSignInAccount googleSignInAccount =
          await _googleSignIn.signIn();

      final GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
          idToken: googleSignInAuthentication.idToken,
          accessToken: googleSignInAuthentication.accessToken);

      UserCredential result =
          await _firebaseAuth.signInWithCredential(credential);

      final exist =
          await DatabaseMethods().getUserInfofromFirebase(result.user.uid);
      if (!exist.exists) {
        DatabaseMethods().addUserInfoToFirebase(
          userId: result.user.uid,
          name: result.user.displayName ?? '',
          phoneNumber: result.user.phoneNumber ?? '',
          email: result.user.email ?? '',
          imageURL: result.user.photoURL ?? '',
        );
      } else {
        DatabaseMethods().updateUserDoc(uid: result.user.uid, userMap: {
          'displayName': result.user.displayName,
          'imageURL': result.user.photoURL,
        });
      }

      if (result != null) {
        User user = result.user;
        DatabaseMethods().storeUserInfoInLocalStorageFromGoogle(user);
        return user;
      }
    } catch (e) {
      Fluttertoast.showToast(msg: e.toString(), backgroundColor: Colors.red);
      return null;
    }
    return null;
  }

  Future<User> signupWithEmailAndPassword({
    @required String name,
    @required String email,
    @required String password,
    @required String phoneNumber,
  }) async {
    try {
      UserCredential result = await auth
          .createUserWithEmailAndPassword(
        email: email.trim(),
        password: password.trim(),
      )
          .catchError((Object obj) {
        Fluttertoast.showToast(
          msg: obj.toString(),
          backgroundColor: Colors.red,
          timeInSecForIosWeb: 5,
        );
        return null;
      });
      final User user = result.user;
      assert(user != null);
      assert(await user.getIdToken() != null);
      if (user != null) {
        await DatabaseMethods().addUserInfoToFirebase(
          userId: user.uid,
          name: name.trim(),
          email: email.toLowerCase(),
          phoneNumber: phoneNumber,
        );
      }
      return user;
    } catch (signUpError) {
      Fluttertoast.showToast(
        msg: signUpError.code,
        backgroundColor: Colors.red,
        timeInSecForIosWeb: 5,
      );
      return null;
    }
  }

  Future<User> loginWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential result = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password)
          .catchError((obj) {
        Fluttertoast.showToast(
          msg: obj.toString(),
          backgroundColor: Colors.red,
        );
        return null;
      });
      if (result != null) {
        final User user = result.user;
        final User currentUser = FirebaseAuth.instance.currentUser;
        assert(user.uid == currentUser.uid);
        DatabaseMethods().storeUserInfoInLocalStorageFromFirebase(user.uid);
        return user;
      }
    } catch (signUpError) {
      Fluttertoast.showToast(
        msg: signUpError.code,
        backgroundColor: Colors.red,
        timeInSecForIosWeb: 3,
      );
      return null;
    }
    return null;
  }

  Future signOut() async {
    UserLocalData.signout();
    await auth.signOut();
  }
}
