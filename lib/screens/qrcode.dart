import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class QrCode extends StatefulWidget {
  const QrCode({Key? key}) : super(key: key);

  @override
  _QrCodeState createState() => _QrCodeState();
}

class _QrCodeState extends State<QrCode> {
  BarcodeCapture? result;
  final MobileScannerController controller = MobileScannerController();

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Camera view for scanning QR code
          MobileScanner(
            controller: controller,
            onDetect: (barcode) {
              setState(() {
                result = barcode;
              });
            },
          ),
          // Overlay at the bottom displaying QR code data
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              padding: const EdgeInsets.symmetric(
                vertical: 12,
                horizontal: 8.0,
              ),
              color: Colors.black.withOpacity(0.5),
              child: Text(
                result != null && result!.barcodes.isNotEmpty
                    ? 'Scanned Data: ${result!.barcodes.first.rawValue}'
                    : 'Scan a QR Code',
                style: const TextStyle(color: Colors.white, fontSize: 18),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          controller.toggleTorch(); // Toggle flashlight on or off
        },
        child: Icon(Icons.flash_on),
      ),
    );
  }
}
