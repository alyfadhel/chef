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
import 'package:chef/features/users/login/presentation/screens/reset_password_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ForgetPasswordScreen extends StatelessWidget {
  const ForgetPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => sl<LoginCubit>(),
      child: BlocConsumer<LoginCubit, LoginStates>(
        listener: (context, state) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const ResetPasswordScreen(),
            ),
          );
          if (state is ForgetPasswordSuccessState) {
            showToast(
              text: state.forgetPasswordEntities.message!,
              state: ToastState.success,
            );
          }
          if (state is ForgetPasswordErrorState) {
            showToast(
              text: state.error,
              state: ToastState.error,
            );
          }
        },
        builder: (context, state) {
          var cubit = LoginCubit.get(context);
          return Scaffold(
            appBar: AppBar(
              title: Text(
                AppStrings.forgetPasswordTitle,
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
                    children: [
                      Image.asset(
                        ImageAssets.lock,
                      ),
                      const SizedBox(
                        height: AppSize.s30,
                      ),
                      Text(
                        AppStrings.paragraph,
                        style: Theme.of(context).textTheme.titleSmall,
                      ),
                      const SizedBox(
                        height: AppSize.s40,
                      ),
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
                      const SizedBox(
                        height: AppSize.s40,
                      ),
                      MyButton(
                        onPressedTextButton: () {
                          cubit.forgetPassword(
                            email: cubit.emailController.text,
                          );
                        },
                        text: AppStrings.sendCode,
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
