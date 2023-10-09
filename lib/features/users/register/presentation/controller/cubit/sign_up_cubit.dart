import 'package:bloc/bloc.dart';
import 'package:chef/features/users/register/domain/entities/sign_up_entities.dart';
import 'package:chef/features/users/register/domain/repository/base_sign_up_repository.dart';
import 'package:chef/features/users/register/domain/usecase/get_sign_up_use_case.dart';
import 'package:chef/features/users/register/presentation/controller/cubit/sign_up_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

class SignupCubit extends Cubit<SignUpStates> {
  SignupCubit(
    this.getSignUpUseCase,
  ) : super(InitialSignUpState());
  final GetSignUpUseCase getSignUpUseCase;
  SignUpEntities? signUpEntities;
  static SignupCubit get(context) => BlocProvider.of(context);

  bool isPassword = true;
  IconData suffix = Icons.visibility_outlined;
  var nameController = TextEditingController();
  var phoneController = TextEditingController();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var confirmPasswordController = TextEditingController();
  var locationController = TextEditingController();
  var brandNameController = TextEditingController();
  var discController = TextEditingController();
  var valueController = TextEditingController();


  var formKey = GlobalKey<FormState>();

  void changeLoginPasswordVisibility() {
    isPassword = !isPassword;
    suffix =
        isPassword ? Icons.visibility_outlined : Icons.visibility_off_outlined;
    emit(ChangeSignUpPasswordVisibility());
  }

  XFile? image;
  XFile? frontId;
  XFile? backId;
  void getSignUpUser({
    required String name,
    required String phone,
    required String email,
    required String password,
    required String confirmPassword,
    required XFile profilePic,
    // required XFile frontId,
    // required XFile backId,
    required String brandName,
    required String disc,
    required String location,
    required int minCharge,
}) async {
    emit(SignUpLoadingState());

    final result = await getSignUpUseCase(
      SignUpParameter(
        name: name,
        phone: phone,
        email: email,
        password: password,
        confirmPassword: confirmPassword,
        profilePic: profilePic,
        // frontId: frontId,
        // backId: backId,
        brandName: brandName,
        disc: disc,
        location: location,
        minCharge: minCharge,
      ),
    );
    result.fold(
      (l) {
        emit(SignUpErrorState(l.message));
      },
      (r) {
        signUpEntities = r;
        emit(SignUpSuccessState(r));
      },
    );
  }
  void takeImage(value){
    image = value;
    emit(TakeImageFromUser());
  }
}
