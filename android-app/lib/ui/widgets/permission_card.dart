import 'package:flutter/material.dart';

class PermissionCard extends StatelessWidget {
  const PermissionCard({super.key, required this.title, required this.description});

  final String title;
  final String description;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: const Icon(Icons.verified_user_outlined),
        title: Text(title),
        subtitle: Text(description),
      ),
    );
  }
}
