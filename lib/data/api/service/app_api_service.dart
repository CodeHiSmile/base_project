import 'package:base_project/data/api/client/auth_app_server_api_client.dart';
import 'package:base_project/data/api/client/none_auth_app_server_api_client.dart';
import 'package:base_project/data/models/user/user_response_data.dart';
import 'package:data/data.dart';
import 'package:injectable/injectable.dart';

@LazySingleton()
class AppApiService {
  AppApiService(this._noneAuthAppServerApiClient, this._authAppServerApiClient);

  final NoneAuthAppServerApiClient _noneAuthAppServerApiClient;
  final AuthAppServerApiClient _authAppServerApiClient;

  /*Future<DataResponse<ObjectResponse>?> getDataSample() {
    return _authAppServerApiClient.request(
      method: RestMethod.get,
      path: '/iam/v1/user',
      decoder: (json) {
        return ObjectResponse.fromJson(json as Map<String, dynamic>);
      },
    );
  }

  Future<DataListResponse<ObjectResponse>?> getListData() async {
    return _authAppServerApiClient.request(
      method: RestMethod.get,
      path: '/restaurant/v1/app/survey/find?code=survey_restaurant',
      successResponseMapperType: SuccessResponseMapperType.dataJsonArray,
      decoder: (json) {
        return ObjectResponse.fromJson(json as Map<String, dynamic>);
      },
    );
  }

  Future<DataResponse<Pagination<ObjectResponse>>?> getListRestaurant({
    required dynamic body,
  }) async {
    return _authAppServerApiClient.request(
      method: RestMethod.post,
      path: '/restaurant/v2/app/restaurant/search',
      body: body.toJson(),
      decoder: (json) => Pagination<ObjectResponse>.fromJson(
        json as Map<String, dynamic>,
        (json) => ObjectResponse.fromJson(json as Map<String, dynamic>),
      ),
    );
  }*/

  Future<DataResponse<UserResponseData>?> getUser() {
    return _authAppServerApiClient.request(
      method: RestMethod.get,
      path: '/iam/v1/user',
      decoder: (json) {
        return UserResponseData.fromJson(json as Map<String, dynamic>);
      },
    );
  }
}
