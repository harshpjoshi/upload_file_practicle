import 'package:equatable/equatable.dart';

class LocalException extends Equatable implements Exception {
  const LocalException({required this.message});

  final String message;

  @override
  List<Object?> get props => [message];
}
