import 'package:equatable/equatable.dart';

class SignUpEntities extends Equatable {
  final String? message;

  const SignUpEntities({
    required this.message,
  });

  @override
  List<Object?> get props => [
    message,
  ];
}
