import 'package:flutter/material.dart';
import 'package:weki/shared/components/components.dart';

class PostsScreen extends StatelessWidget {
  const PostsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: defaultAppBar(
        context: context,
        title: "Add Post",
      ),
    );
  }
}
