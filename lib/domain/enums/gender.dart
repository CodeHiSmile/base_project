import 'package:shared/shared.dart';

enum Gender {
  male(ServerRequestResponseConstants.male),
  female(ServerRequestResponseConstants.female),
  other(ServerRequestResponseConstants.other),
  unknown(ServerRequestResponseConstants.unknown);

  const Gender(this.serverValue);

  final int serverValue;

  static const defaultValue = unknown;
}
