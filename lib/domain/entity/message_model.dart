import 'package:json_annotation/json_annotation.dart';

part 'message_model.g.dart';

enum MessageType { text, image, system }

enum MessageStatus { sent, delivered, read }

@JsonSerializable()
class MessageModel {
  final String id;
  final String senderId;
  final String text;
  final MessageType type;
  final MessageStatus status;
  final DateTime createdAt;
  final DateTime? readAt;
  final List<String> deletedFor;

  MessageModel({
    required this.id,
    required this.senderId,
    required this.text,
    this.type = MessageType.text,
    this.status = MessageStatus.sent,
    required this.createdAt,
    this.readAt,
    this.deletedFor = const [],
  });

  factory MessageModel.fromJson(Map<String, dynamic> json) =>
      _$MessageModelFromJson(json);

  Map<String, dynamic> toJson() => _$MessageModelToJson(this);
}
