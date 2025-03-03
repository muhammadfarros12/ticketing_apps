import 'package:flutter/material.dart';
import 'package:ticketing_apps/core/components/button.dart';
import 'package:ticketing_apps/core/components/custom_text_field.dart';
import 'package:ticketing_apps/core/components/spaces.dart';
import 'package:ticketing_apps/core/constants/color.dart';
import 'package:ticketing_apps/core/extensions/build_context_ext.dart';
import 'package:ticketing_apps/core/extensions/idr_currency.dart';
import 'package:ticketing_apps/ui/home/model/product_model.dart';

class EditTicketDialog extends StatelessWidget {
  final ProductModel item;
  const EditTicketDialog({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    final nameController = TextEditingController(text: item.productName);
    final priceController = TextEditingController(text: '${item.price}');

    int parseCurrency(String text) =>
        int.tryParse(text.replaceAll(RegExp(r'[^0-9]'), '')) ?? 0;

    priceController.text = parseCurrency(priceController.text).currencyFormatRp;

    return AlertDialog(
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          CustomTextField(controller: nameController, label: 'Nama'),
          CustomTextField(
            controller: priceController,
            label: 'Harga',
            keyboardType: TextInputType.number,
            onChanged: (value) {
              final parsedValue = parseCurrency(value).currencyFormatRp;
              priceController.value = TextEditingValue(
                text: parsedValue,
                selection: TextSelection.collapsed(offset: parsedValue.length),
              );
            },
          ),
          SpaceHeight(20),
          Row(
            children: [
              Flexible(
                child: Button.filled(
                  onPressed: () => context.pop(),
                  label: 'Batalkan',
                  borderRadius: 8,
                  color: AppColors.buttonCancel,
                  textColor: AppColors.grey,
                  height: 44,
                  fontSize: 14,
                ),
              ),
              SpaceWidth(8),
              Flexible(
                child: Button.filled(
                  onPressed: () => context.pop(),
                  label: 'Simpan',
                  borderRadius: 8,
                  height: 44,
                  fontSize: 14,
                ),
              ),
            ],
          ),
          SpaceHeight(20),
        ],
      ),
    );
  
  }
}
