import 'package:chat_app/core/firebase/firebase_auth_service.dart';
import 'package:chat_app/core/firebase/firestore_service.dart';
import 'package:chat_app/domain/entity/message_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:either_dart/either.dart';

import '../../core/errors/failure.dart';

abstract class ChatRepository {
  Future<Either<Failure, void>> sendMessage(MessageModel messageModel);

  Stream<List<MessageModel>> getMessages(String conversationId);
}

class ChatRepositoryImpl implements ChatRepository {
  @override
  Future<Either<Failure, void>> sendMessage(MessageModel messageModel) async {
    try {
      final String senderId = messageModel.senderId;
      final String receiverId = messageModel.receiverId;

      List<String> users = [senderId, receiverId];
      users.sort();
      String conversationId = users.join("_");

      final conversationRef = FirestoreService.instance.firestore
          .collection('conversations')
          .doc(conversationId);
      final newMessageRef = conversationRef.collection('messages').doc();
      final batch = FirestoreService.instance.firestore.batch();

      batch.set(newMessageRef, messageModel.toJson());
      final conversationData = {
        'lastMessage': messageModel.content,
        'lastMessageAt': messageModel.createdAt,
        'lastMessageSenderId': messageModel.senderId,
        'participants': users,
      };
      batch.set(conversationRef, conversationData, SetOptions(merge: true));
      await batch.commit();
      return Right(null);
    } catch (e) {
      return Left(Failure(message: e.toString()));
    }
  }

  @override
  Stream<List<MessageModel>> getMessages(String receiverId) {
    try {
      final users = [FirebaseAuthService.currentUserId!, receiverId];
      users.sort();
      String conversationId = users.join("_");
      return FirestoreService.instance.firestore
          .collection('conversations')
          .doc(conversationId)
          .collection('messages')
          .orderBy('createdAt', descending: true)
          .snapshots()
          .map((snapshot) {
            return snapshot.docs.map((doc) {
              return MessageModel.fromJson(doc.data());
            }).toList();
          });
    } catch (e) {
      return Stream.value([]);
    }
  }
}
