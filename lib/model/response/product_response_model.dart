import 'dart:convert';

class ProductResponseModel {
  String? status;
  List<Product>? data;

  ProductResponseModel({this.status, this.data});

  ProductResponseModel copyWith({String? status, List<Product>? data}) =>
      ProductResponseModel(
        status: status ?? this.status,
        data: data ?? this.data,
      );

  factory ProductResponseModel.fromJson(String str) =>
      ProductResponseModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory ProductResponseModel.fromMap(Map<String, dynamic> json) =>
      ProductResponseModel(
        status: json["status"],
        data: List<Product>.from(json["data"].map((x) => Product.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
    "status": status,
    "data": List<dynamic>.from(data!.map((x) => x.toMap())),
  };
}

class Product {
  final int? id;
  final String? name;
  final String? description;
  final int? price;
  final int? stock;
  final int? categoryId;
  final String? image;
  final String? status;
  final String? criteria;
  final int? favorite;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final Category? category;

  Product({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.stock,
    required this.categoryId,
    required this.image,
    required this.status,
    required this.criteria,
    required this.favorite,
    required this.createdAt,
    required this.updatedAt,
    required this.category,
  });

  Product copyWith({
    int? id,
    String? name,
    String? description,
    int? price,
    int? stock,
    int? categoryId,
    String? image,
    String? status,
    String? criteria,
    int? favorite,
    DateTime? createdAt,
    DateTime? updatedAt,
    Category? category,
  }) => Product(
    id: id ?? this.id,
    name: name ?? this.name,
    description: description ?? this.description,
    price: price ?? this.price,
    stock: stock ?? this.stock,
    categoryId: categoryId ?? this.categoryId,
    image: image ?? this.image,
    status: status ?? this.status,
    criteria: criteria ?? this.criteria,
    favorite: favorite ?? this.favorite,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
    category: category ?? this.category,
  );

  factory Product.fromJson(String str) => Product.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Product.fromMap(Map<String, dynamic> json) => Product(
    id: json["id"],
    name: json["name"],
    description: json["description"],
    price: json["price"],
    stock: json["stock"],
    categoryId: json["category_id"],
    image: json["image"],
    status: json["status"],
    criteria: json["criteria"],
    favorite: json["favorite"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    category: Category.fromMap(json["category"]),
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "name": name,
    "description": description,
    "price": price,
    "stock": stock,
    "category_id": categoryId,
    "image": image,
    "status": status,
    "criteria": criteria,
    "favorite": favorite,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
    "category": category?.toMap(),
  };
}

class Category {
  final int? id;
  final String? name;
  final String? description;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  Category({
    required this.id,
    required this.name,
    required this.description,
    required this.createdAt,
    required this.updatedAt,
  });

  Category copyWith({
    int? id,
    String? name,
    String? description,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) => Category(
    id: id ?? this.id,
    name: name ?? this.name,
    description: description ?? this.description,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );

  factory Category.fromJson(String str) => Category.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Category.fromMap(Map<String, dynamic> json) => Category(
    id: json["id"],
    name: json["name"],
    description: json["description"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "name": name,
    "description": description,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
  };
}


