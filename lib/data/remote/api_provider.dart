import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter_demo_axon/bloc/model/post_response.dart';
import 'package:flutter_demo_axon/data/remote/logging_interceptor.dart';
import 'package:meta/meta.dart';

class ApiProvider {
  final String _baseUrl = "https://api.unsplash.com/";
  final String _searchPhotosEndpoint = "search/photos";

  final Map<String, String> _headers = {
    "Authorization": "Client-ID y0zEbQk55sOi9lCcr0VP_WjU6AMtxPeFZMh9zZE2mrA",
  };

  Dio _dio;

  ApiProvider() {
    BaseOptions options = BaseOptions(receiveTimeout: 5000, connectTimeout: 5000);
    _dio = Dio(options);
    _dio.interceptors.add(LoggingInterceptor());
  }

  Future<PostResponse> getPosts({@required String query, @required int page}) async {
    Map<String, dynamic> queryParameters = {
      "query": query,
      "page": page,
      "per_page": 20,
      "content_filter": "high",
    };

    try {
      Response response = await _dio.get(
        _baseUrl + _searchPhotosEndpoint,
        queryParameters: queryParameters,
        options: Options(contentType: Headers.formUrlEncodedContentType, headers: _headers),
      );
      return PostResponse.fromJson(response.data);
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      throw Exception(_handleError(error));
    }
  }

  String _handleError(Error error) {
    String errorDescription = "";
    if (error is DioError) {
      DioError dioError = error as DioError;
      switch (dioError.type) {
        case DioErrorType.CANCEL:
          errorDescription = "Request to API server was cancelled";
          break;
        case DioErrorType.CONNECT_TIMEOUT:
          errorDescription = "Connection timeout with API server";
          break;
        case DioErrorType.DEFAULT:
          errorDescription = "Connection to API server failed due to internet connection";
          break;
        case DioErrorType.RECEIVE_TIMEOUT:
          errorDescription = "Receive timeout in connection with API server";
          break;
        case DioErrorType.RESPONSE:
          errorDescription = "Received invalid status code: ${dioError.response.statusCode}";
          break;
        case DioErrorType.SEND_TIMEOUT:
          errorDescription = "Send timeout in connection with API server";
          break;
      }
    } else {
      errorDescription = "Unexpected error occured";
    }
    return errorDescription;
  }
}
