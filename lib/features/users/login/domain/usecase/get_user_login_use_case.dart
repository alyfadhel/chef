import 'package:chef/core/error/failure.dart';
import 'package:chef/core/usecase/base_usecase.dart';
import 'package:chef/features/users/login/domain/entities/login_entities.dart';
import 'package:chef/features/users/login/domain/repository/base_login_repository.dart';
import 'package:dartz/dartz.dart';

class GetUserLoginUseCase extends BaseUseCase<LoginEntities,LoginParameter>
{
  final BaseLoginRepository baseLoginRepository;

  GetUserLoginUseCase(this.baseLoginRepository);
  @override
  Future<Either<Failure, LoginEntities>> call(LoginParameter parameter) async{
    return await baseLoginRepository.getUserLogin(parameter);
  }

}