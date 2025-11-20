import 'package:domain/domain.dart';
import 'package:injectable/injectable.dart';

@Injectable()
class {{action_type.pascalCase()}}{{entity_name.pascalCase()}}UseCase extends
BaseFutureUseCase<
{{action_type.pascalCase()}}{{entity_name.pascalCase()}}Input,{{action_type.pascalCase()}}{{entity_name.pascalCase()}}Output> {
const {{action_type.pascalCase()}}{{entity_name.pascalCase()}}UseCase(this._repository);

final {{feature_name.pascalCase()}}Repository _repository;

  @override
  Future<{{action_type.pascalCase()}}{{entity_name.pascalCase()}}Output> buildUseCase(
{{action_type.pascalCase()}}{{entity_name.pascalCase()}}Input input,) async {

    return {{action_type.pascalCase()}}{{entity_name.pascalCase()}}Output();
  }
}

class {{action_type.pascalCase()}}{{entity_name.pascalCase()}}Input extends BaseInput {
  const {{action_type.pascalCase()}}{{entity_name.pascalCase()}}Input();
}

class {{action_type.pascalCase()}}{{entity_name.pascalCase()}}Output extends BaseOutput {}
