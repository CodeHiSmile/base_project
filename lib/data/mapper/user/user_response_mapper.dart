import 'package:base_project/data/models/user/user_response_data.dart';
import 'package:base_project/domain/models/entity/user/user_entity.dart';

abstract final class UserResponseMapper {
  static UserEntity mapToEntity(UserResponseData? dto) {
    return UserEntity(
      id: dto?.id ?? 0,
      profileId: dto?.profileId ?? 0,
      username: dto?.username ?? '',
      fullName: dto?.fullName ?? '',
      phoneNumber: dto?.phoneNumber ?? '',
      email: dto?.email ?? '',
      roles: dto?.roles ?? [],
    );
  }
}
