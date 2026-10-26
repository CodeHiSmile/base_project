import 'dart:io';

import 'package:data/data.dart';
import 'package:dio/dio.dart';
import 'package:shared/shared.dart';

mixin MultipartUploadApiClientMixin on RestApiClient {
  /// Upload request with multipart form data.
  Future<DataResponse<T>?> uploadRequest<T>({
    required String path,
    required Map<String, dynamic> formData,
    required T Function(Object? json) decoder,
    SuccessResponseMapperType? successResponseMapperType,
  }) async {
    try {
      final multipartFormData = await _buildMultipartFormData(formData);

      final response = await dio.post(
        path,
        data: FormData.fromMap(multipartFormData),
        options: Options(contentType: 'multipart/form-data'),
      );

      if (response.data != null && response.data is Map<String, dynamic>) {
        final responseMap = response.data as Map<String, dynamic>;
        final data = responseMap['data'];
        return DataResponse<T>(data: decoder(data));
      }
      return null;
    } on DioException catch (e) {
      throw RemoteException(
        kind: RemoteExceptionKind.serverUndefined,
        httpErrorCode: e.response?.statusCode ?? 500,
        serverError: ServerError(generalMessage: e.message ?? 'Upload failed'),
      );
    }
  }

  /// Upload request returning DataListResponse.
  Future<DataListResponse<T>?> uploadRequestList<T>({
    required String path,
    required Map<String, dynamic> formData,
    required T Function(Object? json) decoder,
  }) async {
    try {
      final multipartFormData = await _buildMultipartFormData(formData);

      final response = await dio.post(
        path,
        data: FormData.fromMap(multipartFormData),
        options: Options(contentType: 'multipart/form-data'),
      );

      if (response.data != null && response.data is Map<String, dynamic>) {
        final responseMap = response.data as Map<String, dynamic>;
        final data = responseMap['data'];
        if (data is List) {
          return DataListResponse<T>(
            data: data.map((e) => decoder(e)).toList(),
          );
        }
      }
      return null;
    } on DioException catch (e) {
      throw RemoteException(
        kind: RemoteExceptionKind.serverUndefined,
        httpErrorCode: e.response?.statusCode ?? 500,
        serverError: ServerError(generalMessage: e.message ?? 'Upload failed'),
      );
    }
  }

  Future<Map<String, dynamic>> _buildMultipartFormData(
    Map<String, dynamic> formData,
  ) async {
    final multipartFormData = <String, dynamic>{};

    for (final entry in formData.entries) {
      if (entry.value is File) {
        final file = entry.value as File;
        multipartFormData[entry.key] = await MultipartFile.fromFile(
          file.path,
          filename: file.path.split('/').last,
        );
      } else if (entry.value is List<File>) {
        final files = entry.value as List<File>;
        multipartFormData[entry.key] = await Future.wait(
          files.map(
            (file) => MultipartFile.fromFile(
              file.path,
              filename: file.path.split('/').last,
            ),
          ),
        );
      } else {
        multipartFormData[entry.key] = entry.value;
      }
    }

    return multipartFormData;
  }
}
