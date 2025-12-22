import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../domain/entity/user_model.dart';

part 'user_payload.g.dart';

@JsonSerializable(explicitToJson: true)
class UserPayload {
  String uid;
  String name;
  String email;
  String? photoUrl;
  List<String> fcmTokens;
  @TimeStampConverter()
  DateTime? lastseen;
  @TimeStampConverter()
  DateTime? createdAt;

  UserPayload({
    required this.uid,
    required this.name,
    required this.email,
    this.photoUrl,
    this.fcmTokens = const [],
    this.lastseen,
    this.createdAt,
  });

  factory UserPayload.fromJson(Map<String, dynamic> json) =>
      _$UserPayloadFromJson(json);

  Map<String, dynamic> toJson() => _$UserPayloadToJson(this);
}
