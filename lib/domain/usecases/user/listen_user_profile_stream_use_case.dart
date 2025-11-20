import 'package:base_project/domain/models/entity/user/user_entity.dart';
import 'package:base_project/domain/repositories/user_repository.dart';
import 'package:domain/domain.dart';
import 'package:injectable/injectable.dart';

@injectable
final class ListenUserProfileStreamUseCase
    extends BaseStreamUseCase<ListenUserProfileStreamInput, UserEntity> {
  final UserRepository _repository;

  ListenUserProfileStreamUseCase(this._repository);

  @override
  Stream<UserEntity> buildUseCase(input) {
    return _repository.listenUserProfileStream;
  }
}

class ListenUserProfileStreamInput extends BaseInput {}
