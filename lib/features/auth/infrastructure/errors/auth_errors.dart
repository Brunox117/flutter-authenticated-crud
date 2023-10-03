class WrongCredentials implements Exception{}
class InvalidToken implements Exception{}
class ConnectionTimeout implements Exception{}
class CustomError implements Exception{
  final String message;
  // final int errorCode;
  final bool loggedRequired;
  CustomError(this.message, [this.loggedRequired = false]);
}