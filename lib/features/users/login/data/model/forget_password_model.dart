import 'package:chef/features/users/login/domain/entities/forget_pass_entities.dart';

class ForgetPasswordModel extends ForgetPasswordEntities {
  const ForgetPasswordModel({
    required super.message,
  });
  factory ForgetPasswordModel.fromJson(Map<String,dynamic>json)
  {
    return ForgetPasswordModel(message: json['message']);
  }
}
