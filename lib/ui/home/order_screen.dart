import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ticketing_apps/core/assets/assets.gen.dart';
import 'package:ticketing_apps/core/components/button.dart';
import 'package:ticketing_apps/core/components/spaces.dart';
import 'package:ticketing_apps/core/constants/color.dart';
import 'package:ticketing_apps/core/extensions/build_context_ext.dart';
import 'package:ticketing_apps/core/extensions/idr_currency.dart';
import 'package:ticketing_apps/model/request/order_item.dart';
import 'package:ticketing_apps/model/response/product_response_model.dart';
import 'package:ticketing_apps/ui/home/bloc/checkout/checkout_bloc.dart';
import 'package:ticketing_apps/ui/home/bloc/product/product_bloc.dart';
import 'package:ticketing_apps/ui/home/order_detail_screen.dart';

class OrderScreen extends StatefulWidget {
  const OrderScreen({super.key});

  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  @override
  void initState() {
    context.read<ProductBloc>().add(ProductEvent.getLocalProducts());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Penjualan')),
      body: BlocBuilder<ProductBloc, ProductState>(
        builder: (context, state) {
          final products = state.maybeWhen(
            orElse: () => [],
            success: (products) => products,
          );
          if (products.isEmpty) {
            return Center(child: Text('No Product Available'));
          }
          return ListView.separated(
            padding: EdgeInsets.symmetric(horizontal: 20),
            separatorBuilder: (context, index) => SpaceHeight(20),
            itemCount: products.length,
            itemBuilder: (context, index) {
              final Product item = products[index];
              return Container(
                padding: EdgeInsets.all(24),
                decoration: BoxDecoration(
                  border: Border.all(color: AppColors.stroke),
                  borderRadius: BorderRadius.circular(46),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            item.name ?? '',
                            style: TextStyle(fontSize: 15),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            context.read<CheckoutBloc>().add(
                              CheckoutEvent.removeCheckout(item),
                            );
                          },
                          child: Assets.icons.reduceQuantity.svg(),
                        ),

                        BlocBuilder<CheckoutBloc, CheckoutState>(
                          builder: (context, state) {
                            final int quantity = state.maybeWhen(
                              success: (product) {
                                return product
                                    .firstWhere(
                                      (element) =>
                                          element.product.id == item.id,
                                      orElse:
                                          () => OrderItem(
                                            product: item,
                                            quantity: 0,
                                          ),
                                    )
                                    .quantity;
                              },
                              orElse: () => 0,
                            );
                            return Text(
                              quantity.toString(),
                              style: TextStyle(fontWeight: FontWeight.bold),
                            );
                          },
                        ),
                        InkWell(
                          onTap: () {
                            context.read<CheckoutBloc>().add(
                              CheckoutEvent.addCheckout(item),
                            );
                          },
                          child: Assets.icons.addQuantity.svg(),
                        ),
                      ],
                    ),
                    Text(
                      item.category?.name ?? '',
                      style: TextStyle(fontSize: 11),
                    ),
                    SpaceHeight(8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          item.price!.currencyFormatRp,
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        BlocBuilder<CheckoutBloc, CheckoutState>(
                          builder: (context, state) {
                            return state.maybeWhen(
                              success: (product) {
                                final quantity =
                                    product
                                        .firstWhere(
                                          (element) =>
                                              element.product.id == item.id,
                                          orElse:
                                              () => OrderItem(
                                                product: item,
                                                quantity: 0,
                                              ),
                                        )
                                        .quantity;
                                return Text(
                                  (item.price! * quantity).currencyFormatRp,
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                );
                              },
                              orElse:
                                  () => Text(
                                    0.toString(),
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                            );
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),

      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Container(
          margin: EdgeInsets.only(bottom: 10),
          child: Row(
            children: [
              Expanded(
                flex: 1,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text('Order Summary'),
                    BlocBuilder<CheckoutBloc, CheckoutState>(
                      builder: (context, state) {
                        return state.maybeWhen(
                          success: (product) {
                            final total = product.fold(0, (
                              previousValue,
                              element,
                            ) {
                              return previousValue +
                                  element.product.price! * element.quantity;
                            });
                            return Text(
                              total.currencyFormatRp,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            );
                          },
                          orElse:
                              () => Text(
                                0.currencyFormatRp,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
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
                    context.push(
                      OrderDetailScreen(),
                    );
                  },
                  label: 'Process',
                  borderRadius: 20,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
