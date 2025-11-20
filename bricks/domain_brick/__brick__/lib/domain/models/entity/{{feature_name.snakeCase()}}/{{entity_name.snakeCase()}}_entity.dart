import 'package:freezed_annotation/freezed_annotation.dart';

part '{{entity_name.snakeCase()}}_entity.freezed.dart';

@freezed
abstract class {{entity_name.pascalCase()}}Entity with _${{entity_name.pascalCase()}}Entity {
const factory {{entity_name.pascalCase()}}Entity({
int? id,

}) = _{{entity_name.pascalCase()}}Entity;

const {{entity_name.pascalCase()}}Entity._();
}