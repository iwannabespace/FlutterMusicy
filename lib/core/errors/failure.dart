import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  const Failure(this.message);
  final String? message;

  @override
  List<Object?> get props => [message];
}

class ServerFailure extends Failure {
  const ServerFailure(super.message);

  @override
  List<Object?> get props => [message];
}

class InternetFailure extends Failure {
  const InternetFailure(super.message);

  @override
  List<Object?> get props => [message];
}

class EnvironmentFailure extends Failure {
  const EnvironmentFailure(super.message);

  @override
  List<Object?> get props => [message];
}

class CacheFailure extends Failure {
  const CacheFailure(super.message);

  @override
  List<Object?> get props => [message];
}

class MusicCancelFailure extends Failure {
  const MusicCancelFailure(super.message);

  @override
  List<Object?> get props => [message];
}

class MusicConvertFailure extends Failure {
  const MusicConvertFailure(super.message);

  @override
  List<Object?> get props => [message];
}
