class AuthServiceException implements Exception{
  final String message;

  AuthServiceException({required this.message});
}