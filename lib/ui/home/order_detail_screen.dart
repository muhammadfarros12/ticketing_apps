import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:ticketing_apps/core/assets/assets.gen.dart';
import 'package:ticketing_apps/core/components/button.dart';
import 'package:ticketing_apps/core/components/spaces.dart';
import 'package:ticketing_apps/core/constants/color.dart';
import 'package:ticketing_apps/core/extensions/build_context_ext.dart';
import 'package:ticketing_apps/core/extensions/idr_currency.dart';
import 'package:ticketing_apps/model/request/order_item.dart';
import 'package:ticketing_apps/ui/dialog/payment_qris_dialog.dart';
import 'package:ticketing_apps/ui/dialog/payment_tunai_dialog.dart';
import 'package:ticketing_apps/ui/home/bloc/checkout/checkout_bloc.dart';
import 'package:ticketing_apps/ui/widgets/order_detail_card.dart';
import 'package:ticketing_apps/ui/widgets/payment_method_button.dart';

class OrderDetailScreen extends StatelessWidget {
  // final List<ProductModel> products;

  const OrderDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    int totalPrice = 0;
    List<OrderItem> orderItem = [];
    int paymentButtonIndex = 0;
    return Scaffold(
      appBar: AppBar(
        title: Text('Detail Pesanan'),
        leading: GestureDetector(
          onTap: () => context.pop(),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Assets.images.back.image(),
          ),
        ),
      ),
      body: BlocBuilder<CheckoutBloc, CheckoutState>(
        builder: (context, state) {
          final products = state.maybeWhen(
            success: (checkout) => checkout,
            orElse: () {},
          );

          return ListView.separated(
            separatorBuilder: (context, index) => SpaceHeight(20),
            itemCount: products!.length,
            itemBuilder:
                (context, index) => OrderDetailCard(item: products[index]),
          );
        },
      ),
      bottomNavigationBar: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          StatefulBuilder(
            builder: (context, setState) {
              return Container(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  children: [
                    Expanded(
                      child: PaymentMethodButton(
                        iconPath: Assets.icons.payment.qris.path,
                        label: "QRIS",
                        isActive: paymentButtonIndex == 0,
                        onPressed: () => setState(() => paymentButtonIndex = 0),
                      ),
                    ),
                    SpaceWidth(20),
                    Expanded(
                      child: PaymentMethodButton(
                        iconPath: Assets.icons.payment.tunai.path,
                        label: "Tunai",
                        isActive: paymentButtonIndex == 1,
                        onPressed: () => setState(() => paymentButtonIndex = 1),
                      ),
                    ),
                    SpaceWidth(20),
                    Expanded(
                      child: PaymentMethodButton(
                        iconPath: Assets.icons.payment.transfer.path,
                        label: 'Transfer',
                        isActive: paymentButtonIndex == 2,
                        onPressed: () => setState(() => paymentButtonIndex = 2),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
          SpaceHeight(24),
          Container(
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  blurRadius: 30,
                  spreadRadius: 0,
                  offset: Offset(0, -2),
                  color: AppColors.black.withOpacity(8 / 100),
                  blurStyle: BlurStyle.outer,
                ),
              ],
            ),
            child: Row(
              children: [
                Expanded(
                  flex: 1,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text('Order Summary'),
                      SpaceHeight(10),
                      BlocBuilder<CheckoutBloc, CheckoutState>(
                        builder: (context, state) {
                          return state.maybeWhen(
                            success: (product) {
                              orderItem = product;
                              final total = product.fold(
                                0,
                                (prev, e) => prev + e.product.price! * e.quantity,
                              );
                              totalPrice = total;
                              return Text(
                                total.currencyFormatRp,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              );
                            },
                            orElse: () {
                              return Text(
                                0.currencyFormatRp,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              );
                            },
                          );
                        },
                      ),
                    ],
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Button.filled(
                    onPressed: () {
                      if (paymentButtonIndex == 0) {
                        showDialog(
                          context: context,
                          builder: (context) => PaymentQrisDialog(),
                        );
                      } else if (paymentButtonIndex == 1) {
                        showDialog(
                          context: context,
                          builder:
                              (context) =>
                                  PaymentTunaiDialog(totalPrice: 140000),
                        );
                      }
                    },
                    label: 'Proses',
                    borderRadius: 20,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
