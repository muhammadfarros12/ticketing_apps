import 'dart:convert';

import 'package:ticketing_apps/model/response/product_response_model.dart';

class OrderItem {
  final Product product;
  int quantity;
  OrderItem({
    required this.product,
    required this.quantity,
  });

  Map<String, dynamic> toMap() {
    return {
      'product': product.toMap(),
      'quantity': quantity,
    };
  }

  factory OrderItem.fromMap(Map<String, dynamic> map) {
    return OrderItem(
      product: Product.fromMap(map['product']),
      quantity: map['quantity']?.toInt() ?? 0,
    );
  }

    Map<String, dynamic> toMapFromLocal(int orderId) {
    return {
      'id_order': orderId,
      'id_product': product.id,
      'quantity': quantity,
      'price': product.price
    };
  }

  String toJson() => json.encode(toMap());

  factory OrderItem.fromJson(String source) => OrderItem.fromMap(json.decode(source));
}
