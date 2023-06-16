import 'package:flutter/material.dart';
import 'package:ideal_atm/core/constants/app_colors.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:ideal_atm/main/business/models/qr/qr_model.dart';
import 'package:ideal_atm/main/presentation/widgets/app_widgets/app_bar.dart';

import 'package:qr_code_scanner/qr_code_scanner.dart';

class QrScreen extends StatefulWidget {
  const QrScreen({super.key, this.onSuccess});

  final void Function(QrModel model)? onSuccess;

  @override
  State<QrScreen> createState() => _QrScreenState();
}

class _QrScreenState extends State<QrScreen> {
  final GlobalKey _qrKey = GlobalKey(debugLabel: 'QR');

  QRViewController? _qrViewController;

  void stopCamera() async => await _qrViewController?.stopCamera();

  void resumeCamera() async {
    await _qrViewController?.resumeCamera();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.black,
      appBar: CustomAppBar(
        titleWidget: Text(
          AppLocalizations.of(context).scan_qr,
          style: TextStyle(color: Theme.of(context).colorScheme.inversePrimary),
        ),
      ),
      body: QRView(
        key: _qrKey,
        onQRViewCreated: (QRViewController) {
          resumeCamera();
          QRViewController.scannedDataStream.listen(
            (event) {
              stopCamera();
            },
          );
        },
        overlay: QrScannerOverlayShape(
          borderColor: Colors.white,
          borderRadius: 0,
          borderLength: 70,
          borderWidth: 5,
          cutOutSize: 250,
        ),
      ),
    );
  }
}
