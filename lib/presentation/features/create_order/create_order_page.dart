import 'package:base_project/app/app_bloc/app_bloc.dart';
import 'package:base_project/app/app_bloc/app_event.dart';
import 'package:flutter/material.dart';
import 'package:base_ui/base_ui.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:router/router.dart';
import './bloc/bloc.dart';
import 'package:get_it/get_it.dart';

class CreateOrderArguments {
  final String? productId;

  const CreateOrderArguments({this.productId});
}

class CreateOrderPage extends StatefulWidget {
  final CreateOrderArguments? arguments;

  const CreateOrderPage({super.key, this.arguments});

  @override
  State<CreateOrderPage> createState() => _CreateOrderPageState();
}

class _CreateOrderPageState
    extends BasePageState<CreateOrderPage, CreateOrderBloc> {
  final AppBloc appBloc = GetIt.instance.get<AppBloc>();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget buildPage(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Create order Page")),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "Đặt hàng ${widget.arguments?.productId}",
              style: context.textStyles.normal.copyWith(
                color: Colors.orange,
                fontSize: 20,
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                GetIt.instance.get<AppNavigator>().popUntilRoot();
                appBloc.add(ChangeMainPageIndexEvent(pageIndex: 1));
              },
              child: Text('Đặt hàng thành công, về Trang Search'),
            ),
          ],
        ),
      ),
    );
  }
}
