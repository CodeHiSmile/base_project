import 'package:base_project/data/api/client/refresh_token_api_client.dart';
import 'package:base_project/data/models/auth/api_token_data.dart';
import 'package:data/data.dart';
import 'package:shared/shared.dart';
import 'package:domain/domain.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

@LazySingleton()
class RefreshTokenApiService {
  RefreshTokenApiService(this._refreshTokenApiClient, this._environmentConfig);

  final RefreshTokenApiClient _refreshTokenApiClient;
  final EnvironmentConfig _environmentConfig;

  Future<ApiTokenData?> refreshToken(String refreshToken) async {
    try {
      final response = await _refreshTokenApiClient
          .request<ApiTokenData, ApiTokenData>(
            method: RestMethod.post,
            path: '/refresh_token',
            body: {
              'grant_type': 'refresh_token',
              'refresh_token': refreshToken,
            },
            options: Options(contentType: 'application/x-www-form-urlencoded'),
            successResponseMapperType: SuccessResponseMapperType.jsonObject,
            decoder: (json) {
              return ApiTokenData.fromJson(json as Map<String, dynamic>);
            },
          );

      return response;
    } catch (e) {
      if (e is RemoteException &&
          (e.kind == RemoteExceptionKind.serverDefined ||
              e.kind == RemoteExceptionKind.serverUndefined)) {
        throw const RemoteException(
          kind: RemoteExceptionKind.refreshTokenFailed,
        );
      }

      rethrow;
    }
  }
}
