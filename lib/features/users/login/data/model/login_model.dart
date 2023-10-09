import 'package:chef/features/users/login/domain/entities/login_entities.dart';

class LoginModel extends LoginEntities {
  const LoginModel({
    required super.message,
    required super.token,
  });

  factory LoginModel.fromJson(Map<String, dynamic> json) {
    return LoginModel(
      message: json['message'],
      token: json['token'],
    );
  }
}
