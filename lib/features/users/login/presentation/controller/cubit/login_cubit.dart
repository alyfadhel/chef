import 'package:chef/features/users/login/domain/entities/forget_pass_entities.dart';
import 'package:chef/features/users/login/domain/entities/login_entities.dart';
import 'package:chef/features/users/login/domain/entities/reset_password.dart';
import 'package:chef/features/users/login/domain/repository/base_login_repository.dart';
import 'package:chef/features/users/login/domain/usecase/get_forget_password_use_case.dart';
import 'package:chef/features/users/login/domain/usecase/get_reset_password_use_case.dart';
import 'package:chef/features/users/login/domain/usecase/get_user_login_use_case.dart';
import 'package:chef/features/users/login/presentation/controller/cubit/login_states.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginCubit extends Cubit<LoginStates> {
  LoginCubit(
    this.getUserLoginUseCase,
    this.getForgetPasswordUseCase,
    this.getResetPasswordUseCase,
  ) : super(InitialLoginState());

  final GetUserLoginUseCase getUserLoginUseCase;
  final GetForgetPasswordUseCase getForgetPasswordUseCase;
  final GetResetPasswordUseCase getResetPasswordUseCase;
  LoginEntities? loginEntities;
  ForgetPasswordEntities? forgetPasswordEntities;
  ResetPasswordEntities? resetPasswordEntities;

  static LoginCubit get(context) => BlocProvider.of(context);

  bool isPassword = true;
  IconData suffix = Icons.visibility_outlined;
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var confirmPasswordController = TextEditingController();
  var code = TextEditingController();
  var formKey = GlobalKey<FormState>();

  void changeLoginPasswordVisibility() {
    isPassword = !isPassword;
    suffix =
        isPassword ? Icons.visibility_outlined : Icons.visibility_off_outlined;
    emit(ChangeLoginPasswordVisibility());
  }

  void getUserLogin({
    required String email,
    required String password,
  }) async {
    final result = await getUserLoginUseCase(
      LoginParameter(
        email: email,
        password: password,
      ),
    );
    result.fold(
      (l) {
        emit(LoginErrorState(l.message));
      },
      (r) {
        loginEntities = r;
        emit(LoginSuccessState(r));
      },
    );
  }

  void forgetPassword({
    required String email,
  }) async {
    final result = await getForgetPasswordUseCase(
      ForgetPassParameter(
        email: email,
      ),
    );
    result.fold(
      (l) {
        emit(ForgetPasswordErrorState(l.message));
      },
      (r) {
        forgetPasswordEntities = r;
        emit(ForgetPasswordSuccessState(r));
      },
    );
  }

  void getResetPassword({
    required String email,
    required String password,
    required String confirmPassword,
    required String code,
  }) async {
    final result = await getResetPasswordUseCase(
      ResetPasswordParameter(
        email: email,
        password: password,
        confirmPassword: confirmPassword,
        code: code,
      ),
    );
    result.fold(
      (l) {
        emit(ResetPasswordErrorState(l.message));
      },
      (r) {
        resetPasswordEntities = r;
        emit(ResetPasswordSuccessState(r));
      },
    );
  }
}
