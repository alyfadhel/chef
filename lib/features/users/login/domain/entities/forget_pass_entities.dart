import 'package:equatable/equatable.dart';

class ForgetPasswordEntities extends Equatable {
  final String? message;

  const ForgetPasswordEntities({
    required this.message,
  });

  @override
  List<Object?> get props => [
    message,
  ];
}
