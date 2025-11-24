import 'package:base_project/navigation/middleware/router_service.dart';
import 'package:base_project/navigation/routers/router_paths.dart';
import 'package:flutter/material.dart';
import 'package:base_ui/base_ui.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import './bloc/bloc.dart';

class ProductListArguments {
  const ProductListArguments();
}

class ProductListPage extends StatefulWidget {
  final ProductListArguments? arguments;

  const ProductListPage({super.key, this.arguments});

  @override
  State<ProductListPage> createState() => _ProductListPageState();
}

class _ProductListPageState
    extends BasePageState<ProductListPage, ProductListBloc> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget buildPage(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("ProductPage")),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "Danh sách Sản phẩm",
              style: context.textStyles.title.copyWith(
                color: Colors.orange,
                fontSize: 20,
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                RouterService.pushTo(RouterPaths.productDetail);
              },
              child: Text('Xem Chi tiết Sản phẩm'),
            ),
          ],
        ),
      ),
    );
  }
}
