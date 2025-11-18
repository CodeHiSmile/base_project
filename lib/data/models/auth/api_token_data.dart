import 'package:freezed_annotation/freezed_annotation.dart';

part 'api_token_data.freezed.dart';

part 'api_token_data.g.dart';

@freezed
abstract class ApiTokenData with _$ApiTokenData {
  const factory ApiTokenData({String? accessToken, String? refreshToken}) =
      _ApiTokenData;

  factory ApiTokenData.fromJson(Map<String, dynamic> json) =>
      _$ApiTokenDataFromJson(json);
}
