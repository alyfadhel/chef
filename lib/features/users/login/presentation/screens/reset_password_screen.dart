import 'package:chef/core/resources/assets_manager.dart';
import 'package:chef/core/resources/color_manager.dart';
import 'package:chef/core/resources/strings_manager.dart';
import 'package:chef/core/resources/values_manager.dart';
import 'package:chef/core/service/service_locator.dart';
import 'package:chef/core/widgets/my_button.dart';
import 'package:chef/core/widgets/my_form_field.dart';
import 'package:chef/core/widgets/toast_state.dart';
import 'package:chef/features/users/login/presentation/controller/cubit/login_cubit.dart';
import 'package:chef/features/users/login/presentation/controller/cubit/login_states.dart';
import 'package:chef/features/users/login/presentation/screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ResetPasswordScreen extends StatelessWidget {
  const ResetPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => sl<LoginCubit>(),
      child: BlocConsumer<LoginCubit, LoginStates>(
        listener: (context, state) {
          if (state is ResetPasswordSuccessState) {
            showToast(
              text: state.resetPasswordEntities.message!,
              state: ToastState.success,
            );
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                builder: (context) => const LoginScreen(),
              ),
              (route) => false,
            );
          }
        },
        builder: (context, state) {
          var cubit = LoginCubit.get(context);
          return Scaffold(
            appBar: AppBar(
              title: Text(
                AppStrings.createNewPassword,
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      color: ColorManager.sWhite,
                    ),
              ),
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
                AppPadding.p40,
              ),
              child: Center(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Image.asset(
                        ImageAssets.lock,
                      ),
                      const SizedBox(
                        height: AppSize.s30,
                      ),
                      Text(
                        AppStrings.createNewPassword,
                        style: Theme.of(context).textTheme.titleSmall,
                      ),
                      const SizedBox(
                        height: AppSize.s10,
                      ),
                      MyFormField(
                        controller: cubit.passwordController,
                        type: TextInputType.visiblePassword,
                        label: AppStrings.password,
                        prefix: Icons.lock_outline,
                        isPassword: cubit.isPassword,
                        suffix: cubit.suffix,
                        onPressed: () {
                          cubit.changeLoginPasswordVisibility();
                        },
                        validator: (value) {
                          if (value!.isEmpty) {
                            return AppStrings.enterURPassword;
                          }
                          return null;
                        },
                      ),
                      const SizedBox(
                        height: AppSize.s10,
                      ),
                      MyFormField(
                        controller: cubit.confirmPasswordController,
                        type: TextInputType.visiblePassword,
                        label: AppStrings.confirmPassword,
                        prefix: Icons.lock_outline,
                        isPassword: cubit.isPassword,
                        suffix: cubit.suffix,
                        onPressed: () {
                          cubit.changeLoginPasswordVisibility();
                        },
                        validator: (value) {
                          if (value!.isEmpty) {
                            return AppStrings.enterURPassword;
                          }
                          return null;
                        },
                      ),
                      const SizedBox(
                        height: AppSize.s10,
                      ),
                      MyFormField(
                        controller: cubit.code,
                        type: TextInputType.number,
                        label: AppStrings.code,
                        prefix: Icons.numbers,
                        isPassword: cubit.isPassword,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return AppStrings.enterURPassword;
                          }
                          return null;
                        },
                      ),
                      const SizedBox(
                        height: AppSize.s40,
                      ),
                      MyButton(
                        onPressedTextButton: () {
                          cubit.getResetPassword(
                            email: cubit.emailController.text,
                            password: cubit.passwordController.text,
                            confirmPassword:
                                cubit.confirmPasswordController.text,
                            code: cubit.code.text,
                          );
                        },
                        text: AppStrings.resetPassword,
                        style: Theme.of(context)
                            .textTheme
                            .titleLarge!
                            .copyWith(color: ColorManager.sWhite),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
