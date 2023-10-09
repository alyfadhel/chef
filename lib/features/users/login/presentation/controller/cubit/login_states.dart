import 'package:chef/features/users/login/domain/entities/forget_pass_entities.dart';
import 'package:chef/features/users/login/domain/entities/login_entities.dart';
import 'package:chef/features/users/login/domain/entities/reset_password.dart';

abstract class LoginStates{}

class InitialLoginState extends LoginStates{}

class ChangeLoginPasswordVisibility extends LoginStates{}

class LoginLoadingState extends LoginStates{}
class LoginSuccessState extends LoginStates{
  final LoginEntities loginEntities;

  LoginSuccessState(this.loginEntities);
}
class LoginErrorState extends LoginStates{
  final String error;

  LoginErrorState(this.error);
}

class ForgetPasswordSuccessState extends LoginStates
{
  final ForgetPasswordEntities forgetPasswordEntities;

  ForgetPasswordSuccessState(this.forgetPasswordEntities);
}

class ForgetPasswordErrorState extends LoginStates
{
  final String error;

  ForgetPasswordErrorState(this.error);
}

class ResetPasswordSuccessState extends LoginStates{
  final ResetPasswordEntities resetPasswordEntities;

  ResetPasswordSuccessState(this.resetPasswordEntities);
}
class ResetPasswordErrorState extends LoginStates{
  final String error;

  ResetPasswordErrorState(this.error);
}