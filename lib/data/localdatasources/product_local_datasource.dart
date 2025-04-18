import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqlite_api.dart';
import 'package:ticketing_apps/model/response/product_response_model.dart';

class ProductLocalDatasource {
  ProductLocalDatasource._init();

  static final ProductLocalDatasource instance = ProductLocalDatasource._init();

  final String tableProducts = 'products';
  final String tableOrders = 'orders';
  final String tableOrderItems = 'order_items';
  final String tableCategory = 'categories';

  static Database? _database;

  Future<void> _createDB(Database db, int version) async {
    await db.execute('''
    CREATE TABLE $tableProducts (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    productId INTEGER,
    category_id INTEGER,
    name TEXT NOT NULL,
    description TEXT,
    image TEXT,
    price TEXT,
    stock  INTEGER,
    status INTEGER,
    is_favorite INTEGER,
    criteria TEXT,
    created_at TEXT,
    updated_at TEXT
    )
    ''');

    await db.execute('''
      CREATE TABLE $tableCategory (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      categoryId INTEGER,
      name TEXT NOT NULL,
      description TEXT,
      image TEXT,
      created_at TEXT,
      updated_at TEXT
      )
  ''');
  }

  // initialize database
  Future<Database> _initDb() async {
    final path = await getDatabasesPath();
    final databasePath = '$path/ticketing.db';
    return openDatabase(databasePath, version: 2, onCreate: _createDB);
  }

  // get database
  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDb();
    return _database!;
  }

  // insert allProduct
  Future<void> insertAllProduct(List<Product> products) async {
    final db = await instance.database;
    for (var product in products) {
      await db.insert(
        tableProducts,
        product.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    }
  }

  // remove all data product
  Future<void> removeAllProduct() async {
    final db = await instance.database;
    await db.delete(tableProducts);
  }

  // Get All Data Product
  Future<List<Product>> getProduct() async {
    final db = await instance.database;
    final List<Map<String, dynamic>> maps = await db.rawQuery('''
    SELECT p.*, c.id as category_id, c.name as category_name, 
    c.description as category_description, c.image as category_image, 
    c.created_at as category_created_at, c.updated_at as category_updated_at
    FROM $tableProducts p
    LEFT JOIN $tableCategory c ON p.category_id = c.id
''');

    return List.generate(maps.length, (i) {
      final productMap = maps[i];
      final categoryMap = {
        'id': productMap['category_id'],
        'name': productMap['category_name'],
        'image': productMap['category_image'],
        'description': productMap['category_description'],
        'created_at': productMap['category_created_at'],
        'updated_at': productMap['category_updated_at'],
      };

      return Product.fromMap(
        productMap,
      ).copyWith(category: Category.fromMap(categoryMap));
    });
  }
}
