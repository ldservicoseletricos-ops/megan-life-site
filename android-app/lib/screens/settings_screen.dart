import 'package:flutter/material.dart';
import '../core/config/app_config.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Configurações')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: const [
          ListTile(
            title: Text('Versão'),
            subtitle: Text(AppConfig.appVersion),
          ),
          ListTile(
            title: Text('Backend'),
            subtitle: Text(AppConfig.apiUrl),
          ),
        ],
      ),
    );
  }
}
