import 'package:chat_app/core/firebase/firebase_auth_service.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../core/errors/failure.dart';
import 'package:either_dart/either.dart';

import '../../core/errors/firebase_exception.dart';

abstract class AuthRepository {
  Future<Either<Failure, String>> signUp(String email, String password);
  Future<Either<Failure, String>> signIn(String email, String password);
  Future<Either<Failure, String>> signOut();
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
  Future<Either<Failure, String>> signUp(String email, String password) async {
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
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
}
