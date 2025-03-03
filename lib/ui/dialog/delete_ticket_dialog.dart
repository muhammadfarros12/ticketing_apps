import 'package:flutter/material.dart';
import 'package:ticketing_apps/core/components/button.dart';
import 'package:ticketing_apps/core/components/spaces.dart';
import 'package:ticketing_apps/core/constants/color.dart';
import 'package:ticketing_apps/core/extensions/build_context_ext.dart';

class DeleteTicketDialog extends StatelessWidget {
  const DeleteTicketDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Hapus Data',
            style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
          ),
          SpaceHeight(12),
          Text(
            'Apakah anda yakin untuk menghapus data ini?',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 16,
              color: AppColors.black.withOpacity(0.65),
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
                  label: 'Hapus',
                  borderRadius: 8,
                  height: 44,
                  fontSize: 14,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
