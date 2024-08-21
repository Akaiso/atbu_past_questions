import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  Future<String> signUpUSers(String fullName, String email, String phone,
      String faculty, String password, String confirmpassword) async {
    String res = 'something went wrong ';

    try {
      if (fullName.isNotEmpty &&
          email.isNotEmpty &&
          phone.isNotEmpty &&
          faculty.isNotEmpty &&
          password.isNotEmpty &&
          confirmpassword.isNotEmpty) {
        // create user
        UserCredential cred = await _auth.createUserWithEmailAndPassword(
            email: email, password: password);
        // save user to firestore database
        await _firestore.collection('users').doc(cred.user!.uid).set({
          'fullName': fullName,
          'email': email,
          'phone': phone,
          'faculty': faculty
        });
        res = 'Success';
      } else {
        res = 'Please field must not be empty';
      }
    } catch (e) {}
    return res;
  }

  loginUser(String email, String password) async {
    String res = 'Something went Wrong';
    try {
      if (email.isNotEmpty && password.isNotEmpty) {
        await _auth.signInWithEmailAndPassword(
            email: email, password: password);
        res = 'success';
      } else {
        res = 'Please fields must not be empty';
      }
    } catch (e) {
      res = e.toString();
    }
    return res;
  }
}
