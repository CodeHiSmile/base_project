// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_address_param.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserAddressParam _$UserAddressParamFromJson(Map<String, dynamic> json) =>
    UserAddressParam(
      keyword: json['keyword'] as String?,
      page: (json['page'] as num?)?.toInt(),
      size: (json['size'] as num?)?.toInt(),
    );

Map<String, dynamic> _$UserAddressParamToJson(UserAddressParam instance) =>
    <String, dynamic>{
      'keyword': ?instance.keyword,
      'page': ?instance.page,
      'size': ?instance.size,
    };
