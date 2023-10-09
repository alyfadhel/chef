import 'package:chef/core/network/dio_helper.dart';
import 'package:chef/core/network/end_points.dart';
import 'package:chef/core/utils/commons.dart';
import 'package:chef/features/users/register/data/model/sign_up_model.dart';
import 'package:chef/features/users/register/domain/repository/base_sign_up_repository.dart';


abstract class BaseSignUpRemoteDataSource {
  Future<SignUpModel> getSignUpUser(SignUpParameter parameter);
}

class SignUpRemoteDataSource extends BaseSignUpRemoteDataSource {
  final DioHelper dioHelper;

  SignUpRemoteDataSource(this.dioHelper);

  @override
  Future<SignUpModel> getSignUpUser(SignUpParameter parameter) async {
    final response = await dioHelper.post(
      endPoint: registerEndPoint,
      isMultipart: true,
      data: {
        'name' : parameter.name,
        'email' : parameter.email,
        'phone' : parameter.phone,
        'password' : parameter.password,
        'confirmPassword' : parameter.confirmPassword,
        'profilePic' : uploadImageToAPI(parameter.profilePic).toString(),
        'location' : parameter.location,
        'brandName' : parameter.brandName,
        'minCharge' : parameter.minCharge,
        'disc' : parameter.disc,
        // 'frontId' : uploadImageToAPI(parameter.frontId).toString(),
        // 'backId' : uploadImageToAPI(parameter.backId).toString(),
      },
    );
    return SignUpModel.fromJson(response);
  }
}
