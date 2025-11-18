import 'package:base_project/domain/models/entity/user/user_entity.dart';
import 'package:base_project/domain/repositories/user_repository.dart';
import 'package:domain/domain.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetUserUseCase extends BaseFutureUseCase<GetUserInput, GetUserOutput> {
  const GetUserUseCase(this._repository);

  final UserRepository _repository;

  @override
  Future<GetUserOutput> buildUseCase(GetUserInput input) async {
    final output = await _repository.getUser();
    return GetUserOutput(output);
  }
}

class GetUserInput extends BaseInput {}

class GetUserOutput extends BaseOutput {
  final UserEntity? output;

  GetUserOutput(this.output);
}
