import 'package:base_project/navigation/middleware/router_service.dart';
import 'package:flutter/material.dart';

class ProfileArguments {
  final String userId;

  ProfileArguments({required this.userId});
}

class ProfilePage extends StatefulWidget {
  final ProfileArguments arguments;

  const ProfilePage({super.key, required this.arguments});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("ProfilePage")),
      body: Center(child: Column(
        children: [
          Text("User ID: ${widget.arguments.userId}"),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              // Sử dụng GlobalKey để pop
              RouterService.pop();
            },
            child: Text('Back (sử dụng GlobalKey)'),
          ),
        ],
      )),
    );
  }
}
