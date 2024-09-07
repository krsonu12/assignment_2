import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../models/customer.dart';

class DatabaseService {
  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await initDatabase();
    return _database!;
  }

  Future<Database> initDatabase() async {
    String path = join(await getDatabasesPath(), 'customer_database.db');
    return await openDatabase(path, version: 1, onCreate: _createDb);
  }

  Future<void> _createDb(Database db, int version) async {
    await db.execute('''
      CREATE TABLE customers(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        fullName TEXT,
        mobileNo TEXT,
        email TEXT,
        address TEXT,
        latitude REAL,
        longitude REAL,
        geoAddress TEXT,
        imagePath TEXT
      )
    ''');
  }

  Future<int> insertCustomer(Customer customer) async {
    final db = await database;
    return await db.insert(
      'customers',
      customer.toMap(),
    );
  }

  Future<List<Customer>> getCustomers() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('customers');
    return List.generate(
      maps.length,
      (i) => Customer.fromMap(
        maps[i],
      ),
    );
  }
}
