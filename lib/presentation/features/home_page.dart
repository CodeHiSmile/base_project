import 'package:base_project/navigation/middleware/router_service.dart';
import 'package:base_project/navigation/routers/router_paths.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Home Page")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Home Page'),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Sử dụng GlobalKey để pop
                RouterService.pushTo(RouterPaths.login);
              },
              child: Text('Back (sử dụng GlobalKey)'),
            ),
          ],
        ),
      ),
    );
  }
}
