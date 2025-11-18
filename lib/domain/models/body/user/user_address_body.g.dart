// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_address_body.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserAddressBody _$UserAddressBodyFromJson(Map<String, dynamic> json) =>
    UserAddressBody(
      id: (json['id'] as num?)?.toInt(),
      fullName: json['fullName'] as String?,
      phoneNumber: json['phoneNumber'] as String?,
      latitude: (json['latitude'] as num?)?.toDouble(),
      longitude: (json['longitude'] as num?)?.toDouble(),
      fullAddress: json['fullAddress'] as String?,
      addressLine: json['addressLine'] as String?,
      gate: json['gate'] as String?,
      noteAddress: json['noteAddress'] as String?,
      type: json['type'] as String?,
    );

Map<String, dynamic> _$UserAddressBodyToJson(UserAddressBody instance) =>
    <String, dynamic>{
      'id': ?instance.id,
      'fullName': ?instance.fullName,
      'phoneNumber': ?instance.phoneNumber,
      'latitude': ?instance.latitude,
      'longitude': ?instance.longitude,
      'fullAddress': ?instance.fullAddress,
      'addressLine': ?instance.addressLine,
      'gate': ?instance.gate,
      'noteAddress': ?instance.noteAddress,
      'type': ?instance.type,
    };
