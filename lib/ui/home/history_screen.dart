import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ticketing_apps/ui/home/bloc/history/history_bloc.dart';
import 'package:ticketing_apps/ui/widgets/history_card.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({super.key});

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  @override
  void initState() {
    context.read<HistoryBloc>().add(HistoryEvent.getHistories());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // Map<String, List<HistoryModel>> groupedHistory = {};
    // for (var data in histories) {
    //   final mothYear =
    //       '${data.dateTime.toFormattedMonth()} ${data.dateTime.year}';

    //   if (!groupedHistory.containsKey(mothYear)) {
    //     groupedHistory[mothYear] = [];
    //   }
    //   groupedHistory[mothYear]!.add(data);
    // }

    return Scaffold(
      appBar: AppBar(title: Text('Transaction History')),
      body: BlocBuilder<HistoryBloc, HistoryState>(
        builder: (context, state) {
          return state.maybeWhen(
            success: (histories) {
              return ListView(
                padding: EdgeInsets.all(16),
                children: List.generate(
                  histories.length,
                  (index) => HistoryCard(item: histories[index]),
                ),
              );
            },
            loading: () => Center(child: CircularProgressIndicator()),
            error: (message) => Center(child: Text('woi error nih'),),
            orElse: () => Center(child: Text('No Data')),
          );
        },
      ),

      // ListView(
      //   padding: EdgeInsets.all(12),
      //   children:
      //       groupedHistory.entries.map((entry) {
      //         final monthYear = entry.key;
      //         final data = entry.value;
      //         final total = data.fold(
      //           0,
      //           (previousValue, element) => previousValue + element.price,
      //         );

      //         return Column(
      //           crossAxisAlignment: CrossAxisAlignment.start,
      //           children: [
      //             Row(
      //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //               children: [
      //                 Text(
      //                   monthYear,
      //                   style: TextStyle(
      //                     fontSize: 12,
      //                     fontWeight: FontWeight.bold,
      //                   ),
      //                 ),
      //                 Text(
      //                   total.currencyFormatRp,
      //                   style: TextStyle(
      //                     fontSize: 12,
      //                     fontWeight: FontWeight.bold,
      //                     color: AppColors.primary,
      //                   ),
      //                 ),
      //               ],
      //             ),
      //             Divider(
      //               thickness: 3,
      //               color: AppColors.primary,
      //               endIndent: context.deviceWidth - 60,
      //             ),
      //             ...data.map((item) => HistoryCard(item: item)).toList(),
      //           ],
      //         );
      //       }).toList(),
      // ),
    );
  }
}
