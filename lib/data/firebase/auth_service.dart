import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:texno_bozor/data/models/universal_data.dart';

class AuthService {
  Future<UniversalReponse> signUpUser({
    required String email,
    required String password,
  }) async {
    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return UniversalReponse(data: userCredential);
    } on FirebaseAuthException catch (e) {
      return UniversalReponse(error: e.code);
    } catch (error) {
      return UniversalReponse(error: error.toString());
    }
  }

  Future<UniversalReponse> loginUser({
    required String email,
    required String password,
  }) async {
    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return UniversalReponse(data: userCredential);
    } on FirebaseAuthException catch (e) {
      return UniversalReponse(error: e.code);
    } catch (error) {
      return UniversalReponse(error: error.toString());
    }
  }

  Future<UniversalReponse> logOutUser() async {
    try {
      await FirebaseAuth.instance.signOut();
      return UniversalReponse(data: "User Logged Out");
    } on FirebaseAuthException catch (e) {
      return UniversalReponse(error: e.code);
    } catch (error) {
      return UniversalReponse(error: error.toString());
    }
  }

  Future<UniversalReponse> signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );
    try {
      UserCredential userCredential = await FirebaseAuth.instance.signInWithCredential(credential);
      return UniversalReponse(data: userCredential);
    } on FirebaseAuthException catch (e) {
      return UniversalReponse(error: e.code);
    } catch (error) {
      return UniversalReponse(error: error.toString());
    }
  }
}
