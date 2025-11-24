import 'package:base_ui/base_ui.dart';
import 'package:domain/domain.dart';

abstract class {{name.pascalCase()}}Event extends BaseBlocEvent {
  const {{name.pascalCase()}}Event();
}

class Initial{{name.pascalCase()}}DataEvent extends {{name.pascalCase()}}Event {
  const Initial{{name.pascalCase()}}DataEvent();
}