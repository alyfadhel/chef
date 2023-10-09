import 'package:equatable/equatable.dart';

class LoginEntities extends Equatable {
  final String? message;
  final String? token;

  const LoginEntities({
    required this.message,
    required this.token,
  });

  @override
  List<Object?> get props => [
    message,
    token,
  ];
}
