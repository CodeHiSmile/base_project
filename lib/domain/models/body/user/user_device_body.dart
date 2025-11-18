import 'package:json_annotation/json_annotation.dart';

part 'user_device_body.g.dart';

@JsonSerializable(
  includeIfNull: false,
  explicitToJson: true,
)
class UserDeviceBody {
  String? deviceId;
  String? fcmToken;
  String? platformType;

  UserDeviceBody({
    this.deviceId,
    this.fcmToken,
    this.platformType,
  });

  factory UserDeviceBody.fromJson(Map<String, dynamic> json) =>
      _$UserDeviceBodyFromJson(json);

  Map<String, dynamic> toJson() => _$UserDeviceBodyToJson(this);
}
