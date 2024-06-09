import 'package:doctor_plus/utils/routes.dart';
import 'package:doctor_plus/screen/page/home/page.home.dart';
import 'package:doctor_plus/screen/page/auth/login/page.login.dart';
import 'package:doctor_plus/screen/page/auth/register/page.register.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Doctor Plus',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      routes: {
        Routes.home: (context) => const HomePage(),
        Routes.login: (context) => const LoginPage(),
        Routes.register: (context) => const RegisterPage(),
      },
      initialRoute: Routes.login,
    );
  }
}
