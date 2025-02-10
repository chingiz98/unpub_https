class AuthException extends Error {
  AuthException({this.message = 'Auth exception'});

  String message;
}
