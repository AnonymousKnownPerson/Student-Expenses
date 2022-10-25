import 'package:business_app/model/transaction.dart';
import 'package:sqflite/sqflite.dart' hide Transaction;
import 'package:path/path.dart';

class TransactionDatabase {
  static final TransactionDatabase instance = TransactionDatabase._init();
  static Database? _database;
  TransactionDatabase._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('transactions.db');
    return _database!;
  }

  Future<Database> _initDB(String filepath) async {
    final dbPath = await getDatabasesPath();
    // "On Android, it is typically data/data//databases &
    //On iOS and MacOS, it is the Documents directory."
    //Use PathProvider next time
    final path = join(dbPath, filepath);
    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    const idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
    const titleType = 'TEXT NOT NULL';
    const amountType = 'REAL NOT NULL';
    const dateType = 'TEXT NOT NULL';

    await db.execute('''
    CREATE TABLE $tableTransactions (
      ${TransactionFields.id} $idType,
      ${TransactionFields.title} $titleType,
      ${TransactionFields.amount} $amountType,
      ${TransactionFields.date} $dateType
    )
    ''');
  }

  Future<Transaction> create(Transaction transaction) async {
    final db = await instance.database;
    /*
    final json = transaction.toJson();    
    final columns =
        '${TransactionFields.title}, ${TransactionFields.amount}, ${TransactionFields.date}';
    final values =
        '${json[TransactionFields.title]}, ${json[TransactionFields.amount]}, ${json[TransactionFields.date]}';
    final id = await db
        .rawInsert('INSERT INTO tableTransactions ($columns) VALUES ($values)');
    */
    final id = await db.insert(tableTransactions, transaction.toJson());
    return transaction.copy(id: id);
  }

  Future<Transaction> readTransaction(int id) async {
    final db = await instance.database;
    final result = await db.query(
      tableTransactions,
      columns: TransactionFields.values,
      where: '${TransactionFields.id} = ?', // prevents SQL Injenction
      whereArgs: [id],
    );
    if (result.isNotEmpty) {
      return Transaction.fromJson(result.first);
    } else {
      throw Exception('Id $id not found');
    }
  }

  Future<List<Transaction>> readAllTransactions() async {
    final db = await instance.database;
    final result = await db.query(
      tableTransactions,
      orderBy: '${TransactionFields.date} ASC',
    );
    return result.map((e) => Transaction.fromJson(e)).toList();
  }

  Future<int> updateTransaction(Transaction transaction) async {
    final db = await instance.database;
    return db.update(
      tableTransactions, transaction.toJson(),
      where: '${TransactionFields.id} = ?', // prevents SQL Injenction
      whereArgs: [transaction.id],
    );
  }

  Future<int> delete(int id) async {
    final db = await instance.database;

    return await db.delete(
      tableTransactions,
      where: '${TransactionFields.id} = ?', // prevents SQL Injenction
      whereArgs: [id],
    );
  }

  Future close() async {
    final db = await instance.database;
    db.close();
  }
}
