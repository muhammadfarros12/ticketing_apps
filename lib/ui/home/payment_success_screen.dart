import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:ticketing_apps/core/assets/assets.gen.dart';
import 'package:ticketing_apps/core/components/button.dart';
import 'package:ticketing_apps/core/components/spaces.dart';
import 'package:ticketing_apps/core/constants/color.dart';
import 'package:ticketing_apps/core/extensions/build_context_ext.dart';
import 'package:ticketing_apps/core/extensions/date_time_ext.dart';
import 'package:ticketing_apps/core/extensions/idr_currency.dart';

class PaymentSuccessScreen extends StatelessWidget {
  const PaymentSuccessScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        title: Text(
          'Payment Reciept',
          style: TextStyle(color: AppColors.white),
        ),
        leading: GestureDetector(
          onTap: () => context.pop(),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Assets.images.back.image(color: AppColors.white),
          ),
        ),
      ),
      body: Stack(
        children: [
          Container(
            height: context.deviceHeight / 2,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.vertical(bottom: Radius.circular(12)),
              color: AppColors.primary,
            ),
          ),
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: Assets.images.receiptCard.provider(),
                alignment: Alignment.topCenter,
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(60.0),
              child: Column(
                children: [
                  Text(
                    'PAYMENT RECIEPT',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 2.5,
                    ),
                  ),
                  SpaceHeight(16),
                  QrImageView(
                    data: 'payment-receipt',
                    version: QrVersions.auto,
                  ),
                  SpaceHeight(16),
                  Text('Scan this QR code to verify tickets'),
                  SpaceHeight(20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [Text('Tagihan'), Text(120000.currencyFormatRp)],
                  ),
                  SpaceHeight(40),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [Text('Metode Bayar'), Text('QRIS')],
                  ),
                  SpaceHeight(8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Waktu'),
                      Text(DateTime.now().toFormattedDate()),
                    ],
                  ),
                  SpaceHeight(8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [Text('Status'), Text('Lunas')],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Padding(
        padding: const EdgeInsets.fromLTRB(36, 0, 36, 20),
        child: Button.filled(
          borderRadius: 10,
          onPressed: () {},
          label: 'Cetak Transaksi',
        ),
      ),
    );
  }
}
