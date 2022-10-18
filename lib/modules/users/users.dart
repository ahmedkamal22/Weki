import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher_string.dart';
import 'package:weki/shared/components/components.dart';

class UsersScreen extends StatelessWidget {
  UsersScreen({Key? key}) : super(key: key);
  var phoneController = TextEditingController();
  final number = "+201008928356";

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          defaultButton(
              onPressed: () async {
                launchUrlString("tel://$number");
              },
              text: "Make call",
              radius: 20),
        ],
      ),
    );
  }
}
