import 'package:chef/core/error/failure.dart';
import 'package:chef/core/usecase/base_usecase.dart';
import 'package:chef/features/users/register/domain/entities/sign_up_entities.dart';
import 'package:chef/features/users/register/domain/repository/base_sign_up_repository.dart';
import 'package:dartz/dartz.dart';

class GetSignUpUseCase extends BaseUseCase<SignUpEntities,SignUpParameter>
{
  final BaseSignUpRepository baseSignUpRepository;

  GetSignUpUseCase(this.baseSignUpRepository);
  @override
  Future<Either<Failure, SignUpEntities>> call(SignUpParameter parameter)async {
    return await baseSignUpRepository.getSignUpUser(parameter);
  }

}