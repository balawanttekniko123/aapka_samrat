class ApiException implements Exception {
  final String message;
  ApiException(this.message);
}

class NetworkException extends ApiException {
  NetworkException() : super("No Internet Connection");
}

class ServerException extends ApiException {
  ServerException([String? message]) : super(message ?? "Server Error");
}

class UnauthorizedException extends ApiException {
  UnauthorizedException() : super("Unauthorized Request");
}
