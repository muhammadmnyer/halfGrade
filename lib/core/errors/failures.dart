abstract class Failure{
  final String message;
  const Failure({required this.message});

  @override
  bool operator ==(Object other) {
    return other is Failure&&
    message == other.message;
  }

  @override
  int get hashCode => 0;

}

class ServerFailure extends Failure{
  const ServerFailure({required super.message});
}

class CacheFailure extends Failure{
  const CacheFailure({required super.message});
}

class AuthFailure extends Failure{
  const AuthFailure({required super.message});
}