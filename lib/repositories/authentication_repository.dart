import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:google_sign_in/google_sign_in.dart';
import 'package:login_firebase/entities/user_entity.dart';
import 'package:login_firebase/models/user.dart';
import 'package:meta/meta.dart';


/// Thrown if during the sign up process if a failure occurs.
class SignUpFailure implements Exception {}

/// Thrown during the login process if a failure occurs.
class LogInWithEmailAndPasswordFailure implements Exception {}

/// Thrown during the sign in with google process if a failure occurs.
class LogInWithGoogleFailure implements Exception {}

/// Thrown during the logout process if a failure occurs.
class LogOutFailure implements Exception {}

/// {@template authentication_repository}
/// Repository which manages user authentication.
/// {@endtemplate}
class AuthenticationRepository {
  /// {@macro authentication_repository}
  AuthenticationRepository({
    firebase_auth.FirebaseAuth? firebaseAuth,
    GoogleSignIn? googleSignIn,
  })  : _firebaseAuth = firebaseAuth ?? firebase_auth.FirebaseAuth.instance,
        _googleSignIn = googleSignIn ?? GoogleSignIn.standard();
        // db = FirebaseFirestore;

  final firebase_auth.FirebaseAuth _firebaseAuth;
  final GoogleSignIn _googleSignIn;
  final userCollection = FirebaseFirestore.instance.collection('users');
  // final db;

  //существует ли пользователь в firestore
 Future<UserModel?> checkUsers(UserModel? user) async {
   UserModel? fireUser = null;
   await userCollection.get().then((value) {
     value.docs.forEach((element) {
       if (element.data()['id'] == user?.id)
         fireUser = UserModel.fromEntity(UserEntity.fromSnapshot(element));
     });
   });
   if (fireUser != null)
     return fireUser;
   else return null;
   // var tmp = await checkUsers();  tmp = User?
 }

  // @override
  // Future<void> addNewUser(User user) {
  //   return userCollection.add(user.toEntity().toDocument());
  // }
  //
  // @override
  // Future<void> deleteUser(User user) async {
  //   return userCollection.doc(user.id).delete();
  // }

  @override
  Stream<List<UserModel>> users() {
    return userCollection.snapshots().map((snapshot) {
      return snapshot.docs
          .map((doc) => UserModel.fromEntity(UserEntity.fromSnapshot(doc)))
          .toList();
    });
  }

  @override
  Future<void> updateUser(UserModel update) {
    return userCollection
        .doc(update.id)
        .update(update.toEntity().toDocument());
  }
  /// Stream of [UserModel] which will emit the current user when
  /// the authentication state changes.
  ///
  /// Emits [UserModel.empty] if the user is not authenticated.
  Stream<UserModel> get user {
    return _firebaseAuth.authStateChanges().map((firebaseUser) {
      return firebaseUser == null ? UserModel.empty : firebaseUser.toUser;
    });
  }

  /// Creates a new user with the provided [email] and [password].
  ///
  /// Throws a [SignUpFailure] if an exception occurs.
  Future<void> signUp({
    required String email,
    required String password,
  }) async {
    assert(email != null && password != null);
    try {
      await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on Exception {
      throw SignUpFailure();
    }
  }

  /// Starts the Sign In with Google Flow.
  ///
  /// Throws a [LogInWithGoogleFailure] if an exception occurs.
  // Future<void> logInWithGoogle() async {
  //   try {
  //     final googleUser = await _googleSignIn.signIn();
  //     final googleAuth = await googleUser.authentication;
  //     final credential = firebase_auth.GoogleAuthProvider.credential(
  //       accessToken: googleAuth.accessToken,
  //       idToken: googleAuth.idToken,
  //     );
  //     await _firebaseAuth.signInWithCredential(credential);
  //   } on Exception {
  //     throw LogInWithGoogleFailure();
  //   }
  // }

  /// Signs in with the provided [email] and [password].
  ///
  /// Throws a [LogInWithEmailAndPasswordFailure] if an exception occurs.
  Future<void> logInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    assert(email != null && password != null);
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on Exception {
      throw LogInWithEmailAndPasswordFailure();
    }
  }

  /// Signs out the current user which will emit
  /// [UserModel.empty] from the [user] Stream.
  ///
  /// Throws a [LogOutFailure] if an exception occurs.
  Future<void> logOut() async {
    try {
      await Future.wait([
        _firebaseAuth.signOut(),
        _googleSignIn.signOut(),
      ]);
    } on Exception {
      throw LogOutFailure();
    }
  }
}

extension on firebase_auth.User {
  UserModel get toUser {
    return UserModel(id: uid, email: email!, name: displayName, photo: photoURL);
  }
}