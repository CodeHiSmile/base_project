import 'package:alice_dio/alice_dio_adapter.dart';
import 'package:base_project/data/api/interceptors/refresh_token_interceptor.dart';
import 'package:data/data.dart';

import 'package:dio/dio.dart';
import 'package:domain/domain.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';

@LazySingleton()
class AuthAppServerApiClient extends RestApiClient {
  AuthAppServerApiClient(
    HeaderInterceptor headerInterceptor,
    AccessTokenInterceptor accessTokenInterceptor,
    RefreshTokenInterceptor refreshTokenInterceptor,
  ) : super(
        dio: () {
          final dio = DioBuilder.createDio(
            options: BaseOptions(
              baseUrl: GetIt.instance.get<EnvironmentConfig>().getBaseUrl(),
            ),
            interceptors: [
              headerInterceptor,
              accessTokenInterceptor,
              refreshTokenInterceptor,
            ],
          );

          if (GetIt.instance.get<EnvironmentConfig>().getAlice() != null) {
            final alice = GetIt.instance.get<EnvironmentConfig>().getAlice();
            final aliceDioAdapter = AliceDioAdapter();
            alice!.addAdapter(aliceDioAdapter); //kết nối adapter với Alice (đăng ký để Alice hiển thị),

            // Add adapter như interceptor của Dio
            dio.interceptors.add(aliceDioAdapter); // kết nối adapter với client (Dio) để adapter có dữ liệu.
          }

          return dio;
        }(),
      );
}
