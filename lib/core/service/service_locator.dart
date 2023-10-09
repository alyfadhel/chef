import 'package:chef/core/network/dio_helper.dart';
import 'package:chef/features/users/login/data/data_source/base_user_login_remote_data_source.dart';
import 'package:chef/features/users/login/data/repository/login_repository.dart';
import 'package:chef/features/users/login/domain/repository/base_login_repository.dart';
import 'package:chef/features/users/login/domain/usecase/get_forget_password_use_case.dart';
import 'package:chef/features/users/login/domain/usecase/get_reset_password_use_case.dart';
import 'package:chef/features/users/login/domain/usecase/get_user_login_use_case.dart';
import 'package:chef/features/users/login/presentation/controller/cubit/login_cubit.dart';
import 'package:chef/features/users/register/data/data_source/base_sign_up_remote_data_source.dart';
import 'package:chef/features/users/register/data/repository/sign_up_repository.dart';
import 'package:chef/features/users/register/domain/repository/base_sign_up_repository.dart';
import 'package:chef/features/users/register/domain/usecase/get_sign_up_use_case.dart';
import 'package:chef/features/users/register/presentation/controller/cubit/sign_up_cubit.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

final sl = GetIt.instance;

class ServiceLocator {
  Future<void> init() async {
    sl.registerFactory(() => SignupCubit(
      sl(),),
    );
    sl.registerLazySingleton(() => GetSignUpUseCase(sl()));
    sl.registerLazySingleton<BaseSignUpRepository>(() => SignUpRepository(sl()));
    sl.registerLazySingleton<BaseSignUpRemoteDataSource>(
            () => SignUpRemoteDataSource(sl()));
    /////////////////////////////////////////////////////////////////
    sl.registerFactory(() => LoginCubit(
          sl(),
          sl(),
          sl(),
        ),
    );
    sl.registerLazySingleton(() => GetResetPasswordUseCase(sl()));
    sl.registerLazySingleton(() => GetForgetPasswordUseCase(sl()));
    sl.registerLazySingleton(() => GetUserLoginUseCase(sl()));
    sl.registerLazySingleton<BaseLoginRepository>(() => LoginRepository(sl()));
    sl.registerLazySingleton<BaseUserLoginRemoteDataSource>(
        () => UserLoginRemoteDataSource(sl()));
    /////////////////////////////////////////////////////////
    sl.registerLazySingleton<DioHelper>(
      () => DioHelperImpl(),
    );

    final sharedPreferences = await SharedPreferences.getInstance();
    sl.registerLazySingleton<SharedPreferences>(
      () => sharedPreferences,
    );
  }
}
