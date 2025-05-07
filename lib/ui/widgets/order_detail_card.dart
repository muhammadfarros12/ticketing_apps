import 'package:flutter/material.dart';
import 'package:ticketing_apps/core/constants/color.dart';
import 'package:ticketing_apps/core/extensions/idr_currency.dart';
import 'package:ticketing_apps/model/request/order_item.dart';

class OrderDetailCard extends StatelessWidget {
  // final ProductModel item;
  final OrderItem item;
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
                Text(item.product.name ?? '', style: TextStyle(fontSize: 15)),
                Text(item.product.category?.name ?? '', style: TextStyle(fontSize: 11)),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      // '${item.price.currencyFormatRp} x ${item.quantity}',
                      '${item.product.price?.currencyFormatRp} x ${item.quantity}',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(
                      (item.product.price! * item.quantity).currencyFormatRp,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ],
            ),
          );
        
  }
}