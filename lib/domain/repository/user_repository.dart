import 'package:chat_app/core/firebase/firebase_auth_service.dart';
import 'package:chat_app/core/firebase/firestore_service.dart';
import 'package:either_dart/either.dart';
import 'package:flutter/cupertino.dart';

import '../../core/errors/failure.dart';
import '../entity/user_model.dart';

abstract class UserRepository {
  Future<Either<Failure, List<UserModel>>> getAllUsers();
  Future<Either<Failure, UserModel>> getUserById(String id);
}

class UserRepositoryImpl implements UserRepository {
  @override
  Future<Either<Failure, List<UserModel>>> getAllUsers() async {
    try {
      final users = await FirestoreService.instance.firestore
          .collection('users')
          .where("uid", isNotEqualTo: FirebaseAuthService.currentUser!.uid)
          .get();

      debugPrint("Users :${users.docs.toString()}");
      return Right(
        users.docs.map((doc) => UserModel.fromJson(doc.data())).toList(),
      );
    } catch (e) {
      return Left(Failure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, UserModel>> getUserById(String id) async {
    try {
      final response = await FirestoreService.instance.firestore
          .collection('users')
          .doc(id)
          .get();
      final user = UserModel.fromJson(response.data() as Map<String, dynamic>);
      return Right(user);
    } catch (e) {
      return Left(Failure(message: e.toString()));
    }
  }
}
