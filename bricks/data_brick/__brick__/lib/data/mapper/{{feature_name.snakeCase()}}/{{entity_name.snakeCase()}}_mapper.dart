import '../../../domain/domain.dart';
import '../../models/{{feature_name.snakeCase()}}/{{entity_name.snakeCase()}}_response.dart';

class {{entity_name.pascalCase()}}Mapper {
  static {{entity_name.pascalCase()}}Entity mapToEntity({{entity_name.pascalCase()}}Response dto) {
    return {{entity_name.pascalCase()}}Entity(
      id: dto.id,
      );
    }
}