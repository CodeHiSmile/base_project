import 'package:freezed_annotation/freezed_annotation.dart';
import 'dart:convert';

part 'user_response_data.freezed.dart';

part 'user_response_data.g.dart';

@freezed
abstract class UserResponseData with _$UserResponseData {
  const factory UserResponseData({
    int? id,
    String? ssoId,
    int? profileId,
    String? username,
    String? fullName,
    String? phoneNumber,
    String? email,
    String? gender,
    List<String>? roles,
  }) = _UserResponseData;

  factory UserResponseData.fromJson(Map<String, dynamic> json) =>
      _$UserResponseDataFromJson(json);
}
