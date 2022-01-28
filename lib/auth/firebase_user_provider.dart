import 'package:firebase_auth/firebase_auth.dart';
import 'package:rxdart/rxdart.dart';

class EWalletFirebaseUser {
  EWalletFirebaseUser(this.user);
  User user;
  bool get loggedIn => user != null;
}

EWalletFirebaseUser currentUser;
bool get loggedIn => currentUser?.loggedIn ?? false;
Stream<EWalletFirebaseUser> eWalletFirebaseUserStream() => FirebaseAuth.instance
    .authStateChanges()
    .debounce((user) => user == null && !loggedIn
        ? TimerStream(true, const Duration(seconds: 1))
        : Stream.value(user))
    .map<EWalletFirebaseUser>(
        (user) => currentUser = EWalletFirebaseUser(user));
