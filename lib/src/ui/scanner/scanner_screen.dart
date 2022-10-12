import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qr_tickets/src/ui/scanner/providers/scanned_code.dart';
import 'package:qr_tickets/src/ui/scanner/result_page.dart';
import 'package:qr_tickets/src/ui/scanner/widgets/qr_camera_view.dart';

class ScannerScreen extends StatelessWidget {
  const ScannerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: _ScannerPages(),
    );
  }
}

class _ScannerPages extends StatelessWidget {
  const _ScannerPages();
  @override
  Widget build(BuildContext context) {
    final controller = PageController();
    return Provider(
      create: (_) => ScannedCodePrivider(),
      child: PageView(
        scrollDirection: Axis.vertical,
        controller: controller,
        children: [
          Provider(
            create: (context) => ResultPagePrivider(_nextpage(controller)),
            child: const QRCameraView(),
          ),
          const QrResultPage(),
        ],
      ),
    );
  }

  Function() _nextpage(PageController controller) {
    return () {
      controller.nextPage(duration: const Duration(milliseconds: 500), curve: Curves.easeInExpo);
    };
  }
}
