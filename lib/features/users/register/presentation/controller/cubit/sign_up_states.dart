import 'package:chef/features/users/register/domain/entities/sign_up_entities.dart';

abstract class SignUpStates{}

class InitialSignUpState extends SignUpStates{}

class ChangeSignUpPasswordVisibility extends SignUpStates{}

class SignUpLoadingState extends SignUpStates{}


class SignUpSuccessState extends SignUpStates{
  final SignUpEntities loginEntities;

  SignUpSuccessState(this.loginEntities);
}
class SignUpErrorState extends SignUpStates{
  final String error;

  SignUpErrorState(this.error);
}

class TakeImageFromUser extends SignUpStates{}