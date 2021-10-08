import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  List properties = const <dynamic>[];

  Failure([properties]);

  @override
  List<Object> get props => properties;
}


// Genaral Failures
class ServerFailure extends Failure {}

class CacheFailure extends Failure {}