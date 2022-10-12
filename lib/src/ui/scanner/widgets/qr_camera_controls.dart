import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qr_tickets/routes.dart';
import 'package:qr_tickets/src/ui/scanner/providers/camera_provider.dart';
import 'package:qr_tickets/src/ui/widgets/confirm_dialog.dart';
import 'package:qr_tickets/storage_application.dart';

class QRCameraControls extends StatelessWidget {
  final String? qrcontent;
  const QRCameraControls({this.qrcontent, super.key});
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GestureDetector(
              onTap: () => showDialog(
                context: context,
                builder: ((context) => ConfirmDialog(
                      'Está seguro de serrar sesión?',
                      onTabOK: () {
                        StorageApplication().token = '';
                        Navigator.pushReplacementNamed(context, Routes.loggin);
                      },
                    )),
              ),
              child: const Icon(Icons.logout_rounded, color: Colors.white),
            ),
            Expanded(
              child: Center(
                child: SizedBox(
                  width: size.width * 0.7,
                  child: Text(
                    qrcontent ?? '',
                    style: const TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
            const _FlashToggleButton(),
          ],
        ),
      ),
    );
  }
}

class _FlashToggleButton extends StatelessWidget {
  const _FlashToggleButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final camera = Provider.of<CameraStatePrivider>(context);
    return Align(
      alignment: Alignment.centerRight,
      child: GestureDetector(
        onTap: () {
          camera.toggle();
        },
        child: Icon(
          camera.flashState ? Icons.flash_on_outlined : Icons.flash_off_outlined,
          color: Colors.white,
        ),
      ),
    );
  }
}
