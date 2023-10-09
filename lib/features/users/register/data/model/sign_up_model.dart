import 'package:chef/features/users/register/domain/entities/sign_up_entities.dart';

class SignUpModel extends SignUpEntities
{
  const SignUpModel({required super.message});

  factory SignUpModel.fromJson(Map<String,dynamic>json)
  {
    return SignUpModel(message: json['message'],);
  }

}