import 'package:base_project/navigation/middleware/router_service.dart';
import 'package:base_project/navigation/routers/router_paths.dart';
import 'package:base_project/presentation/features/profile_page.dart';
import 'package:flutter/material.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // if (RouterService.currentContext != null) {
      //   showDialog(
      //     context: RouterService.currentContext!,
      //     builder: (context) {
      //       return AlertDialog(
      //         title: Text('Welcome'),
      //         content: Text('This is a splash page dialog.'),
      //         actions: [
      //           TextButton(
      //             onPressed: () {
      //               Navigator.of(RouterService.currentContext!).pop();
      //             },
      //             child: Text('Close'),
      //           ),
      //         ],
      //       );
      //     },
      //   );
      // }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Splash Page")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Home Page'),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Sử dụng GoRouter với context
                RouterService.pushTo(RouterPaths.setting);
              },
              child: Text('Go to Settings (với context)'),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                // Sử dụng GlobalKey - không cần context!
                RouterService.pushTo(
                  RouterPaths.profile,
                  extra: ProfileArguments(userId: "45678"),
                );
              },
              child: Text('Go to Profile (không cần context)'),
            ),
          ],
        ),
      ),
    );
  }
}
