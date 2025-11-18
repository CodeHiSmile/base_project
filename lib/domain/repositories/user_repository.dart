import 'package:base_project/domain/models/entity/user/user_entity.dart';
import 'package:domain/domain.dart';

abstract class UserRepository {
  Future<UserEntity?> getUser();

  Stream<UserEntity> get listenUserProfileStream;
}
