// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_device_body.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserDeviceBody _$UserDeviceBodyFromJson(Map<String, dynamic> json) =>
    UserDeviceBody(
      deviceId: json['deviceId'] as String?,
      fcmToken: json['fcmToken'] as String?,
      platformType: json['platformType'] as String?,
    );

Map<String, dynamic> _$UserDeviceBodyToJson(UserDeviceBody instance) =>
    <String, dynamic>{
      'deviceId': ?instance.deviceId,
      'fcmToken': ?instance.fcmToken,
      'platformType': ?instance.platformType,
    };
