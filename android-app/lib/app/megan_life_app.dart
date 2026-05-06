import 'package:flutter/material.dart';
import '../screens/home_screen.dart';
import '../screens/permissions_screen.dart';
import '../screens/settings_screen.dart';
import '../screens/chat_screen.dart';
import '../ui/theme/app_theme.dart';
import 'app_routes.dart';

class MeganLifeApp extends StatelessWidget {
  const MeganLifeApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Megan Life',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.dark(),
      initialRoute: AppRoutes.home,
      routes: {
        AppRoutes.home: (_) => const HomeScreen(),
        AppRoutes.chat: (_) => const ChatScreen(),
        AppRoutes.permissions: (_) => const PermissionsScreen(),
        AppRoutes.settings: (_) => const SettingsScreen(),
      },
    );
  }
}
