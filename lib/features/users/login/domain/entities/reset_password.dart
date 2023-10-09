import 'package:equatable/equatable.dart';

class ResetPasswordEntities extends Equatable {
  final String? message;

  const ResetPasswordEntities({
    required this.message,
  });

  @override
  List<Object?> get props => [
        message,
      ];
}
