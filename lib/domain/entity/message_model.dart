import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:json_annotation/json_annotation.dart';

part 'message_model.g.dart';

@JsonEnum()
enum MessageType { text, image, system }

@JsonEnum()
enum MessageStatus { sent, delivered, read }

@JsonSerializable()
class MessageModel {
  @JsonKey(includeFromJson: false, includeToJson: false)
  final String? id; // Use nullable for creation before Firestore assigns an ID
  final String senderId;
  final String receiverId;
  final String content; // Renamed from 'text' for clarity
  final MessageType type;
  final MessageStatus status;

  @TimeStampConverter()
  final DateTime createdAt;

  @TimeStampConverter()
  final DateTime? readAt;

  final List<String> deletedFor;

  MessageModel({
    this.id,
    required this.senderId,
    required this.receiverId,
    required this.content,
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

// This converter handles both nullable and non-nullable Timestamps
class TimeStampConverter implements JsonConverter<DateTime?, Timestamp?> {
  const TimeStampConverter();

  @override
  DateTime? fromJson(Timestamp? timeStamp) {
    return timeStamp?.toDate();
  }

  @override
  Timestamp? toJson(DateTime? dateTime) {
    return dateTime == null ? null : Timestamp.fromDate(dateTime);
  }
}
