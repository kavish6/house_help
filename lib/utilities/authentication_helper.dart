import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthenticationHelper {
  bool state = false;

  FirebaseAuth auth = FirebaseAuth.instance;
  bool checkStatus() {
    var currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser != null) {
      print('logged in');
      return true;
    } else {
      print('logged out');
      return false;
    }
  }

  Future registerUser(String email, String password) async {
    try {
      UserCredential userCredential = await auth.createUserWithEmailAndPassword(
          email: email, password: password);
    } catch (e) {
      print(e);
    }
  }

  Future loginUser(String email, String password) async {
    try {
      UserCredential userCredential = await auth.signInWithEmailAndPassword(
          email: email, password: password);
    } catch (e) {
      print(e);
    }
  }

  Future logOut() async {
    await auth.signOut();
  }

  Future<bool> signInWithGoogle() async {
    var x;
    GoogleSignIn _googleSignIn = GoogleSignIn();
    GoogleSignInAccount? googleSignInAccount;
    print('hello');
    try {
      googleSignInAccount = await _googleSignIn.signIn();
      GoogleSignInAuthentication? googleAuth =
          await googleSignInAccount?.authentication;
      var credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );
      await FirebaseAuth.instance.signInWithCredential(credential);
    } catch (error) {
      print(error);
    }
    if (googleSignInAccount != null) {
      return true;
    } else
      return false;
  }
}
