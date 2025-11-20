import 'package:freezed_annotation/freezed_annotation.dart';

part '{{entity_name.snakeCase()}}_response.g.dart';

part '{{entity_name.snakeCase()}}_response.freezed.dart';

@freezed
class {{entity_name.pascalCase()}}Response with _${{entity_name.pascalCase()}}Response {
const factory {{entity_name.pascalCase()}}Response({
  int? id,
}) = _{{entity_name.pascalCase()}}Response;

factory {{entity_name.pascalCase()}}Response.fromJson(Map<String, dynamic> json) =>
_${{entity_name.pascalCase()}}ResponseFromJson(json);
}
