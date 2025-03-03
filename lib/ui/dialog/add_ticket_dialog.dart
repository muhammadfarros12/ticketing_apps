import 'package:flutter/material.dart';
import 'package:ticketing_apps/core/components/button.dart';
import 'package:ticketing_apps/core/components/custom_dropdown.dart';
import 'package:ticketing_apps/core/components/custom_text_field.dart';
import 'package:ticketing_apps/core/components/spaces.dart';
import 'package:ticketing_apps/core/constants/color.dart';
import 'package:ticketing_apps/core/extensions/build_context_ext.dart';
import 'package:ticketing_apps/core/extensions/idr_currency.dart';

class AddTicketDialog extends StatelessWidget {
  const AddTicketDialog({super.key});

  @override
  Widget build(BuildContext context) {
    final categories = ['Domestik', 'Internasional'];
    final criterias = ['Perorangan', 'Grup'];

    final nameController = TextEditingController();
    final priceController = TextEditingController();

    final categoryNotifier = ValueNotifier(categories.first);
    final criteriaNotifier = ValueNotifier(criterias.first);

    int parseCurrency(String text) =>
        int.tryParse(text.replaceAll(RegExp(r'[^0-9]'), '')) ?? 0;

    priceController.text = parseCurrency(priceController.text).currencyFormatRp;

    return AlertDialog(
      content: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SpaceHeight(8),
            CustomTextField(controller: nameController, label: 'Nama'),
            SpaceHeight(8),
            CustomTextField(
              controller: priceController,
              label: 'Harga',
              keyboardType: TextInputType.number,
              onChanged: (value) {
                final parsedValue = parseCurrency(value).currencyFormatRp;
                priceController.value = TextEditingValue(
                  text: parsedValue,
                  selection: TextSelection.collapsed(
                    offset: parsedValue.length,
                  ),
                );
              },
            ),
            SpaceHeight(8),
            ValueListenableBuilder(
              valueListenable: categoryNotifier,
              builder:
                  (context, value, _) => CustomDropdown(
                    value: value,
                    items: categories,
                    label: 'Kategori',
                    onChanged: (value) => categoryNotifier.value = value!,
                  ),
            ),
            SpaceHeight(8),
            ValueListenableBuilder(
              valueListenable: criteriaNotifier,
              builder:
                  (context, value, _) => CustomDropdown(
                    value: value,
                    items: criterias,
                    label: 'Kriteria',
                    onChanged: (value) => criteriaNotifier.value = value!,
                  ),
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
      ),
    );
  }
}
