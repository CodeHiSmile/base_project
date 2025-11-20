import 'package:base_ui/base_ui.dart';
import 'package:domain/domain.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part '{{name.snakeCase()}}_state.freezed.dart';

@freezed
abstract class {{name.pascalCase()}}State extends BaseBlocState with _${{name.pascalCase()}}State {
  const {{name.pascalCase()}}State._();

  const factory {{name.pascalCase()}}State({
      @Default(LoadingStatus.initial) LoadingStatus? loadStatus,
      }) = _{{name.pascalCase()}}State;
}