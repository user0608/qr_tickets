import 'package:flutter/material.dart';
import 'package:qr_tickets/routes.dart';
import 'package:qr_tickets/src/ui/dev_settings.dart';
import 'package:qr_tickets/storage_application.dart';
import 'package:qr_tickets/src/ui/login_screen.dart';
import 'package:qr_tickets/src/ui/scanner/scanner_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await StorageApplication().init();

  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    final session = StorageApplication();
    return MaterialApp(
      title: "QR Scaner",
      initialRoute: session.token == '' ? Routes.loggin : Routes.scanner,
      routes: {
        Routes.loggin: (_) => const LogginScreen(),
        Routes.scanner: (_) => const ScannerScreen(),
        Routes.devsettings: (_) => const DevSettingsScreen(),
      },
    );
  }
}
