import 'package:chef/core/network/dio_helper.dart';
import 'package:chef/core/network/end_points.dart';
import 'package:chef/features/users/login/data/model/forget_password_model.dart';
import 'package:chef/features/users/login/data/model/login_model.dart';
import 'package:chef/features/users/login/data/model/reset_password_model.dart';
import 'package:chef/features/users/login/domain/repository/base_login_repository.dart';

abstract class BaseUserLoginRemoteDataSource {
  Future<LoginModel> getUserLogin(LoginParameter parameter);

  Future<ForgetPasswordModel> getForgetPass(ForgetPassParameter parameter);

  Future<ResetPasswordModel> getResetPassword(ResetPasswordParameter parameter);
}

class UserLoginRemoteDataSource extends BaseUserLoginRemoteDataSource {
  final DioHelper dioHelper;

  UserLoginRemoteDataSource(this.dioHelper);

  @override
  Future<LoginModel> getUserLogin(LoginParameter parameter) async {
    final response = await dioHelper.post(
      endPoint: loginEndPoint,
      data: {
        'email': parameter.email,
        'password': parameter.password,
      },
    );
    return LoginModel.fromJson(response);
  }

  @override
  Future<ForgetPasswordModel> getForgetPass(
      ForgetPassParameter parameter) async {
    final response = await dioHelper.post(
      endPoint: forgetPassEndPoint,
      data: {
        'email': parameter.email,
      },
    );
    return ForgetPasswordModel.fromJson(response);
  }

  @override
  Future<ResetPasswordModel> getResetPassword(
      ResetPasswordParameter parameter) async {
    final response = await dioHelper.patch(
      endPoint: resetPassEndPoint,
      data: {
        'email' : parameter.email,
        'password' : parameter.password,
        'confirmPassword' : parameter.confirmPassword,
        'code' : parameter.code,
      },
    );
    return ResetPasswordModel.fromJson(response);
  }
}
