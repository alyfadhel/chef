import 'package:chef/core/resources/assets_manager.dart';
import 'package:chef/core/resources/color_manager.dart';
import 'package:chef/core/resources/strings_manager.dart';
import 'package:chef/core/resources/values_manager.dart';
import 'package:chef/core/service/service_locator.dart';
import 'package:chef/core/widgets/my_button.dart';
import 'package:chef/core/widgets/my_form_field.dart';
import 'package:chef/core/widgets/my_text_button.dart';
import 'package:chef/core/widgets/toast_state.dart';
import 'package:chef/features/users/login/presentation/controller/cubit/login_cubit.dart';
import 'package:chef/features/users/login/presentation/controller/cubit/login_states.dart';
import 'package:chef/features/users/login/presentation/screens/forget_pass_screen.dart';
import 'package:chef/features/users/register/presentation/screens/sign_up_screen.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => sl<LoginCubit>(),
      child: BlocConsumer<LoginCubit, LoginStates>(
        listener: (context, state) {
          if (state is LoginSuccessState) {
            showToast(
              text: state.loginEntities.message!,
              state: ToastState.success,
            );
          }
          if (state is LoginErrorState) {
            showToast(
              text: state.error,
              state: ToastState.error,
            );
          }
        },
        builder: (context, state) {
          var cubit = LoginCubit.get(context);
          return Scaffold(
            body: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Stack(
                    alignment: AlignmentDirectional.center,
                    children: [
                      Image.asset(
                        width: double.infinity,
                        fit: BoxFit.cover,
                        ImageAssets.backgroundTwo,
                      ),
                      Text(
                        'Welcome Back',
                        style:
                            Theme.of(context).textTheme.headlineLarge!.copyWith(
                                  color: ColorManager.sWhite,
                                  fontWeight: FontWeight.bold,
                                ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: AppSize.s120,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(
                      AppPadding.p20,
                    ),
                    child: Form(
                      key: cubit.formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
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
                            height: AppSize.s20,
                          ),
                          MyFormField(
                            controller: cubit.passwordController,
                            type: TextInputType.visiblePassword,
                            label: AppStrings.password,
                            prefix: Icons.lock_outline,
                            suffix: cubit.suffix,
                            isPassword: cubit.isPassword,
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
                          MyTextButton(
                            onPressedTextButton: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      const ForgetPasswordScreen(),
                                ),
                              );
                            },
                            text: AppStrings.forgetPassword,
                            isUpperCase: false,
                            style: Theme.of(context)
                                .textTheme
                                .titleSmall!
                                .copyWith(color: ColorManager.grey),
                          ),
                          const SizedBox(
                            height: AppSize.s30,
                          ),
                          ConditionalBuilder(
                            condition: state is! LoginLoadingState,
                            builder: (context) => MyButton(
                              onPressedTextButton: () {
                                if (cubit.formKey.currentState!.validate()) {
                                  cubit.getUserLogin(
                                    email: cubit.emailController.text,
                                    password: cubit.passwordController.text,
                                  );
                                }
                              },
                              text: AppStrings.login,
                              style: Theme.of(context)
                                  .textTheme
                                  .titleLarge!
                                  .copyWith(color: ColorManager.sWhite),
                            ),
                            fallback: (context) => const Center(
                              child: CircularProgressIndicator(),
                            ),
                          ),
                          const SizedBox(
                            height: AppSize.s50,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                AppStrings.haveNoAccount,
                                style: Theme.of(context)
                                    .textTheme
                                    .titleMedium!
                                    .copyWith(color: ColorManager.grey),
                              ),
                              MyTextButton(
                                onPressedTextButton: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          const SignUpScreen(),
                                    ),
                                  );
                                },
                                text: AppStrings.register,
                                isUpperCase: false,
                                style: Theme.of(context)
                                    .textTheme
                                    .titleLarge!
                                    .copyWith(
                                      color: ColorManager.orange,
                                    ),
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
