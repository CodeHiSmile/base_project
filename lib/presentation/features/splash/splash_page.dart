import 'package:base_project/navigation/middleware/router_service.dart';
import 'package:base_project/navigation/routers/router_paths.dart';
import 'package:flutter/material.dart';
import 'package:base_ui/base_ui.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import './bloc/bloc.dart';

class SplashArguments {
  const SplashArguments();
}

class SplashPage extends StatefulWidget {
  final SplashArguments? arguments;

  const SplashPage({super.key, this.arguments});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends BasePageState<SplashPage, SplashBloc> {
  @override
  void initState() {
    //after 2s navigate to MainPage
    Future.delayed(const Duration(seconds: 2), () {
      RouterService.navigateTo(RouterPaths.main);
    });
    super.initState();
  }

  @override
  Widget buildPage(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "Splash Page",
              style: context.textStyles.title.copyWith(
                color: Colors.orange,
                fontSize: 20,
              ),
            ),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
