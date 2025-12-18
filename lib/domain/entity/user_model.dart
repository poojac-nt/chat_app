import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user_model.g.dart';

@JsonSerializable(explicitToJson: true)
class UserModel {
  final String uid;
  final String name;
  final String email;
  final String? photoUrl;
  final List<String> fcmTokens;
  @TimeStampConverter()
  final DateTime? lastseen;
  @TimeStampConverter()
  final DateTime? createdAt;

  UserModel({
    required this.uid,
    required this.name,
    required this.email,
    this.photoUrl,
    this.fcmTokens = const [],
    this.lastseen,
    this.createdAt,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);

  Map<String, dynamic> toJson() => _$UserModelToJson(this);
}

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
