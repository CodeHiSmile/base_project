import 'package:base_project/data/api/service/app_api_service.dart';
import 'package:base_project/data/mapper/user/user_response_mapper.dart';
import 'package:base_project/domain/models/entity/user/user_entity.dart';
import 'package:base_project/domain/repositories/user_repository.dart';
import 'package:injectable/injectable.dart';
import 'package:rxdart/rxdart.dart';

@LazySingleton(as: UserRepository)
class UserRepositoryImpl implements UserRepository {
  final AppApiService _appApiService;

  UserRepositoryImpl(this._appApiService);

  final BehaviorSubject<UserEntity> _profileStreamController =
      BehaviorSubject();

  @override
  Future<UserEntity?> getUser() async {
    final response = await _appApiService.getUser();

    if (response?.data != null) {
      final user = UserResponseMapper.mapToEntity(response?.data);
      _profileStreamController.add(user);
      return user;
    }

    return null;
  }

  @override
  Stream<UserEntity> get listenUserProfileStream {
    return _profileStreamController.stream;
  }
}
