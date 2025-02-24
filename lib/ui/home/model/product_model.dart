class ProductModel {
  final String productName;
  final String type;
  final int price;
  int quantity;

  ProductModel({
    required this.productName,
    required this.type,
    required this.price,
    this.quantity = 1,
  });
}

final dummyProducts = [
  ProductModel(
    productName: 'Tiket Masuk Dewasa',
    type: 'Domestik',
    price: 5000,
  ),
  ProductModel(
    productName: 'Tiket Masuk Anak kecil',
    type: 'Domestik',
    price: 2000,
  ),
  ProductModel(
    productName: 'Tiket Masuk Anak kecil',
    type: 'Domestik',
    price: 2000,
  ),
  ProductModel(
    productName: 'Tiket Masuk Anak kecil',
    type: 'Domestik',
    price: 2000,
  ),
  ProductModel(
    productName: 'Tiket Masuk Dewasa',
    type: 'Mancanegara',
    price: 50000,
  ),
  ProductModel(
    productName: 'Tiket Masuk Anak kecil',
    type: 'Mancanegara',
    price: 20000,
  ),
];
