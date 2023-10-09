import 'package:chef/core/observer/observer.dart';
import 'package:chef/core/resources/theme_manager.dart';
import 'package:chef/core/service/service_locator.dart';
import 'package:chef/features/splash/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await ServiceLocator().init();
  Bloc.observer = MyBlocObserver();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: getApplicationLightTheme(),
      home: const SplashScreen(),
    );
  }
}

