import 'package:base_project/app/app_bloc/app_bloc.dart';
import 'package:base_project/navigation/middleware/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Login Page")),
      body: Center(
        child: Column(
          children: [
            ElevatedButton(
              onPressed: () {
                // Sử dụng GlobalKey - không cần context!
                final authService = GetIt.instance.get<AuthService>();
                authService.loginWithManualRestore();
              },
              child: Text('Login'),
            ),
          ],
        ),
      ),
    );
  }
}
