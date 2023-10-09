import 'package:chef/features/users/login/domain/entities/reset_password.dart';

class ResetPasswordModel extends ResetPasswordEntities {
  const ResetPasswordModel({
    required super.message,
  });

  factory ResetPasswordModel.fromJson(Map<String, dynamic> json) {
    return ResetPasswordModel(
      message: json['message'],
    );
  }
}
