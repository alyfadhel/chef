import 'package:chef/core/error/failure.dart';
import 'package:chef/features/users/login/domain/entities/forget_pass_entities.dart';
import 'package:chef/features/users/login/domain/entities/login_entities.dart';
import 'package:chef/features/users/login/domain/entities/reset_password.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

abstract class BaseLoginRepository {
  Future<Either<Failure, LoginEntities>> getUserLogin(LoginParameter parameter);

  Future<Either<Failure, ForgetPasswordEntities>> getPassForget(
      ForgetPassParameter parameter);

  Future<Either<Failure, ResetPasswordEntities>> getResetPassword(
      ResetPasswordParameter parameter);
}

class LoginParameter extends Equatable {
  final String email;
  final String password;

  const LoginParameter({
    required this.email,
    required this.password,
  });

  @override
  List<Object?> get props => [
        email,
        password,
      ];
}

class ForgetPassParameter extends Equatable {
  final String email;

  const ForgetPassParameter({
    required this.email,
  });

  @override
  List<Object?> get props => [
        email,
      ];
}

class ResetPasswordParameter extends Equatable {
  final String email;
  final String password;
  final String confirmPassword;
  final String code;

  const ResetPasswordParameter({
    required this.email,
    required this.password,
    required this.confirmPassword,
    required this.code,
  });

  @override
  List<Object?> get props => [
    email,
    password,
    confirmPassword,
    code,
  ];
}
