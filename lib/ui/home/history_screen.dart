import 'package:flutter/material.dart';
import 'package:ticketing_apps/core/constants/color.dart';
import 'package:ticketing_apps/core/extensions/build_context_ext.dart';
import 'package:ticketing_apps/core/extensions/date_time_ext.dart';
import 'package:ticketing_apps/core/extensions/idr_currency.dart';
import 'package:ticketing_apps/ui/home/model/history_model.dart';
import 'package:ticketing_apps/ui/widgets/history_card.dart';

class HistoryScreen extends StatelessWidget {
  const HistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Map<String, List<HistoryModel>> groupedHistory = {};
    for (var data in histories) {
      final mothYear =
          '${data.dateTime.toFormattedMonth()} ${data.dateTime.year}';

      if (!groupedHistory.containsKey(mothYear)) {
        groupedHistory[mothYear] = [];
      }
      groupedHistory[mothYear]!.add(data);
    }

    return Scaffold(
      appBar: AppBar(title: Text('Transaction History')),
      body: ListView(
        padding: EdgeInsets.all(12),
        children:
            groupedHistory.entries.map((entry) {
              final monthYear = entry.key;
              final data = entry.value;
              final total = data.fold(
                0,
                (previousValue, element) => previousValue + element.price,
              );

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        monthYear,
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        total.currencyFormatRp,
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: AppColors.primary,
                        ),
                      ),
                    ],
                  ),
                  Divider(
                    thickness: 3,
                    color: AppColors.primary,
                    endIndent: context.deviceWidth - 60,
                  ),
                  ...data.map((item) => HistoryCard(item: item)).toList(),
                ],
              );
            }).toList(),
      ),
    );
  }
}
