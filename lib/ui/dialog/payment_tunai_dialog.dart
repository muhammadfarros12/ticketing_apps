import 'package:flutter/material.dart';
import 'package:ticketing_apps/core/components/button.dart';
import 'package:ticketing_apps/core/components/custom_text_field.dart';
import 'package:ticketing_apps/core/components/spaces.dart';
import 'package:ticketing_apps/core/constants/color.dart';
import 'package:ticketing_apps/core/extensions/build_context_ext.dart';
import 'package:ticketing_apps/core/extensions/idr_currency.dart';
import 'package:ticketing_apps/ui/home/payment_success_screen.dart';

class PaymentTunaiDialog extends StatefulWidget {
  final int totalPrice;
  const PaymentTunaiDialog({super.key, required this.totalPrice});

  @override
  State<PaymentTunaiDialog> createState() => _PaymentTunaiDialogState();
}

class _PaymentTunaiDialogState extends State<PaymentTunaiDialog> {
  final nominalController = TextEditingController();
  int paidIndex = -1;

  @override
  void initState() {
    nominalController.text = widget.totalPrice.currencyFormatRp;
    super.initState();
  }

  @override
  void dispose() {
    nominalController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SpaceHeight(12),
          CustomTextField(
            controller: nominalController,
            label: 'Masukkan Nominal',
            keyboardType: TextInputType.numberWithOptions(),
          ),
          SpaceHeight(20),
          Row(
            children: [
              Flexible(
                child: Button.outlined(
                  onPressed:
                      () => setState(() {
                        paidIndex = 0;
                      }),
                  textColor: paidIndex == 0 ? AppColors.white : AppColors.grey,
                  color:
                      paidIndex == 0 ? AppColors.primary : Colors.transparent,
                  label: 'Uang Pas',
                  borderRadius: 10,
                  fontSize: 14,
                ),
              ),
              Flexible(
                child: Button.outlined(
                  onPressed:
                      () => setState(() {
                        paidIndex = 1;
                      }),
                  textColor: paidIndex == 1 ? AppColors.white : AppColors.grey,
                  color:
                      paidIndex == 1 ? AppColors.primary : Colors.transparent,
                  label: 20000.currencyFormatRp,
                  borderRadius: 10,
                  fontSize: 14,
                ),
              ),
            ],
          ),

          Row(
            children: [
              Flexible(
                child: Button.outlined(
                  onPressed:
                      () => setState(() {
                        paidIndex = 2;
                      }),
                  textColor: paidIndex == 2 ? AppColors.white : AppColors.grey,
                  color:
                      paidIndex == 2 ? AppColors.primary : Colors.transparent,
                  label: 50000.currencyFormatRp,
                  borderRadius: 10,
                  fontSize: 14,
                ),
              ),
              Flexible(
                child: Button.outlined(
                  onPressed:
                      () => setState(() {
                        paidIndex = 3;
                      }),
                  textColor: paidIndex == 3 ? AppColors.white : AppColors.grey,
                  color:
                      paidIndex == 3 ? AppColors.primary : Colors.transparent,
                  label: 90000.currencyFormatRp,
                  borderRadius: 10,
                  fontSize: 14,
                ),
              ),
            ],
          ),
          SpaceHeight(24),
          Button.filled(
            disabled: paidIndex == -1,
            onPressed: () => context.pushReplacement(PaymentSuccessScreen()),
            label: 'Bayar',
            fontSize: 16,
            borderRadius: 16,
          ),
        ],
      ),
    );
  }
}
