import 'package:expensiv/models/expensmodels.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class Databeseserivs {
  static final String databasename = 'expenses.db';
  static late Database db;

  static Future<void> init(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, databasename);

    db = await openDatabase(path, version: 1, onCreate: _onCreate);
  }

  static Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE expenses (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        value REAL,
        income INTEGER,
        createdAt TEXT,
        type TEXT,
        note TEXT
      )
    ''');
  }

  static Future<void> closedb() async => db.close();

  static Future<int> addExpensestoDb(ExpenseModel expenmodel) async {
    Map<String, dynamic> row = {
      'value': expenmodel.value,
      'income': expenmodel.income ? 1 : 0,
      'type': expenmodel.type.name,
      'note': expenmodel.note,
      'createdAt': (expenmodel.createdAt ?? DateTime.now()).toIso8601String(),
    };

    return await db.insert('expenses', row);
  }

  static Future<int> deleteExpenseFromDb(int id) async {
    return await db.delete('expenses', where: 'id = ?', whereArgs: [id]);
  }

  static Future<List<ExpenseModel>> getAllExpenses() async {
    final List<Map<String, dynamic>> expense = await db.query('expenses');

    return List.generate(expense.length, (index) {
      final row = expense[index];
      final String typeString = row['type']?.toString() ?? '';

      return ExpenseModel(
        id: row['id'] as int?,
        note: row['note']?.toString(),
        value: (row['value'] as num?)?.toDouble() ?? 0.0,
        income: (row['income'] as int?) == 1,
        type: ExpenseCategory.values.firstWhere(
          (e) => e.name.toLowerCase() == typeString.toLowerCase(),
          orElse: () => ExpenseCategory.home,
        ),
        createdAt: row['createdAt'] != null
            ? DateTime.tryParse(row['createdAt'].toString())
            : null,
      );
    });
  }

  static Future<void> clearDB() async {
    await db.delete('expenses');
  }
}
