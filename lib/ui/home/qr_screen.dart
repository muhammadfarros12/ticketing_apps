import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:ticketing_apps/core/assets/assets.gen.dart';
import 'package:ticketing_apps/core/extensions/build_context_ext.dart';
import 'package:ticketing_apps/ui/home/model/product_model.dart';
import 'package:ticketing_apps/ui/home/order_detail_screen.dart';

class QrScreen extends StatefulWidget {
  const QrScreen({super.key});

  @override
  State<QrScreen> createState() => _QrScreenState();
}

class _QrScreenState extends State<QrScreen> {
  Barcode? _barcode;

  void _handledBarcode(BarcodeCapture barcodes) {
    if (mounted) {
      _barcode = barcodes.barcodes.firstOrNull;
      if (_barcode != null) {
        debugPrint('Scan result -> ${{_barcode!.displayValue}}');
        context.pushReplacement(OrderDetailScreen(products: dummyProducts));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('QR Scanner'),
        leading: GestureDetector(
          onTap: () => context.pop(),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Assets.images.back.image(),
          ),
        ),
      ),
      body: MobileScanner(onDetect: _handledBarcode),
    );
  }
}
