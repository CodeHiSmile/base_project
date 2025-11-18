import 'package:json_annotation/json_annotation.dart';

part 'user_address_param.g.dart';

@JsonSerializable(
  includeIfNull: false,
  explicitToJson: true,
)
class UserAddressParam {
  final String? keyword;
  final int? page;
  final int? size;

  UserAddressParam({
    this.keyword,
    this.page,
    this.size,
  });

  factory UserAddressParam.fromJson(Map<String, dynamic> json) =>
      _$UserAddressParamFromJson(json);

  Map<String, dynamic> toJson() => _$UserAddressParamToJson(this);
}
