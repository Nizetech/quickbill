import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:jost_pay_wallet/utils/failure.dart';

class AudioServiceException extends Failure {
  AudioServiceException(this._title, this._message);
  final String _title;
  final String _message;

  @override
  String get message => _message;

  @override
  String get title => _title;
}

class ChatException extends Failure {
  ChatException(this._title, this._message);
  final String _title;
  final String _message;

  @override
  String get message => _message;

  @override
  String get title => _title;
}

class FileSaverException extends Failure {
  FileSaverException(this._title, this._message);
  final String _title;
  final String _message;

  @override
  String get message => _message;

  @override
  String get title => _title;
}

class FilePickerException extends Failure {
  FilePickerException(this._title, this._message);
  final String _title;
  final String _message;

  @override
  String get message => _message;

  @override
  String get title => _title;
}

class PaymentException extends Failure {
  PaymentException(this._title, this._message);
  final String _title;
  final String _message;

  @override
  String get message => _message;

  @override
  String get title => _title;
}

class LocalPersistenceException extends Failure {
  LocalPersistenceException(this._title, this._message);
  final String _title;
  final String _message;

  @override
  String get message => _message;

  @override
  String get title => _title;
}

class UserDefinedException extends Failure {
  UserDefinedException(this._title, this._message);
  final String _title;
  final String _message;

  @override
  String get message => _message;

  @override
  String get title => _title;
}

/// 400
class BadRequestException extends DioException {
  BadRequestException(this.request, [this.serverResponse])
      : super(requestOptions: request, response: serverResponse);
  final RequestOptions request;
  final Response? serverResponse;
  @override
  String toString() {
    return 'title: $title message: $message';
  }

  @override
  String get message =>
      (serverResponse?.data?["message"] ?? "Invalid request") as String;

  @override
  String get title => "an error occured";
}

/// 500
class InternalServerErrorException extends DioException {
  InternalServerErrorException(RequestOptions r) : super(requestOptions: r);

  @override
  String toString() {
    return 'title: $title message: $message';
  }

  @override
  String get message => "Unknown error occurred, please try again later.";

  @override
  String get title => "Server error";
}

/// 409
// ignore: deprecated_member_use
class ConflictException extends DioError {
  ConflictException(this.request, [this.serverResponse])
      : super(requestOptions: request, response: serverResponse);
  final RequestOptions request;
  final Response? serverResponse;
  @override
  String toString() {
    return 'title: $title message: $message';
  }

  @override
  String get message =>
      (serverResponse?.data?["message"] ?? "Conflict occurredd.") as String;

  @override
  String get title => "Network error";
}

/// 401
class UnauthorizedException extends DioException {
  UnauthorizedException(this.request, [this.serverResponse])
      : super(requestOptions: request, response: serverResponse);
  final RequestOptions request;
  final Response? serverResponse;
  @override
  String toString() {
    return 'title: $title message: $message';
  }

  @override
  String get message =>
      (serverResponse?.data?["message"] ?? "Invalid request") as String;
  @override
  String get title => "Access denied";
}

/// 404
class NotFoundException extends DioException {
  NotFoundException(this.request, [this.serverResponse])
      : super(requestOptions: request, response: serverResponse);
  final RequestOptions request;
  final Response? serverResponse;
  @override
  String toString() {
    return 'title: $title message: $message';
  }

  @override
  String get message =>
      (serverResponse?.data?["message"] ?? "Not Found, please try again.")
          as String;

  // @override
  // String get message => "Not Found, please try again.";

  @override
  String get title => "Not Found";
}

/// No Internet
class NoInternetConnectionException extends DioException {
  NoInternetConnectionException(RequestOptions r) : super(requestOptions: r);

  @override
  String toString() {
    return 'title: $title message: $message';
  }

  @override
  String get message => "No internet connection, please try again.";

  @override
  String get title => "Network error";
}

class BadCertificateException extends DioException {
  BadCertificateException(RequestOptions r) : super(requestOptions: r);

  @override
  String toString() {
    return 'title: $title message: $message';
  }

  @override
  String get message => "Server is experincing temporary, please try again.";

  @override
  String get title => "Server error";
}

/// Timeout
class DeadlineExceededException extends DioException {
  DeadlineExceededException(RequestOptions r) : super(requestOptions: r);

  @override
  String toString() {
    return 'title: $title message: $message';
  }

  @override
  String get message => "The connection has timed out, please try again.";

  @override
  String get title => "Network error";
}

@override
String toString() {
  return 'The connection has timed out, please try again.';
}

/// errors sent back by the server in json
class ServerCommunicationException extends Failure {
  final Response? r;
  ServerCommunicationException(this.r) : super();
  // : super(requestOptions: r!.requestOptions);

  /// sustained so that the data sent by the server can be gotten to construct message

  @override
  String toString() {
    return 'title: $title message: $message';
  }

  @override
  String get message {
    try {
      log(r?.data?.toString() ?? "");
      return getMessageFromServer(
        (r?.data ?? {"message": "Server Error"}) as Map<String, dynamic>,
      );
    } catch (e) {
      return "Something went wrong";
    }
  }
  // eddietonsagie@gmail.com

  @override
  String get title => "Network error";
}
// austingodwin18@gmail.com
