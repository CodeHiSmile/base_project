import 'package:base_project/navigation/app_navigator.dart';
import 'package:base_project/navigation/routers/router_paths.dart';
import 'package:base_project/presentation/dialogs/app_dialog.dart';
import 'package:flutter/material.dart';
import 'package:base_ui/base_ui.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:router/router.dart';
import './bloc/bloc.dart';

class ProfileArguments {
  const ProfileArguments();
}

class ProfilePage extends StatefulWidget {
  final ProfileArguments? arguments;

  const ProfilePage({super.key, this.arguments});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends BasePageState<ProfilePage, ProfileBloc> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget buildPage(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Profile Page")),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ElevatedButton(
              onPressed: () async {
                await AppNavigator.push(RouterPaths.login);
                setState(() {});
              },
              child: Text('Đăng nhập'),
            ),
            SizedBox(height: 20),
            Visibility(
              visible: GetIt.instance.get<AuthService>().isLoggedIn,
              child: ElevatedButton(
                onPressed: () {
                  AppDialog.showConfirmDialog(
                    context,
                    message: "Bạn có chắc chắn muốn đăng xuất không?",
                    onConfirm: () {
                      setState(() {
                        final authService = GetIt.instance.get<AuthService>();
                        authService.logout();
                      });
                    },
                  );
                },
                child: Text('Đăng xuất'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
