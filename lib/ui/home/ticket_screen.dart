import 'package:flutter/material.dart';
import 'package:ticketing_apps/core/assets/assets.gen.dart';
import 'package:ticketing_apps/core/components/spaces.dart';
import 'package:ticketing_apps/ui/dialog/add_ticket_dialog.dart';
import 'package:ticketing_apps/ui/home/model/product_model.dart';
import 'package:ticketing_apps/ui/widgets/ticket_card.dart';

class TicketScreen extends StatelessWidget {
  const TicketScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Kelola tiket'),
        actions: [
          IconButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) => AddTicketDialog(),
              );
            },
            icon: Assets.icons.plus.svg(),
          ),
        ],
      ),
      body: ListView.separated(
        itemBuilder: (context, index) => TicketCard(item: dummyProducts[index]),
        separatorBuilder: (context, index) => SpaceHeight(20),
        itemCount: dummyProducts.length,
      ),
    );
  }
}
