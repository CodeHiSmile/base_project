// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_response_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_UserResponseData _$UserResponseDataFromJson(Map<String, dynamic> json) =>
    _UserResponseData(
      id: (json['id'] as num?)?.toInt(),
      ssoId: json['ssoId'] as String?,
      profileId: (json['profileId'] as num?)?.toInt(),
      username: json['username'] as String?,
      fullName: json['fullName'] as String?,
      phoneNumber: json['phoneNumber'] as String?,
      email: json['email'] as String?,
      gender: json['gender'] as String?,
      roles: (json['roles'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
    );

Map<String, dynamic> _$UserResponseDataToJson(_UserResponseData instance) =>
    <String, dynamic>{
      'id': instance.id,
      'ssoId': instance.ssoId,
      'profileId': instance.profileId,
      'username': instance.username,
      'fullName': instance.fullName,
      'phoneNumber': instance.phoneNumber,
      'email': instance.email,
      'gender': instance.gender,
      'roles': instance.roles,
    };
