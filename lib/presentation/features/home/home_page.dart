import 'package:base_project/navigation/routers/router_paths.dart';
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
            ElevatedButton(
              onPressed: () {
                GetIt.instance.get<AppNavigator>().pushTo(
                  RouterPaths.productList,
                );
              },
              child: Text('Xem DS Sản phẩm'),
            ),
          ],
        ),
      ),
    );
  }
}
