import 'dart:io';
import 'dart:typed_data';

import 'package:chef/core/resources/assets_manager.dart';
import 'package:chef/core/resources/color_manager.dart';
import 'package:chef/core/resources/strings_manager.dart';
import 'package:chef/core/resources/values_manager.dart';
import 'package:chef/core/service/service_locator.dart';
import 'package:chef/core/utils/commons.dart';
import 'package:chef/core/widgets/my_button.dart';
import 'package:chef/core/widgets/my_form_field.dart';
import 'package:chef/core/widgets/toast_state.dart';
import 'package:chef/features/users/register/presentation/controller/cubit/sign_up_cubit.dart';
import 'package:chef/features/users/register/presentation/controller/cubit/sign_up_states.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gutter/flutter_gutter.dart';
import 'package:image_picker/image_picker.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => sl<SignupCubit>(),
      child: BlocConsumer<SignupCubit, SignUpStates>(
        listener: (context, state) {
          if (state is SignUpSuccessState) {
            showToast(
              text: state.loginEntities.message.toString(),
              state: ToastState.success,
            );
          }
          if(state is SignUpErrorState){
            showToast(
              text: state.error,
              state: ToastState.error,
            );
          }
        },
        builder: (context, state) {
          var cubit = SignupCubit.get(context);
          // var profileImage = SignupCubit.get(context).image.toString();
          // var frontId = SignupCubit.get(context).frontId.toString();
          // var backId = SignupCubit.get(context).backId.toString();
          return Scaffold(
            appBar: AppBar(
              leading: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(
                  Icons.arrow_back_ios,
                  color: ColorManager.sWhite,
                ),
              ),
              backgroundColor: ColorManager.orange,
            ),
            body: Padding(
              padding: const EdgeInsets.all(
                AppPadding.p20,
              ),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Row(
                      children: [
                        Stack(
                          alignment: AlignmentDirectional.bottomEnd,
                          children: [
                            CircleAvatar(
                              radius: AppSize.s70,
                              backgroundImage: cubit.image != null
                                  ? FileImage(File(cubit.image!.path))
                                  : const AssetImage(
                                      ImageAssets.chef,
                                    ) as ImageProvider,
                            ),
                            IconButton(
                              onPressed: () {
                                pickImage(ImageSource.gallery).then(
                                  (value) {
                                    cubit.takeImage(value);
                                  },
                                );
                              },
                              icon: const CircleAvatar(
                                backgroundColor: ColorManager.bTwitter,
                                radius: AppSize.s15,
                                child: Icon(
                                  Icons.camera_alt_outlined,
                                  color: ColorManager.sWhite,
                                  size: AppSize.s15,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const GutterLarge(),
                        // Stack(
                        //   alignment: AlignmentDirectional.bottomEnd,
                        //   children: [
                        //     CircleAvatar(
                        //       radius: AppSize.s30,
                        //       backgroundImage: frontId != null
                        //           ? FileImage(File(frontId.path))
                        //           : const AssetImage(
                        //               ImageAssets.lock,
                        //             ) as ImageProvider,
                        //     ),
                        //     IconButton(
                        //       onPressed: () {
                        //         pickImage(ImageSource.camera).then(
                        //           (value) {
                        //             cubit.takeImage(value);
                        //           },
                        //         );
                        //       },
                        //       icon: const CircleAvatar(
                        //         backgroundColor: ColorManager.bTwitter,
                        //         radius: AppSize.s15,
                        //         child: Icon(
                        //           Icons.camera_alt_outlined,
                        //           color: ColorManager.sWhite,
                        //           size: AppSize.s15,
                        //         ),
                        //       ),
                        //     ),
                        //   ],
                        // ),
                        // const GutterLarge(),
                        // Stack(
                        //   alignment: AlignmentDirectional.bottomEnd,
                        //   children: [
                        //     CircleAvatar(
                        //       radius: AppSize.s30,
                        //       backgroundImage: backId != null
                        //           ? FileImage(File(backId.path))
                        //           : const AssetImage(
                        //               ImageAssets.backgroundTwo,
                        //             ) as ImageProvider,
                        //     ),
                        //     IconButton(
                        //       onPressed: () {
                        //         pickImage(ImageSource.gallery).then(
                        //           (value) {
                        //             cubit.takeImage(value);
                        //           },
                        //         );
                        //       },
                        //       icon: const CircleAvatar(
                        //         backgroundColor: ColorManager.bTwitter,
                        //         radius: AppSize.s15,
                        //         child: Icon(
                        //           Icons.camera_alt_outlined,
                        //           color: ColorManager.sWhite,
                        //           size: AppSize.s15,
                        //         ),
                        //       ),
                        //     ),
                        //   ],
                        // ),
                      ],
                    ),
                    const GutterLarge(),
                    MyFormField(
                      controller: cubit.nameController,
                      type: TextInputType.text,
                      label: AppStrings.name,
                      prefix: Icons.person,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return AppStrings.enterURName;
                        }
                        return null;
                      },
                    ),
                    const GutterLarge(),
                    MyFormField(
                      controller: cubit.emailController,
                      type: TextInputType.emailAddress,
                      label: AppStrings.email,
                      prefix: Icons.email_outlined,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return AppStrings.enterUREmail;
                        }
                        return null;
                      },
                    ),
                    const GutterLarge(),
                    MyFormField(
                      controller: cubit.phoneController,
                      type: TextInputType.phone,
                      label: AppStrings.phone,
                      prefix: Icons.phone_android_outlined,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return AppStrings.phone;
                        }
                        return null;
                      },
                    ),
                    const GutterLarge(),
                    MyFormField(
                      controller: cubit.passwordController,
                      type: TextInputType.visiblePassword,
                      label: AppStrings.password,
                      prefix: Icons.lock_outline,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return AppStrings.enterURPassword;
                        }
                        return null;
                      },
                    ),
                    const GutterLarge(),
                    MyFormField(
                      controller: cubit.confirmPasswordController,
                      type: TextInputType.visiblePassword,
                      label: AppStrings.confirmPassword,
                      prefix: Icons.lock_outline,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return AppStrings.password;
                        }
                        return null;
                      },
                    ),
                    const GutterLarge(),
                    MyFormField(
                      controller: cubit.discController,
                      type: TextInputType.text,
                      label: 'desc',
                      prefix: Icons.description,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return AppStrings.password;
                        }
                        return null;
                      },
                    ),
                    const GutterLarge(),
                    MyFormField(
                      controller: cubit.brandNameController,
                      type: TextInputType.text,
                      label: 'brandName',
                      prefix: Icons.branding_watermark,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return AppStrings.password;
                        }
                        return null;
                      },
                    ),
                    const GutterLarge(),
                    MyFormField(
                      controller: cubit.valueController,
                      type: TextInputType.number,
                      label: 'value',
                      prefix: Icons.numbers,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return AppStrings.password;
                        }
                        return null;
                      },
                    ),
                    const GutterLarge(),
                    MyFormField(
                      controller: cubit.locationController,
                      type: TextInputType.streetAddress,
                      label: 'location',
                      prefix: Icons.location_city,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return AppStrings.password;
                        }
                        return null;
                      },
                    ),
                    const GutterLarge(),
                    ConditionalBuilder(
                      condition: state is! SignUpLoadingState,
                      builder: (context) => MyButton(
                        onPressedTextButton: () {
                          cubit.getSignUpUser(
                            name: cubit.nameController.text,
                            phone: cubit.phoneController.text,
                            email: cubit.emailController.text,
                            password: cubit.passwordController.text,
                            confirmPassword: cubit.confirmPasswordController.text,
                            brandName: cubit.brandNameController.text,
                            // frontId: cubit.frontId!,
                            // backId: cubit.backId!,
                            profilePic: cubit.image!,
                            minCharge: cubit.valueController.hashCode,
                            location: '30.528406',
                            disc: cubit.discController.text,
                          );
                        },
                        text: AppStrings.register,
                        style: Theme.of(context).textTheme.titleLarge!.copyWith(
                              color: ColorManager.sWhite,
                            ),
                      ),
                      fallback: (context) => const Center(
                        child: CircularProgressIndicator(),
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
