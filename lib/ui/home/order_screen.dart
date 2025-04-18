import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ticketing_apps/core/assets/assets.gen.dart';
import 'package:ticketing_apps/core/components/button.dart';
import 'package:ticketing_apps/core/components/spaces.dart';
import 'package:ticketing_apps/core/constants/color.dart';
import 'package:ticketing_apps/core/extensions/build_context_ext.dart';
import 'package:ticketing_apps/core/extensions/idr_currency.dart';
import 'package:ticketing_apps/model/response/product_response_model.dart';
import 'package:ticketing_apps/ui/home/bloc/product/product_bloc.dart';
import 'package:ticketing_apps/ui/home/model/product_model.dart';
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

              // final quantityNotifier = ValueNotifier(0);

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
                            // item.productName,
                            item.name ?? '',
                            style: TextStyle(fontSize: 15),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            // if (quantityNotifier.value > 0) {
                            //   quantityNotifier.value--;
                            // }
                          },
                          child: Assets.icons.reduceQuantity.svg(),
                        ),
                        // ValueListenableBuilder(
                        //   valueListenable: quantityNotifier,
                        //   builder:
                        //       (context, value, _) => Text(
                        //         '$value',
                        //         style: TextStyle(fontWeight: FontWeight.bold),
                        //       ),
                        // ),
                        Text(
                          '0',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        InkWell(
                          onTap: () {
                            // quantityNotifier.value++
                          },
                          child: Assets.icons.addQuantity.svg(),
                        ),
                      ],
                    ),
                    Text(
                      // item.type,
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
                        // ValueListenableBuilder(
                        //   valueListenable: quantityNotifier,
                        //   builder: (context, value, _) {
                        //     return Text(
                        //       '0',
                        //       // (item.price * value).currencyFormatRp,
                        //       style: TextStyle(fontWeight: FontWeight.bold),
                        //     );
                        //   },
                        // ),
                        Text(
                          '0',
                          style: TextStyle(fontWeight: FontWeight.bold),
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
                    Text(
                      30000.currencyFormatRp,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                flex: 1,
                child: Button.filled(
                  onPressed: () {
                    context.push(
                      OrderDetailScreen(
                        products: [
                          dummyProducts[0],
                          dummyProducts[1],
                          dummyProducts[4],
                        ],
                      ),
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
