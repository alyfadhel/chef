import 'package:chef/core/resources/assets_manager.dart';
import 'package:chef/core/resources/color_manager.dart';
import 'package:chef/core/resources/values_manager.dart';
import 'package:chef/features/users/login/presentation/screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

void goToHome(context) async {
  await Future.delayed(
    const Duration(milliseconds: 2000),
    () {
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (context) => const LoginScreen(),
        ),
        (route) => false,
      );
    },
  );
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.orange,
      appBar: AppBar(
        backgroundColor: ColorManager.orange,
        elevation: AppSize.s0,
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarIconBrightness: Brightness.light,
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              ImageAssets.chef,
            )
          ],
        ),
      ),
    );
  }

  @override
  void initState() {
    goToHome(context);
    super.initState();
  }
}
