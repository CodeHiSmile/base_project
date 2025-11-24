import 'package:flutter/material.dart';
import 'package:base_ui/base_ui.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import './bloc/bloc.dart';

class {{name.pascalCase()}}Arguments {
  const {{name.pascalCase()}}Arguments();
}

class {{name.pascalCase()}}Page extends StatefulWidget {
  final {{name.pascalCase()}}Arguments? arguments;

  const {{name.pascalCase()}}Page(
      {super.key, this.arguments});
  @override
  State<{{name.pascalCase()}}Page> createState() => _{{name.pascalCase()}}PageState();
}

class _{{name.pascalCase()}}PageState extends BasePageState<{{name.pascalCase()}}Page, {{name.pascalCase()}}Bloc> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget buildPage(BuildContext context) {
    return Scaffold(
        body: SizedBox(),
        );
  }
}
