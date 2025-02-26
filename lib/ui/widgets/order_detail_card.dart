import 'package:flutter/material.dart';
import 'package:ticketing_apps/core/constants/color.dart';
import 'package:ticketing_apps/core/extensions/idr_currency.dart';
import 'package:ticketing_apps/ui/home/model/product_model.dart';

class OrderDetailCard extends StatelessWidget {
  final ProductModel item;
  const OrderDetailCard({super.key, required this.item});

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
                Text(item.productName, style: TextStyle(fontSize: 15)),
                Text(item.type, style: TextStyle(fontSize: 11)),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '${item.price.currencyFormatRp} x ${item.quantity}',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(
                      (item.price * item.quantity).currencyFormatRp,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ],
            ),
          );
        
  }
}