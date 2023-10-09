import 'package:chef/core/error/failure.dart';
import 'package:chef/core/usecase/base_usecase.dart';
import 'package:chef/features/users/login/domain/entities/reset_password.dart';
import 'package:chef/features/users/login/domain/repository/base_login_repository.dart';
import 'package:dartz/dartz.dart';

class GetResetPasswordUseCase extends BaseUseCase<ResetPasswordEntities,ResetPasswordParameter>
{
  final BaseLoginRepository baseLoginRepository;

  GetResetPasswordUseCase(this.baseLoginRepository);
  @override
  Future<Either<Failure, ResetPasswordEntities>> call(ResetPasswordParameter parameter)async {
    return await baseLoginRepository.getResetPassword(parameter);
  }

}