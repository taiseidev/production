import 'package:firebase_auth/firebase_auth.dart';

class FirebaseAuthUtills {
  static final uid = FirebaseAuth.instance.currentUser!.uid;
}
