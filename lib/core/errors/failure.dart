import 'package:equatable/equatable.dart';
import 'package:upload_file_practicle/core/errors/local_exception.dart';

abstract class Failure extends Equatable {
  const Failure({required this.message});

  final String message;

  String get errorMessage => message;

  @override
  List<Object> get props => [message];
}

class LocalFailure extends Failure {
  const LocalFailure({required super.message});

  LocalFailure.fromException(LocalException exception)
      : this(
          message: exception.message,
        );
}
