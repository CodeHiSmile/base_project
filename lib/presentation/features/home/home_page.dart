import 'package:base_project/navigation/app_navigator.dart';
import 'package:base_project/navigation/routers/router_paths.dart';
import 'package:base_project/presentation/bottom_sheets/app_bottom_sheet.dart';
import 'package:base_project/presentation/dialogs/app_dialog.dart';
import 'package:base_project/presentation/widgets/button/primary_button.dart';
import 'package:flutter/material.dart';
import 'package:base_ui/base_ui.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:router/router.dart';
import './bloc/bloc.dart';
import 'package:get_it/get_it.dart';

class HomeArguments {
  const HomeArguments();
}

class HomePage extends StatefulWidget {
  final HomeArguments? arguments;

  const HomePage({super.key, this.arguments});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends BasePageState<HomePage, HomeBloc> {
  bool isFavorite = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget buildPage(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("HomePage")),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "Home Page",
              style: context.textStyles.normal.copyWith(
                color: Colors.orange,
                fontSize: 20,
              ),
            ),
            SizedBox(height: 20),
            PrimaryButton(text: "TEst me", onTap: () async {}, width: 300),
            SizedBox(height: 20),
            PrimaryButton.outline(
              text: "TEst me2",
              onTap: () async {},
              width: 200,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                final data = await AppNavigator.push(RouterPaths.productList);

                if (data == true) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Quay về từ DS Sản phẩm với kết quả TRUE'),
                    ),
                  );
                }
              },
              child: Text('Xem DS Sản phẩm'),
            ),
            SizedBox(height: 20),
            InkWellWidget(
              onTap: () async {
                //check login
                final authService = GetIt.instance.get<AuthService>();

                authService.runAfterLogin(
                  action: () {
                    setState(() {
                      isFavorite = !isFavorite;
                    });
                  },
                );
              },
              child: Icon(
                Icons.favorite,
                color: isFavorite ? Colors.red : Colors.grey,
              ),
            ),
            SizedBox(height: 20),
            InkWellWidget(
              onTap: () async {
                AppBottomSheet.show(
                  context,
                  options: BottomSheetOptions(title: "Test"),
                );
              },
              child: Icon(Icons.menu, color: Colors.grey),
            ),
            SizedBox(height: 20),
            InkWellWidget(
              onTap: () async {
                AppBottomSheet.show(
                  AppNavigator.currentContext!,
                  options: BottomSheetOptions(title: "Test"),
                );
              },
              child: Icon(
                Icons.eighteen_up_rating_outlined,
                color: Colors.grey,
              ),
            ),
            SizedBox(height: 20),
            InkWellWidget(
              onTap: () async {
                AppDialog.showInfoDialog(
                  context,
                  title: "Info Dialog",
                  message: "This is an info dialog",
                );
              },
              child: Icon(Icons.safety_check_rounded, color: Colors.grey),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                if (AppNavigator.canPop()) {
                  AppNavigator.pop();
                }
              },
              child: Text('Back'),
            ),
          ],
        ),
      ),
    );
  }
}
