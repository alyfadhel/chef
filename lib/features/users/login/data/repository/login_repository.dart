import 'package:chef/core/error/exception.dart';
import 'package:chef/core/error/failure.dart';
import 'package:chef/features/users/login/data/data_source/base_user_login_remote_data_source.dart';
import 'package:chef/features/users/login/domain/entities/forget_pass_entities.dart';
import 'package:chef/features/users/login/domain/entities/login_entities.dart';
import 'package:chef/features/users/login/domain/entities/reset_password.dart';
import 'package:chef/features/users/login/domain/repository/base_login_repository.dart';
import 'package:dartz/dartz.dart';

class LoginRepository extends BaseLoginRepository
{
  final BaseUserLoginRemoteDataSource baseUserLoginRemoteDataSource;

  LoginRepository(this.baseUserLoginRemoteDataSource);
  @override
  Future<Either<Failure, LoginEntities>> getUserLogin(LoginParameter parameter)async {
    final result = await baseUserLoginRemoteDataSource.getUserLogin(parameter);

    try{
      return Right(result);
    }on ServerException catch(failure){
      return Left(ServerFailure(failure.statusErrorMessageModel.code.toString()));
    }
  }

  @override
  Future<Either<Failure, ForgetPasswordEntities>> getPassForget(ForgetPassParameter parameter)async {
    final result = await baseUserLoginRemoteDataSource.getForgetPass(parameter);

    try{
      return Right(result);
    }on ServerException catch(failure){
      return Left(ServerFailure(failure.statusErrorMessageModel.code.toString()));
    }
  }

  @override
  Future<Either<Failure, ResetPasswordEntities>> getResetPassword(ResetPasswordParameter parameter)async {
    final result = await baseUserLoginRemoteDataSource.getResetPassword(parameter);

    try{
      return Right(result);
    }on ServerException catch(failure){
      return Left(ServerFailure(failure.statusErrorMessageModel.code.toString()));
    }
  }

}