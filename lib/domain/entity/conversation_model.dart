import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:json_annotation/json_annotation.dart';

import 'message_model.dart';

part 'conversation_model.g.dart';

@JsonSerializable()
class ConversationModel {
  @JsonKey(includeFromJson: false, includeToJson: false)
  final String? id;
  final List<String> participants;
  final Map<String, dynamic> participantsData;
  final String? lastMessage;
  final String? lastMessageSenderId;
  @TimeStampConverter()
  final DateTime? lastMessageAt;
  @TimeStampConverter()
  final DateTime? createdAt;

  ConversationModel({
    this.id,
    required this.participants,
    required this.participantsData,
    this.lastMessage,
    this.lastMessageSenderId,
    this.lastMessageAt,
    this.createdAt,
  });

  factory ConversationModel.fromJson(Map<String, dynamic> json) =>
      _$ConversationModelFromJson(json);

  Map<String, dynamic> toJson() => _$ConversationModelToJson(this);
}
