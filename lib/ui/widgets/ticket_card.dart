import 'package:flutter/material.dart';
import 'package:ticketing_apps/core/assets/assets.gen.dart';
import 'package:ticketing_apps/core/components/spaces.dart';
import 'package:ticketing_apps/core/constants/color.dart';
import 'package:ticketing_apps/core/extensions/idr_currency.dart';
import 'package:ticketing_apps/ui/dialog/delete_ticket_dialog.dart';
import 'package:ticketing_apps/ui/dialog/edit_ticket_dialog.dart';
import 'package:ticketing_apps/ui/home/model/product_model.dart';

class TicketCard extends StatelessWidget {
  final ProductModel item;
  const TicketCard({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(24),
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.stroke),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(item.productName, style: TextStyle(fontSize: 15)),
                    Text(item.type, style: TextStyle(fontSize: 11)),
                  ],
                ),
              ),
              IconButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) => DeleteTicketDialog(),
                  );
                },
                icon: Assets.icons.delete.svg(),
              ),
              IconButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) => EditTicketDialog(item: item),
                  );
                },
                icon: Assets.icons.edit.svg(),
              ),
            ],
          ),
          SizedBox(height: 8),
          Text(
            item.price.currencyFormatRp,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
