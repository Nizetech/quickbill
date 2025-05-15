import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:get/get.dart' hide Response;
import 'package:jost_pay_wallet/Ui/Authentication/SignInScreen.dart';
import 'package:jost_pay_wallet/common/cancel_loading.dart';
import 'package:jost_pay_wallet/utils/app_logger.dart';
import 'package:jost_pay_wallet/utils/exception.dart';
import 'package:jost_pay_wallet/utils/failure.dart';
import 'package:jost_pay_wallet/utils/toast.dart';

class AppInterceptors extends Interceptor {
  AppInterceptors(this.dio);
  final _log = appLogger(AppInterceptors);
  final Dio dio;

  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    // checkStatusCode(response.requestOptions, response);
    // print(÷.realUri);

    _log.custom(
      "--------- Calling Api [${DateTime.now()}]----------",
      color: LoggerColor.darkGrey,
      functionName: "onRequest",
    );
    print("${options.method}: ${options.path}");
    _log.custom(
      "${options.method}: ${options.path}",
      color: LoggerColor.darkGrey,
      functionName: "onRequest",
    );
    _log.custom(
      options.uri,
      color: LoggerColor.darkGrey,
      functionName: "onRequest",
    );
    return handler.next(options);
  }

  @override
  Future<dynamic> onResponse(
    Response response,
    ResponseInterceptorHandler handler,
  ) async {
    checkStatusCode(response.requestOptions, response);

    _log.custom(
      "--------- Api Response [${DateTime.now()}]----------",
      color: LoggerColor.darkGrey,
      functionName: "onResponse",
    );
    if (response.data != null &&
        response.data is String &&
        (response.data as String).toLowerCase().contains("doctype")) {
      CancelLoading().cancelLoading();
      ErrorToast(
          "Invalid response recieved, logging out and redirecting to login page");
      // await navigatorKey.currentState!
      //     .pushNamedAndRemoveUntil(SigninScreen.login, (route) => false);
      Get.offAll(SignInScreen());
    }
    _log.custom(
      response.requestOptions.uri,
      color: LoggerColor.darkGrey,
      functionName: "onResponse",
    );
    return handler.next(response);
  }

  @override
  Future onError(
    DioException err,
    ErrorInterceptorHandler handler,
  ) async {
    _log.e(err.requestOptions.headers, functionName: "onError[1]");
    _log.e(err.requestOptions.data, functionName: "onError[2]");
    _log.e(err.response?.data, functionName: "onError[3]");
    // if (authRepo.isDialogShowing == true) {
    //   // log(err.response!.data.toString());
    //   // log(err.response?.data['message'].toString() ?? "");
    //   hideLoader();
    // }
    // log('Data: Not String ==> ${err.response?.data}');

    // log(err.response!.data.toString());
    if (err.response?.data['data']?['error'] != null
        // ignore: unnecessary_null_comparison
        ) {
      Map data = {};
      String message = "";
      if (err.response?.data['data']['error'].runtimeType != String) {
        log('Data: Not String ==> ${err.response?.data['data']}');
        if (err.response?.data['data']['error'] != null) {
          data = err.response?.data['data']['error'];
          message = data.values
              .map((e) => e is String
                  ? e
                  : e is List && e.isNotEmpty
                      ? e[0]
                      : '')
              .toList()
              .first;
          CancelLoading().cancelLoading();
          ErrorToast(message);
        } else {
          message = err.response?.data['data']['message'];
          CancelLoading().cancelLoading();
          ErrorToast(message);
        }
      } else {
        message = err.response?.data['data']['error'];
        CancelLoading().cancelLoading();
        ErrorToast(message);
      }
      // first message
      // ErrorToast(message);
    } else if (err.response?.data['data']?['message'] != null) {
      CancelLoading().cancelLoading();
      ErrorToast(err.response?.data['data']?['message'] ?? "");
    } else {
      var message = err.response?.data['message']?.toString();
      log('Message $message');
      CancelLoading().cancelLoading();
      ErrorToast(message!);
      // if (message?.toLowerCase() == 'unauthenticated') {
      //   // await navigatorKey.currentState!
      //   //     .pushNamedAndRemoveUntil(SigninScreen.login, (route) => false);
      //   // return;
      //   log("Unauthenticated");
      // }
    }
    _log.e(err.response?.statusCode, functionName: "onError[4]");

    switch (err.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        // reasign err variable
        err = DeadlineExceededException(err.requestOptions);
        break;
      case DioExceptionType.connectionError:
      case DioExceptionType.badResponse:
        try {
          checkStatusCode(err.requestOptions, err.response);
        } on DioException catch (failure) {
          // reasign err variable
          err = failure;
        }

        break;
      case DioExceptionType.cancel:
        break;
      case DioExceptionType.badCertificate:
        err = BadCertificateException(err.requestOptions);
        break;
      case DioExceptionType.unknown:
        _log.e(err.message, functionName: "onError[other]");
        err = NoInternetConnectionException(err.requestOptions);
    }
    //continue
    return handler.next(err);
  }

  void checkStatusCode(RequestOptions requestOptions, Response? response) {
    try {
      switch (response?.statusCode) {
        case 200:
        case 204:
        case 201:
        case 202:
          break;
        case 400:
          throw BadRequestException(requestOptions, response);
        case 401:
          throw UnauthorizedException(requestOptions, response);
        case 404:
          throw NotFoundException(requestOptions);
        case 409:
          throw ConflictException(requestOptions, response);
        case 500:
          throw InternalServerErrorException(requestOptions);
        default:
          _log.e(response?.data, functionName: "onError[checkStatusCode]");
          _log.e(
            response?.statusCode,
            functionName: "onError[checkStatusCode]",
          );
          throw ServerCommunicationException(response);
      }
    } on Failure {
      rethrow;
    }
  }
}
