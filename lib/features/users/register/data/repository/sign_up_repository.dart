import 'package:chef/core/error/exception.dart';
import 'package:chef/core/error/failure.dart';
import 'package:chef/features/users/register/data/data_source/base_sign_up_remote_data_source.dart';
import 'package:chef/features/users/register/domain/entities/sign_up_entities.dart';
import 'package:chef/features/users/register/domain/repository/base_sign_up_repository.dart';
import 'package:dartz/dartz.dart';

class SignUpRepository extends BaseSignUpRepository
{
  final BaseSignUpRemoteDataSource baseSignUpRemoteDataSource;

  SignUpRepository(this.baseSignUpRemoteDataSource);
  @override
  Future<Either<Failure, SignUpEntities>> getSignUpUser(SignUpParameter parameter)async {
    final result = await baseSignUpRemoteDataSource.getSignUpUser(parameter);

    try{
      return Right(result);
    }on ServerException catch(failure){
      return Left(ServerFailure(failure.statusErrorMessageModel.error));
    }
  }

}