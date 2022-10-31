import 'package:dio/dio.dart';

import 'failure.dart';

class ErrorHandler implements Exception {
  // we need to return Failure object to listen to Either Object in repository class  Future<Either<Failure, Authentication>> login(

  late Failure failure;
// we create named constructore to ErrorHandler
  ErrorHandler.handle(dynamic error) {
    //it will check to Dio Error because we handel the API with Dio Package
    if (error is DioError) {
      // Dio error so it is an Error from Response  API or from Dio it self(Time Out / Cancel)
      failure = _handleError(error);
    } else {
      // default Error
      failure = DataSource.DEFAULT.getFailure();
    }
  }

  Failure _handleError(DioError error) {
    switch (error.type) {
      case DioErrorType.connectTimeout:
        return DataSource.CONNECT_TIMEOUT.getFailure();
      case DioErrorType.sendTimeout:
        return DataSource.SEND_TIMEOUT.getFailure();

      case DioErrorType.receiveTimeout:
        return DataSource.RECIEVE_TIMEOUT.getFailure();

      case DioErrorType.response:
        //Response got from DIo
        if (error.response != null &&
            error.response?.statusCode != null &&
            error.response?.statusMessage != null) {
          return Failure(error.response?.statusCode ?? 0,
              error.response?.statusMessage ?? "");
        } else {
          return DataSource.DEFAULT.getFailure();
        }
        break;

      case DioErrorType.cancel:
        return DataSource.CANCEL.getFailure();

      case DioErrorType.other:
        return DataSource.DEFAULT.getFailure();
    }
  }
}

enum DataSource {
  SUCCESS,
  NO_CONTENT,
  BAD_REQUEST,
  FORBIDDEN,
  NOT_FOUND,
  UNAUTHORISED,
  INTERNAL_SERVER_ERROR,
  CONNECT_TIMEOUT,
  CANCEL,
  RECIEVE_TIMEOUT,
  SEND_TIMEOUT,
  CACHE_ERROR,
  NO_INTERNET_CONNECTION,
  DEFAULT
}

extension DataSourceExtenstion on DataSource {
  Failure getFailure() {
    switch (this) {
      case DataSource.SUCCESS:
        return Failure(ResponseCode.BAD_REQUEST, ResponseMessage.BAD_REQUEST);
      case DataSource.NO_CONTENT:
        return Failure(ResponseCode.NO_CONTENT, ResponseMessage.NO_CONTENT);
      case DataSource.BAD_REQUEST:
        return Failure(ResponseCode.BAD_REQUEST, ResponseMessage.BAD_REQUEST);
      case DataSource.FORBIDDEN:
        return Failure(ResponseCode.FORBIDDEN, ResponseMessage.FORBIDDEN);
      case DataSource.UNAUTHORISED:
        return Failure(ResponseCode.UNAUTHORISED, ResponseMessage.UNAUTHORISED);
      case DataSource.NOT_FOUND:
        return Failure(ResponseCode.NOT_FOUND, ResponseMessage.NOT_FOUND);
      case DataSource.INTERNAL_SERVER_ERROR:
        return Failure(ResponseCode.INTERNAL_SERVER_ERROR,
            ResponseMessage.INTERNAL_SERVER_ERROR);
      case DataSource.CONNECT_TIMEOUT:
        return Failure(
            ResponseCode.CONNECT_TIMEOUT, ResponseMessage.CONNECT_TIMEOUT);
      case DataSource.CANCEL:
        return Failure(ResponseCode.CANCEL, ResponseMessage.CANCEL);
      case DataSource.RECIEVE_TIMEOUT:
        return Failure(
            ResponseCode.RECIEVE_TIMEOUT, ResponseMessage.RECIEVE_TIMEOUT);
      case DataSource.SEND_TIMEOUT:
        return Failure(ResponseCode.SEND_TIMEOUT, ResponseMessage.SEND_TIMEOUT);
      case DataSource.CACHE_ERROR:
        return Failure(ResponseCode.CACHE_ERROR, ResponseMessage.CACHE_ERROR);
      case DataSource.NO_INTERNET_CONNECTION:
        return Failure(ResponseCode.NO_INTERNET_CONNECTION,
            ResponseMessage.NO_INTERNET_CONNECTION);
      case DataSource.DEFAULT:
        return Failure(ResponseCode.DEFAULT, ResponseMessage.DEFAULT);
    }
  }
}

class ResponseCode {
  static const int SUCESS = 200; // success with data
  static const int NO_CONTENT = 201; // success with no data (no connecton)
  static const int BAD_REQUEST = 400; //failure , API rejected request
  static const int UNAUTHORISED = 401; //failure ,
  static const int NOT_FOUND = 403; //failure , NOT_FOUND

  static const int FORBIDDEN = 404; //failure, user is not authorised
  static const int INTERNAL_SERVER_ERROR = 500; //failure , crash in server side

//local status code
  static const int CONNECT_TIMEOUT = -1;
  static const int CANCEL = -2;
  static const int RECIEVE_TIMEOUT = -3;
  static const int SEND_TIMEOUT = -4;
  static const int CACHE_ERROR = -5;
  static const int NO_INTERNET_CONNECTION = -6;
  static const int DEFAULT = -7;
}

class ResponseMessage {
  static const String SUCESS = "success";
  static const String NO_CONTENT = "success";
  static const String BAD_REQUEST = "Bad Request , Try againlater";
  static const String UNAUTHORISED = "User is unauthorised, try again later";
  static const String NOT_FOUND = "Not Found , Try againlater";

  static const String FORBIDDEN = "Forbidden request, Try again later";
  static const String INTERNAL_SERVER_ERROR = "Something went wrong, Try again";

  static const String CONNECT_TIMEOUT = "Time out error, Try again later";
  static const String CANCEL = "request was cancelled , Try again later";
  static const String RECIEVE_TIMEOUT = "Time out error,  Try again later";
  static const String SEND_TIMEOUT = "Time out error,  Try again later";
  static const String CACHE_ERROR = "Cache error, Try again later";
  static const String NO_INTERNET_CONNECTION =
      "Please check your Internet Connection";
  static const String DEFAULT = "Something went wrong, Try again";
}

class ApiInternalStatus {
  static const int SUCCESS = 0;
  static const int FAILURE = 1;
}
