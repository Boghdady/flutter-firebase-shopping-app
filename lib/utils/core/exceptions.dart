class ResourceNotFoundException implements Exception {
  String _message;

  ResourceNotFoundException(this._message);

  @override
  String toString() {
    return 'Resource $_message Not Found';
  }
}

class BadRequestException implements Exception {
  @override
  String toString() {
    return 'Bad Request';
  }
}

class RedirectionFoundException implements Exception {
  @override
  String toString() {
    return 'Too Many Redirection';
  }
}

class UnauthorizedException implements Exception {
  @override
  String toString() {
    return 'Unauthorized User';
  }
}

class NoInternetConnectionException implements Exception {
  @override
  String toString() {
    return 'No Internet Connection!';
  }
}

class PropertyIsRequiredException implements Exception {
  String _field;
  PropertyIsRequiredException(this._field);

  @override
  String toString() {
    return 'Property $_field is required form api';
  }
}
