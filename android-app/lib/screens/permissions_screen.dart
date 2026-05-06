import 'package:flutter/material.dart';
import '../core/services/permissions/permission_service.dart';
import '../ui/widgets/permission_card.dart';

class PermissionsScreen extends StatelessWidget {
  const PermissionsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final service = PermissionService();
    return Scaffold(
      appBar: AppBar(title: const Text('Permissões')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const PermissionCard(title: 'Microfone', description: 'Necessário para ouvir comandos de voz.'),
          const PermissionCard(title: 'Notificações', description: 'Necessário para ler mensagens recebidas.'),
          const PermissionCard(title: 'Acessibilidade', description: 'Necessário para ações avançadas no Android.'),
          const SizedBox(height: 20),
          FilledButton(
            onPressed: service.requestCorePermissions,
            child: const Text('Solicitar permissões principais'),
          ),
        ],
      ),
    );
  }
}
