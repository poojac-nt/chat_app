import 'package:chat_app/core/firebase/firestore_service.dart';
import 'package:either_dart/either.dart';
import 'package:flutter/cupertino.dart';

import '../../core/errors/failure.dart';
import '../entity/user_model.dart';

abstract class UserRepository {
  Future<Either<Failure, List<UserModel>>> getAllUsers();
}

class UserRepositoryImpl implements UserRepository {
  @override
  Future<Either<Failure, List<UserModel>>> getAllUsers() async {
    try {
      final users = await FirestoreService.instance.firestore
          .collection('users')
          .get();

      debugPrint("Users :${users.docs.toString()}");
      return Right(
        users.docs.map((doc) => UserModel.fromJson(doc.data())).toList(),
      );
    } catch (e) {
      return Left(Failure(message: e.toString()));
    }
  }
}
