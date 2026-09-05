import 'package:expensiv/gen/assets.gen.dart';
import 'package:expensiv/models/expensmodels.dart';
import 'package:expensiv/service/data.bese.dart';
import 'package:flutter/material.dart';

class Homeprovider extends ChangeNotifier {
  Future<void> cleareDB() async {
    try {
      await Databeseserivs.clearDB();
      expenses.clear();
      notifyListeners(); // Xatolik bo'lmasa, ishlaydi
    } catch (e) {
      print("Database tozalashda xatolik: $e");
    }
  }

  bool isloading = false;

  List<Map<String, dynamic>> category = [
    {'icon': Assets.icons.oquy, 'title': 'HOME', 'type': ExpenseCategory.home},
    {'icon': Assets.icons.vilka, 'title': 'FOOD', 'type': ExpenseCategory.food},
    {
      'icon': Assets.icons.moshina,
      'title': 'TRANSIT',
      'type': ExpenseCategory.transit,
    },
    {
      'icon': Assets.icons.oqsumka,
      'title': 'SHOP',
      'type': ExpenseCategory.shop,
    },
    {
      'icon': Assets.icons.oqchaqmo,
      'title': 'BILLS',
      'type': ExpenseCategory.bill,
    },
    {
      'icon': Assets.icons.uchnuq,
      'title': 'MORE',
      'type': ExpenseCategory.more,
    },
  ];

  int coteindex = 0;

  set setCoteIndex(int index) {
    coteindex = index;
    notifyListeners();
  }

  void cotealmash(int index) {
    coteindex = index;
    notifyListeners();
  }

  bool elevet = true;

  void income(bool isIncome) {
    elevet = isIncome;
    notifyListeners();
  }

  Future<void> send({
    required ExpenseModel expense,
    required VoidCallback onError,
    required VoidCallback onsucces,
  }) async {
    isloading = true;
    notifyListeners();

    try {
      await Databeseserivs.addExpensestoDb(
        ExpenseModel(
          value: expense.value,
          note: expense.note,
          income: expense.income,
          type: expense.type,
          createdAt: expense.createdAt ?? DateTime.now(),
        ),
      );

      isloading = false;
      notifyListeners();
      onsucces();
    } catch (e) {
      isloading = false;
      notifyListeners();
      onError();
    }
  }

  List<ExpenseModel> expenses = [];

  Future<void> getExpensesfromDb() async {
    try {
      final data = await Databeseserivs.getAllExpenses();
      expenses = data;
      notifyListeners();
    } catch (e) {
      print('Error $e');
    }
  }

  double get totalIncome {
    return expenses
        .where((e) => e.income == true)
        .fold(0.0, (sum, item) => sum + item.value);
  }

  double get totalOutcome {
    return expenses
        .where((e) => e.income == false)
        .fold(0.0, (sum, item) => sum + item.value);
  }

  double get totalBalance => totalIncome - totalOutcome;

  Future<void> deleteExpense(ExpenseModel expense) async {
    try {
      await Databeseserivs.deleteExpenseFromDb(expense.id!);
      expenses.remove(expense);
      notifyListeners();
    } catch (e) {
      print('O\'chirishda xatolik: $e');
    }
  }
}
