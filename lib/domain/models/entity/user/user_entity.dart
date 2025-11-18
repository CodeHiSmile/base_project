import 'package:domain/domain.dart';
import 'package:shared/shared.dart';

class UserEntity {
  final int? id;
  final int? profileId;
  final String? username;
  final String? fullName;
  final String? phoneNumber;
  final String? email;
  final String? gender;
  final List<String>? roles;

  UserEntity({
    this.id,
    this.profileId,
    this.username,
    this.fullName,
    this.phoneNumber,
    this.email,
    this.gender,
    this.roles,
  });
}
