class AppExceptions implements Exception {
  final _message;
  final _prefix;

  AppExceptions([this._message, this._prefix]);

  @override
  String toString() {
    return '$_prefix $_message';
  }
}

/// Error handling for internet issue
class InternetException extends AppExceptions {
  InternetException([String? message]) : super(message, 'No internet');
}

/// Error handling for Request Time Out issue
class RequestTimeOut extends AppExceptions {
  RequestTimeOut([String? message]) : super(message, 'Request time out');
}

/// Error handling for Server issue
class ServerException extends AppExceptions {
  ServerException([String? message]) : super(message, 'Internal server error');
}

class InvalidUrlException extends AppExceptions {
  InvalidUrlException([String? message]) : super(message, 'Url is  Invalid');
}

class FetchDataException extends AppExceptions {
  FetchDataException([String? message]) : super(message, '');
}
