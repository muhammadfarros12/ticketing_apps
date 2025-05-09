import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:ticketing_apps/core/assets/assets.gen.dart';
import 'package:ticketing_apps/core/components/spaces.dart';
import 'package:ticketing_apps/core/constants/color.dart';
import 'package:ticketing_apps/core/extensions/date_time_ext.dart';
import 'package:ticketing_apps/core/extensions/idr_currency.dart';
import 'package:ticketing_apps/core/extensions/string_ext.dart';
import 'package:ticketing_apps/model/request/order_model.dart';
import 'package:ticketing_apps/ui/home/model/history_model.dart';

class HistoryCard extends StatelessWidget {
  // final HistoryModel item;
  final OrderModel item;
  const HistoryCard({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.stroke),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          Assets.icons.plus.svg(),
          SpaceWidth(10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                // item.name,
                item.id.toString(),
                style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
              ),
              SpaceHeight(5),
              Text(
                // item.dateTime.toFormattedDayTime(),
                DateFormat('dd MM yyyy').format(DateTime(
                  item.transactionTime.substring(0, 4).toInt,
                  item.transactionTime.substring(5, 7).toInt,
                  item.transactionTime.substring(8, 10).toInt
                  )),
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  color: AppColors.grey,
                ),
              ),
            ],
          ),
          Spacer(),
          Text(
            // item.price.currencyFormatRp,
            item.nominalItem.currencyFormatRp,
            style: TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.bold,
              color: AppColors.primary,
            ),
          ),
        ],
      ),
    );
  }
}
