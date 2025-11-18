// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'api_token_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ApiTokenData _$ApiTokenDataFromJson(Map<String, dynamic> json) =>
    _ApiTokenData(
      accessToken: json['accessToken'] as String?,
      refreshToken: json['refreshToken'] as String?,
    );

Map<String, dynamic> _$ApiTokenDataToJson(_ApiTokenData instance) =>
    <String, dynamic>{
      'accessToken': instance.accessToken,
      'refreshToken': instance.refreshToken,
    };
