import 'package:alice/alice.dart';
import 'package:domain/domain.dart';

class EnvironmentBase extends EnvironmentConfig {
  EnvironmentBase({
    required this.baseUrl,
    required this.clientId,
    required this.hostWebView,
    Alice? alice,
    required this.environment,
  }) {
    _alice = alice;
  }

  final String baseUrl;
  final String clientId;
  final String hostWebView;
  late String _firebaseToken = '';
  Alice? _alice;
  final Environment environment;

  static EnvironmentBase dev = EnvironmentBase(
    // Đổi server dev không cần sửa code: --dart-define=API_BASE_URL=http://<host>:<port>
    baseUrl: const String.fromEnvironment('API_BASE_URL'),
    clientId: '',
    hostWebView: "",
    environment: Environment.development,
  );

  static EnvironmentBase staging = EnvironmentBase(
    baseUrl: '',
    clientId: '',
    hostWebView: "",
    environment: Environment.staging,
  );

  static EnvironmentBase prod = EnvironmentBase(
    baseUrl: '',
    clientId: '',
    hostWebView: "",
    environment: Environment.production,
  );

  @override
  String getBaseUrl() {
    return baseUrl;
  }

  @override
  String getClientId() {
    return clientId;
  }

  @override
  String getFirebaseToken() {
    return _firebaseToken;
  }

  @override
  void setFirebaseToken(String token) {
    _firebaseToken = token;
  }

  @override
  String getHostWebView() {
    return hostWebView;
  }

  @override
  Alice? getAlice() {
    return _alice;
  }

  @override
  void setAlice(Alice? alice) {
    _alice = alice;
  }

  @override
  Environment getEnvironment() {
    return environment;
  }

  @override
  String getBaseGraphqlUrl() {
    throw UnimplementedError();
  }
}
