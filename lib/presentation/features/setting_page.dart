import 'package:base_project/navigation/middleware/router_service.dart';
import 'package:base_project/navigation/routers/router_paths.dart';
import 'package:flutter/material.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({super.key});

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("SettingPage")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Settings Page'),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Sử dụng GlobalKey để pop
                RouterService.pushTo(RouterPaths.home);
              },
              child: Text('Back (sử dụng GlobalKey)'),
            ),
          ],
        ),
      ),
    );
  }
}
