import 'package:data/data.dart';
import 'package:domain/domain.dart';

import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';

@LazySingleton()
class RefreshTokenApiClient extends RestApiClient {
  RefreshTokenApiClient(
    HeaderInterceptor headerInterceptor,
    AccessTokenInterceptor accessTokenInterceptor,
  ) : super(
        dio: DioBuilder.createDio(
          options: BaseOptions(
            baseUrl: GetIt.instance.get<EnvironmentConfig>().getBaseUrl(),
          ),
          interceptors: [
          ],
        ),
      );
}
