// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_payload.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserPayload _$UserPayloadFromJson(Map<String, dynamic> json) => UserPayload(
  uid: json['uid'] as String,
  name: json['name'] as String,
  email: json['email'] as String,
  photoUrl: json['photoUrl'] as String?,
  fcmTokens:
      (json['fcmTokens'] as List<dynamic>?)?.map((e) => e as String).toList() ??
      const [],
  lastseen: const TimeStampConverter().fromJson(json['lastseen'] as Timestamp?),
  createdAt: const TimeStampConverter().fromJson(
    json['createdAt'] as Timestamp?,
  ),
);

Map<String, dynamic> _$UserPayloadToJson(UserPayload instance) =>
    <String, dynamic>{
      'uid': instance.uid,
      'name': instance.name,
      'email': instance.email,
      'photoUrl': instance.photoUrl,
      'fcmTokens': instance.fcmTokens,
      'lastseen': const TimeStampConverter().toJson(instance.lastseen),
      'createdAt': const TimeStampConverter().toJson(instance.createdAt),
    };
