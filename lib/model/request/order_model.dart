import 'dart:convert';

import 'package:ticketing_apps/model/request/order_item.dart';

class OrderModel {
  final int id;
  final int cashierId;
  final String cashierName;
  final String paymentMethod;
  final int nominalItem;
  final List<OrderItem> orders;
  final int totalQuantity;
  final int totalPrice;
  final String transactionTime;
  final bool isSync;

  OrderModel({required this.id, required this.cashierId, required this.cashierName, required this.paymentMethod, required this.nominalItem, required this.orders, required this.totalQuantity, required this.totalPrice, required this.transactionTime, required this.isSync});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'cashierId': cashierId,
      'cashierName': cashierName,
      'paymentMethod': paymentMethod,
      'nominalItem': nominalItem,
      'orders': orders.map((x) => x.toMap()).toList(),
      'totalQuantity': totalQuantity,
      'totalPrice': totalPrice,
      'transactionTime': transactionTime,
      'isSync': isSync,
    };
  }

  factory OrderModel.fromMap(Map<String, dynamic> map) {
    return OrderModel(
      id: map['id']?.toInt() ?? 0,
      cashierId: map['cashierId']?.toInt() ?? 0,
      cashierName: map['cashierName'] ?? '',
      paymentMethod: map['paymentMethod'] ?? '',
      nominalItem: map['nominalItem']?.toInt() ?? 0,
      orders: List<OrderItem>.from(map['orders']?.map((x) => OrderItem.fromMap(x))),
      totalQuantity: map['totalQuantity']?.toInt() ?? 0,
      totalPrice: map['totalPrice']?.toInt() ?? 0,
      transactionTime: map['transactionTime'] ?? '',
      isSync: map['isSync'] ?? false,
    );
  }

  Map<String, dynamic> toMapFromLocal() {
    return {
      'id': id,
      'cashierId': cashierId,
      'cashierName': cashierName,
      'paymentMethod': paymentMethod,
      'nominalItem': nominalItem,
      'totalQuantity': totalQuantity,
      'totalPrice': totalPrice,
      'transactionTime': transactionTime,
      'isSync': isSync ? 1 : 0,
    };
  }

  factory OrderModel.fromLocalMap(Map<String, dynamic> map) {
    return OrderModel(
      id: map['id']?.toInt() ?? 0,
      cashierId: map['cashierId']?.toInt() ?? 0,
      cashierName: map['cashierName'] ?? '',
      paymentMethod: map['paymentMethod'] ?? '',
      nominalItem: map['nominalItem']?.toInt() ?? 0,
      orders: [],
      totalQuantity: map['totalQuantity']?.toInt() ?? 0,
      totalPrice: map['totalPrice']?.toInt() ?? 0,
      transactionTime: map['transactionTime'] ?? '',
      isSync: map['isSync'] == 1 ? true : false,
    );
  }

  String toJson() => json.encode(toMap());

  factory OrderModel.fromJson(String source) => OrderModel.fromMap(json.decode(source));
}
