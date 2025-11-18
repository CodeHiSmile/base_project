import 'package:json_annotation/json_annotation.dart';

part 'user_address_body.g.dart';

@JsonSerializable(
  includeIfNull: false,
  explicitToJson: true,
)
class UserAddressBody {
  int? id;
  String? fullName;
  String? phoneNumber;
  double? latitude;
  double? longitude;
  String? fullAddress;
  String? addressLine;
  String? gate;
  String? noteAddress;
  String? type;

  UserAddressBody({
    this.id,
    this.fullName,
    this.phoneNumber,
    this.latitude,
    this.longitude,
    this.fullAddress,
    this.addressLine,
    this.gate,
    this.noteAddress,
    this.type,
  });

  factory UserAddressBody.fromJson(Map<String, dynamic> json) =>
      _$UserAddressBodyFromJson(json);

  Map<String, dynamic> toJson() => _$UserAddressBodyToJson(this);
}
