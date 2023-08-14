
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'dart:async';

import 'package:flutter_login_facebook/flutter_login_facebook.dart';
class FirebaseService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
 // String _message = 'Log in/out by pressing the buttons below.';
  static final FacebookLogin facebookSignIn = new FacebookLogin();
final storage=new FlutterSecureStorage();

  Future<String> signInwithGoogle() async {
    try {
      final GoogleSignInAccount googleSignInAccount =
      await _googleSignIn.signIn();
      final GoogleSignInAuthentication googleSignInAuthentication =
      await googleSignInAccount.authentication;
      final AuthCredential credential = GoogleAuthProvider.getCredential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,

      );

      await _auth.signInWithCredential(credential);
      FirebaseUser currentUser = await _auth.currentUser();
      String uid = currentUser.uid;
      final ref = FirebaseDatabase.instance.reference().child('Users');
      ref.child(uid).update({
        'Email': currentUser.email,
        'id': uid,
        'Address': 'لايوجد',
        'phone': 'لايوجد',
        'Name': currentUser.displayName,
        'imgprofile':currentUser.photoUrl
      });
      await storage.write(key: 'uid', value:uid);
    } catch (e) {
      print(e.message);
      throw e;
    }
  }

  Future signInFacebook() async {
    try {
      final facebookLogin = FacebookLogin();

      // bool isLoggedIn = await facebookLogin.isLoggedIn;

      final FacebookLoginResult result = await facebookLogin.logIn(
        permissions: [
          FacebookPermission.publicProfile,
          FacebookPermission.email,
        ],
      );

      switch (result.status) {
        case FacebookLoginStatus.success:

          String token = result.accessToken.token;

          final AuthCredential credential =
          FacebookAuthProvider.getCredential(accessToken: token);

         AuthResult ff= await _auth.signInWithCredential(credential);
         print(ff.user.uid);
          FirebaseUser currentUser = await _auth.currentUser();
          String uid = currentUser.uid;
          print('kkkkkkkkkkkkk ${currentUser.uid}');
          final ref = FirebaseDatabase.instance.reference().child('Users');
          ref.child(uid).update({
            'Email': currentUser.email,
            'id': uid,
            'Address': 'لايوجد',
            'phone': 'لايوجد',
            'Name': currentUser.displayName,
            'imgprofile':currentUser.photoUrl,
          });
          await storage.write(key: 'uid', value: uid);
          break;
        case FacebookLoginStatus.cancel:
          break;
        case FacebookLoginStatus.error:
          print(result.error);
          break;
      }

      return true;
    } catch (error) {
      return false;
    }
  }



  /* Future<Resource> signInWithFacebook() async {
    //final FacebookLoginResult facebookLoginResult = await facebookSignIn.logIn();
      try{
        final FacebookLoginResult facebookLoginResult = await facebookSignIn.logIn( permissions: [
          FacebookPermission.publicProfile,
          FacebookPermission.email,
        ],);
        switch(facebookLoginResult.status){
          case FacebookLoginStatus.success:
            FacebookAccessToken facebookAccessToken = facebookLoginResult.accessToken;
            AuthCredential authCredential = FacebookAuthProvider.getCredential(accessToken: facebookAccessToken.token);
            await firebaseAuth.signInWithCredential(authCredential);

            FirebaseUser currentUser = await firebaseAuth.currentUser();
            String uid = currentUser.uid;
            print('kkkkkkkkkkkkk ${currentUser.uid}');
            final ref = FirebaseDatabase.instance.reference().child('Users');
            ref.child(uid).update({
              'Email': currentUser.email,
              'id': uid,
              'Address': 'لايوجد',
              'Phone': 'لايوجد',
              'Name': currentUser.displayName,
              'imgprofile':currentUser.photoUrl,
            });
            await storage.write(key: 'uid', value: uid);
            break;
          case FacebookLoginStatus.cancel:
            break;
          case FacebookLoginStatus.error:
            print(FacebookLoginStatus.error);
            break;
        }
      }catch(e){
        print(e);
      }



  }*/


  Future<void> signOutFromGoogle() async {
    await _googleSignIn.signOut();
    await _auth.signOut();
  }

}
class Resource{

  final Status status;
  Resource({ this.status});
}
enum Status {
  Success,
  Error,
  Cancelled
}