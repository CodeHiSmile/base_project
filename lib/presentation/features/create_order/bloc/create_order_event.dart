import 'package:base_ui/base_ui.dart';
import 'package:domain/domain.dart';

abstract class CreateOrderEvent extends BaseBlocEvent {
  const CreateOrderEvent();
}

class InitialCreateOrderDataEvent extends CreateOrderEvent {
  const InitialCreateOrderDataEvent();
}