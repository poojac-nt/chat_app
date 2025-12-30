import 'package:chat_app/core/firebase/firebase_auth_service.dart';
import 'package:chat_app/core/firebase/firestore_service.dart';
import 'package:chat_app/domain/entity/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../core/errors/failure.dart';
import 'package:either_dart/either.dart';

import '../../core/errors/firebase_exception.dart';

abstract class AuthRepository {
  Future<Either<Failure, String>> signUp(
    String name,
    String email,
    String password,
    String? photoUrl,
    String? fcmToken,
  );
  Future<Either<Failure, String>> signIn(String email, String password);
  Future<Either<Failure, String>> signOut();
  Future<Either<Failure, String>> resetPassword(String email);
  Stream<bool> isAuthenticated();
}

class AuthRepositoryImpl implements AuthRepository {
  @override
  Future<Either<Failure, String>> signIn(String email, String password) async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return Right("Logged In");
    } on FirebaseAuthException catch (e) {
      return Left(
        Failure(
          message: CustomFirebaseExceptions.customExceptionMessage(e.code),
        ),
      );
    } catch (e) {
      return Left(Failure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, String>> signUp(
    String name,
    String email,
    String password,
    String? photoUrl,
    String? fcmToken,
  ) async {
    try {
      // 1. Create user in Firebase Authentication
      final userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);

      final user = userCredential.user;
      if (user == null) {
        return Left(Failure(message: "User creation failed."));
      }
      final uid = user.uid;

      // 2. Create the UserModel object
      final userModel = UserModel(
        uid: uid,
        name: name,
        email: email,
        photoUrl: photoUrl,
        createdAt: DateTime.now(),
        lastseen: DateTime.now(),
        fcmTokens: fcmToken != null ? [fcmToken] : [],
      );

      // 3. Save the UserModel to Firestore
      await FirestoreService.instance.firestore
          .collection("users")
          .doc(uid)
          .set(userModel.toJson());

      return Right("Success");
    } on FirebaseAuthException catch (e) {
      return Left(
        Failure(
          message: CustomFirebaseExceptions.customExceptionMessage(e.code),
        ),
      );
    } catch (e) {
      return Left(Failure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, String>> signOut() async {
    try {
      await FirebaseAuth.instance.signOut();
      return Right("Logged Out");
    } on FirebaseAuthException catch (e) {
      return Left(
        Failure(
          message: CustomFirebaseExceptions.customExceptionMessage(e.code),
        ),
      );
    } catch (e) {
      return Left(Failure(message: e.toString()));
    }
  }

  @override
  Stream<bool> isAuthenticated() {
    return FirebaseAuthService.authStateChanges.map((user) => user != null);
  }

  @override
  Future<Either<Failure, String>> resetPassword(String email) async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
      return Right("Email sent successfully");
    } on FirebaseAuthException catch (e) {
      return Left(
        Failure(
          message: CustomFirebaseExceptions.customExceptionMessage(e.code),
        ),
      );
    } catch (e) {
      return Left(Failure(message: e.toString()));
    }
  }
}
