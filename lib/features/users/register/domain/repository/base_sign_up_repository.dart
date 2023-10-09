import 'dart:io';

import 'package:chef/core/error/failure.dart';
import 'package:chef/features/users/register/domain/entities/sign_up_entities.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:image_picker/image_picker.dart';

abstract class BaseSignUpRepository {
  Future<Either<Failure, SignUpEntities>> getSignUpUser(
      SignUpParameter parameter);
}

class SignUpParameter extends Equatable {
  final String name;
  final String phone;
  final String email;
  final String password;
  final String confirmPassword;
  final XFile profilePic;
  // final XFile frontId;
  // final XFile backId;
  final String location;
  final String brandName;
  final String disc;
  final int minCharge;

  const SignUpParameter({
    required this.name,
    required this.phone,
    required this.email,
    required this.password,
    required this.confirmPassword,
    required this.profilePic,
    // required this.frontId,
    // required this.backId,
    required this.location,
    required this.brandName,
    required this.disc,
    required this.minCharge,
  });

  @override
  List<Object?> get props => [
        name,
        phone,
        email,
        password,
        confirmPassword,
        profilePic,
        // frontId,
        // backId,
        location,
        brandName,
        disc,
        minCharge,
      ];
}
