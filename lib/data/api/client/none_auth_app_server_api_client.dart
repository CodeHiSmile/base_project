import 'package:alice_dio/alice_dio_adapter.dart';
import 'package:data/data.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:shared/shared.dart';

@LazySingleton()
class NoneAuthAppServerApiClient extends RestApiClient {
  NoneAuthAppServerApiClient(HeaderInterceptor headerInterceptor)
    : super(
        dio: () {
          final dio = DioBuilder.createDio(
            options: BaseOptions(
              baseUrl: GetIt.instance.get<EnvironmentConfig>().getBaseUrl(),
            ),
            interceptors: [headerInterceptor],
          );
          if (GetIt.instance.get<EnvironmentConfig>().getAlice() != null) {
            final alice = GetIt.instance.get<EnvironmentConfig>().getAlice();
            final aliceDioAdapter = AliceDioAdapter();
            alice!.addAdapter(aliceDioAdapter);

            // Add adapter như interceptor của Dio
            dio.interceptors.add(aliceDioAdapter);
          }

          return dio;
        }(),
      );
}
