import 'package:quick_bills/utils/exception.dart';

abstract class Failure implements Exception {
  String get message;

  String get title;

  bool get isInternetConnectionError =>
      runtimeType is NoInternetConnectionException;

  String getMessageFromServer(Map<String, dynamic> error) {
    // checking the error format
    // so i can apporpriately get the error message
    // Note: input errors are different from normal error
    late String errorMessage;
    //input error test
    if (error.containsKey("errors")) {
      //get the first error model in the list then
      //the msg of the error
      errorMessage = error["errors"] as String;
    }
    // normal error test
    else if (error.containsKey("message")) {
      errorMessage = error["message"] as String;
    } //default
    else {
      errorMessage = "Error";
    }
    return errorMessage;
  }

  @override
  String toString() {
    return "error title => $title, error message => $message";
  }
}
