import 'package:chef/core/error/failure.dart';
import 'package:chef/core/usecase/base_usecase.dart';
import 'package:chef/features/users/login/domain/entities/forget_pass_entities.dart';
import 'package:chef/features/users/login/domain/repository/base_login_repository.dart';
import 'package:dartz/dartz.dart';

class GetForgetPasswordUseCase extends BaseUseCase<ForgetPasswordEntities,ForgetPassParameter>
{
  final BaseLoginRepository baseLoginRepository;

  GetForgetPasswordUseCase(this.baseLoginRepository);
  @override
  Future<Either<Failure, ForgetPasswordEntities>> call(ForgetPassParameter parameter)async {
    return await baseLoginRepository.getPassForget(parameter);
  }

}