// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'conversation_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ConversationModel _$ConversationModelFromJson(Map<String, dynamic> json) =>
    ConversationModel(
      participants: (json['participants'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      participantsData: json['participantsData'] as Map<String, dynamic>,
      lastMessage: json['lastMessage'] as String?,
      lastMessageSenderId: json['lastMessageSenderId'] as String?,
      lastMessageAt: const TimeStampConverter().fromJson(
        json['lastMessageAt'] as Timestamp?,
      ),
      createdAt: const TimeStampConverter().fromJson(
        json['lastMessageAt'] as Timestamp?,
      ),
    );

Map<String, dynamic> _$ConversationModelToJson(
  ConversationModel instance,
) => <String, dynamic>{
  'participants': instance.participants,
  'participantsData': instance.participantsData,
  'lastMessage': instance.lastMessage,
  'lastMessageSenderId': instance.lastMessageSenderId,
  'lastMessageAt': const TimeStampConverter().toJson(instance.lastMessageAt),
  'createdAt': const TimeStampConverter().toJson(instance.createdAt),
};
