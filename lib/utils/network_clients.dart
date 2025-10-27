import 'dart:async';
import 'dart:developer';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:quick_bills/constants/api_constants.dart';
import 'package:quick_bills/utils/network_interceptors.dart';


enum FormDataType { post, patch, put }

class NetworkClient {
  factory NetworkClient() => _singleton;
  NetworkClient._internal();
  static final _singleton = NetworkClient._internal();

  // late final LocalCache _localCache = LocalCacheImpl ();

  final Dio _dio = createDio();
CancelToken cancelToken = CancelToken();

// ======================================================
//================== Dio Initialization =================
//=======================================================
static Dio createDio() {
    final dio = Dio(
// static late dio.CancelToken cancelToken;
      BaseOptions(
        baseUrl: ApiRoute.baseUrl,
        receiveTimeout: const Duration(seconds: 25), // 25 seconds
        connectTimeout: const Duration(seconds: 25),
        sendTimeout: const Duration(seconds: 25),
      ),
    );

    dio.interceptors.addAll({
      AppInterceptors(dio),
    });
    return dio;
  }

  Map<String, String> get _getAuthHeader {
      return {
      "Accept": "application/json",
      // "Content-Type": "application/x-www-form-urlencoded",
    };

  }

// ======================================================
//======================== Get ==========================
//=======================================================
  ///get request
  Future<T?> get<T>(

    String uri, {
    Map<String, dynamic> queryParameters = const {},
    Map<String, dynamic> requestHeaders = const {},
    String? token,
    ProgressCallback? onReceiveProgress,
  }) async {
    try {
      final response = await _dio.get(
        uri,
        queryParameters: queryParameters,
        cancelToken: cancelToken,
        onReceiveProgress: onReceiveProgress,
        //! TODO uncomment this line when you want to use auth header
        options: Options(headers: {..._getAuthHeader, ...requestHeaders}),
      );

      return response.data as T;
    } on PlatformException {
      rethrow;
    }
  }

// ======================================================
//======================== POST ==========================
//=======================================================
  ///Post request
  Future<dynamic> post(
    String uri, {
    Map<String, dynamic> queryParameters = const {},
    Map<String, dynamic> requestHeaders = const {},
    Object? body,
    String? token,
    // CancelToken? cancelToken,
    ProgressCallback? onReceiveProgress,
  }) async {
    if (kDebugMode) {  
    log("""
      Url : $uri
    BODY : $body
      Params : $queryParameters,
      Headers : ${{..._getAuthHeader, ...requestHeaders}}
      """);
    }
    try {
      final response = await _dio.post(
        uri,
        queryParameters: queryParameters,
        data: body,
        cancelToken: cancelToken,
        onReceiveProgress: onReceiveProgress,
        options: Options(
          headers: {..._getAuthHeader, ...requestHeaders},
        ),
      );
      if (kDebugMode) {
        debugPrint(response.headers.value('token').toString());
      log(response.statusCode.toString());
      }
      return response.data;
    } on PlatformException {
      rethrow;
    }
  }

// ======================================================
//======================== PUT ==========================
//=======================================================
  ///Put Request
  Future<T?> put<T>(
    String uri, {
    Map<String, dynamic> queryParameters = const {},
    Map<String, dynamic> requestHeaders = const {},
    Object body = const {},
    // CancelToken? cancelToken,
    ProgressCallback? onReceiveProgress,
  }) async {
    try {
      final response = await _dio.put(
        uri,
        queryParameters: queryParameters,
        data: body,
        cancelToken: cancelToken,
        onReceiveProgress: onReceiveProgress,
        options: Options(
          headers: {..._getAuthHeader, ...requestHeaders},
        ),
      );
      return response.data as T;
    } on PlatformException {
      rethrow;
    }
  }

  Future<T?> patch<T>(
    /// the api route without the base url
    String uri, {
   
    Map<String, dynamic> queryParameters = const {},
    Map<String, dynamic> requestHeaders = const {},
    Object body = const {},
    // CancelToken? cancelToken,
    ProgressCallback? onReceiveProgress,
  }) async {
    try {
      final response = await _dio.patch(
        uri,
        queryParameters: queryParameters,
        data: body,
        // cancelToken: cancelToken,
        onReceiveProgress: onReceiveProgress,
        options: Options(
          headers: {..._getAuthHeader, ...requestHeaders},
        ),
      );
      return response.data as T;
    } on PlatformException {
      rethrow;
    }
  }

// ======================================================
//======================== delete ==========================
//=======================================================
  ///get request
  Future<T?> delete<T>(
    /// the api route path without the base url
    ///
    String uri, {
    Map<String, dynamic> queryParameters = const {},
    Map<String, dynamic> requestHeaders = const {},
    // Options options,
    // CancelToken? cancelToken,
  }) async {
    try {
      final response = await _dio.delete(
        uri,
        queryParameters: queryParameters,
        cancelToken: cancelToken,
        options: Options(
          headers: {..._getAuthHeader, ...requestHeaders},
        ),
      );

      return response.data as T;
    } on PlatformException {
      rethrow;
    }
  }

// ======================================================
//====================== Form data ======================
//=======================================================
  ///Form Data

  Future<dynamic> sendFormData(
    FormDataType requestType, {
    String? imageKey,
    String? imageKey2,
    required String uri,
    Map<String, dynamic> queryParameters = const {},
    Map<String, dynamic> requestHeaders = const {},
    Map<String, dynamic>? body = const {},
    // CancelToken? cancelToken,
    File? image,
    File? image2,
    ProgressCallback? onReceiveProgress,
  }) async {
    try {
      FormData formData = FormData.fromMap(body!);
  
      if (image != null || image2 != null) {
        formData.files.addAll([
          if (image != null)
            MapEntry(
          imageKey ??
          'image',
          await MultipartFile.fromFile(
                image.path,
            filename: image.path.split('/').last,
            // contentType: MediaType('image', 'png'),
          ),
            ),
          if (image2 != null)
            MapEntry(
              imageKey2 ?? 'image',
              await MultipartFile.fromFile(
                image2.path,
                filename: image2.path.split('/').last,
                // contentType: MediaType('image', 'png'),
              ),
            )
        ]);
      }

      Response response;
      if (FormDataType.patch == requestType) {
        response = await _dio.patch(
          uri,
          queryParameters: queryParameters,
          data: formData,
          cancelToken: cancelToken,
          onReceiveProgress: onReceiveProgress,
          options: Options(
            headers: {..._getAuthHeader, ...requestHeaders},
          ),
        );
      } else if (FormDataType.put == requestType) {
        response = await _dio.put(
          uri,
          queryParameters: queryParameters,
          data: formData,
          cancelToken: cancelToken,
          onReceiveProgress: onReceiveProgress,
          options: Options(
            headers: {..._getAuthHeader, ...requestHeaders},
          ),
        );
      } else {
        response = await _dio.post(
          uri,
          queryParameters: queryParameters,
          data: formData,
          cancelToken: cancelToken,
          onReceiveProgress: onReceiveProgress,
          options: Options(
            headers: {..._getAuthHeader, ...requestHeaders},
          ),
        );
      }

      return response.data;
    } on PlatformException {
      rethrow;
    }
  }
}
