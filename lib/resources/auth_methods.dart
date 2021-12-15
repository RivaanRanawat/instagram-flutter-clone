import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthMethods {

  // to know if there is user logged in or not and then using it in FutureBuilder
  Future<User> getCurrentUser() async {
    User currentUser = FirebaseAuth.instance.currentUser!;
    print(currentUser);
    return currentUser;
  }
}