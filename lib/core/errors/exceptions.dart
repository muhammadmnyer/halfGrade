abstract class Exception{
  final String message;
  const Exception({required this.message});
}

class ServerException extends Exception{
  const ServerException({required super.message});
}

class CacheException extends Exception{
  const CacheException({required super.message});
}

class AuthException extends Exception{
  const AuthException({required super.message});
}