import 'dart:async';

import 'package:flutter/material.dart';
import 'package:base_ui/base_ui.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:router/router.dart';
import './bloc/bloc.dart';
import 'package:get_it/get_it.dart';

class LoginArguments {
  const LoginArguments();
}

class LoginPage extends StatefulWidget {
  final LoginArguments? arguments;

  const LoginPage({super.key, this.arguments});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends BasePageState<LoginPage, LoginBloc> {
  final authService = GetIt.instance.get<AuthService>();

  @override
  void initState() {
    super.initState();
  }

  void onLogin(Function onSuccess) async {
    final Completer completer = Completer();
    bloc.add(
      OnLoginEvent(completer: completer, account: 'user', password: 'password'),
    );
    final result = await completer.future;

    if (result == true) {
      onSuccess.call();
      final authService = GetIt.instance.get<AuthService>();
      authService.restoreRoute(canPushToPage: false);
    }
  }

  @override
  Widget buildPage(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("LoginPage")),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "Login Page",
              style: context.textStyles.normal.copyWith(
                color: Colors.orange,
                fontSize: 20,
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                onLogin(() {
                  authService.restoreRoute();
                });
              },
              child: Text('Login'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                onLogin(() {
                  authService.restoreRoute(canPushToPage: false);
                });
              },
              child: Text('Login 2'),
            ),
          ],
        ),
      ),
    );
  }
}
