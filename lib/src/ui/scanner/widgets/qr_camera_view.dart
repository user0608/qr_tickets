import 'dart:io';
import 'package:provider/provider.dart';
import 'package:qr_tickets/routes.dart';
import 'package:qr_tickets/src/ui/scanner/providers/camera_provider.dart';
import 'package:qr_tickets/src/ui/scanner/providers/scanned_code.dart';
import 'package:uuid/uuid.dart';

import 'package:flutter/material.dart';
import 'package:qr_tickets/src/ui/scanner/widgets/qr_camera_controls.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class QRCameraView extends StatefulWidget {
  const QRCameraView({super.key});

  @override
  State<QRCameraView> createState() => _QRScannerState();
}

class _QRScannerState extends State<QRCameraView> {
  Barcode? result;
  QRViewController? controller;
  String scannedContent = "";
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final qrScannerOverlayShape = QrScannerOverlayShape(
      cutOutSize: size.width * 0.8,
      borderRadius: 10,
      borderColor: Colors.green,
      borderLength: 30,
      borderWidth: 10,
    );
    return SizedBox(
      width: size.width,
      height: size.height,
      child: ChangeNotifierProvider(
        create: (_) => CameraStatePrivider(_toggleFlash),
        child: Stack(
          children: [
            QRView(
              key: qrKey,
              onQRViewCreated: (controller) => _onQRViewCreated(context, controller),
              overlay: qrScannerOverlayShape,
            ),
            QRCameraControls(qrcontent: scannedContent),
          ],
        ),
      ),
    );
  }

  void _onQRViewCreated(BuildContext context, QRViewController controller) async {
    final pageProvider = Provider.of<ResultPagePrivider>(context, listen: false);
    final scanned = Provider.of<ScannedCodePrivider>(context, listen: false);
    setState(() {
      this.controller = controller;
    });
    await controller.resumeCamera();
    controller.scannedDataStream.listen(_scan(pageProvider, scanned));
  }

  Function(Barcode) _scan(ResultPagePrivider page, ScannedCodePrivider scanned) {
    String lastScan = '';
    return (Barcode barcode) {
      if (barcode.code == null) return;
      if (barcode.code == "") return;
      if (lastScan != barcode.code) {
        lastScan = barcode.code!;
        if (barcode.code == '6c4a63ae-610b-4259-ad11-68962802fa2d') {
          Navigator.pushNamed(context, Routes.devsettings);
          return;
        }
        bool result = Uuid.isValidUUID(
          fromString: barcode.code!,
          validationMode: ValidationMode.strictRFC4122,
        );
        if (result) {
          page.resultPage();
          scanned.code = barcode.code!;
          return;
        }
        setState(() {
          scannedContent = barcode.code!;
        });
      }
    };
  }

  Future<bool> _toggleFlash() async {
    if (controller == null) return false;
    await controller!.toggleFlash();
    return await controller!.getFlashStatus() ?? false;
  }

  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid && controller != null) {
      controller!.pauseCamera();
    }
    if (controller != null) {
      controller!.resumeCamera();
    }
  }
}
