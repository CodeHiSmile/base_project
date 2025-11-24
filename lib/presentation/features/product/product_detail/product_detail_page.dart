import 'package:base_project/navigation/middleware/router_service.dart';
import 'package:base_project/navigation/routers/router_paths.dart';
import 'package:base_project/presentation/features/create_order/create_order_page.dart';
import 'package:flutter/material.dart';
import 'package:base_ui/base_ui.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import './bloc/bloc.dart';

class ProductDetailArguments {
  const ProductDetailArguments();
}

class ProductDetailPage extends StatefulWidget {
  final ProductDetailArguments? arguments;

  const ProductDetailPage({super.key, this.arguments});

  @override
  State<ProductDetailPage> createState() => _ProductDetailPageState();
}

class _ProductDetailPageState
    extends BasePageState<ProductDetailPage, ProductDetailBloc> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget buildPage(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Detail product Page")),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "Chi tiết Sản phẩm",
              style: context.textStyles.title.copyWith(
                color: Colors.orange,
                fontSize: 20,
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                RouterService.pushTo(
                  RouterPaths.createOrder,
                  extra: CreateOrderArguments(),
                );
              },
              child: Text('Đặt hàng'),
            ),
          ],
        ),
      ),
    );
  }
}
