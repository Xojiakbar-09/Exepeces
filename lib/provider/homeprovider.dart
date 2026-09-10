import 'dart:io';

import 'package:expensiv/gen/assets.gen.dart';
import 'package:expensiv/models/expensmodels.dart';
import 'package:expensiv/service/data.bese.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

class Homeprovider extends ChangeNotifier {


   
   
  File? rasm;



  Future<String?> _savePermanently(String temporaryPath) async {
    try {
      final appDir = await getApplicationDocumentsDirectory();
      final fileName = p.basename(temporaryPath);
      final savedImage = await File(
        temporaryPath,
      ).copy('${appDir.path}/$fileName');
      return savedImage.path;
    } catch (e) {
      print('Rasmni doimiy xotiraga saqlashda xatolik: $e');
      return null;
    }
  }

  Future<void> pickimage({required Function onSuccess}) async {
    try {
      final picker = ImagePicker();
      final result = await picker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 100,
      );

      if (result != null) {
        rasm = File(result.path);

        onSuccess();
        notifyListeners();
      } else {
        print('Xatolik: result null qaytdi (foydalanuvchi rasm tanlamadi)');
      }
    } catch (e) {
      print('!!! CATCH GA TUSHDI (Xato): $e');
    }
  }

  Future<void> pickimagecamera({required Function onSuccess}) async {
    try {
      final picker = ImagePicker();
      final result = await picker.pickImage(
        source: ImageSource.camera,
        imageQuality: 100,
      );
      if (result != null) {
        rasm = File(result.path);
        onSuccess();
        notifyListeners();
      }
    } catch (e) {
      print('camera xato $e');
    }
  }

  Future<void> cleareDB() async {
    try {
      await Databeseserivs.clearDB();
      expenses.clear();
      notifyListeners();
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
      String? savedImagePath;
      if (rasm != null) {
        savedImagePath = await _savePermanently(rasm!.path);
      }

      await Databeseserivs.addExpensestoDb(
        ExpenseModel(
          image: savedImagePath,
          value: expense.value,
          note: expense.note,
          income: expense.income,
          type: expense.type,
          createdAt: expense.createdAt ?? DateTime.now(),
        ),
      );

      rasm = null;
      await getExpensesfromDb();

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

  Future<void> pickFileFromFolder({required Function onSuccess}) async {
    try {
      final result = await FilePicker.pickFile(
        dialogTitle: 'Iltimos file tanlang',
      );
      if (result?.xFile != null) {
        rasm = File(result!.xFile.path);
        notifyListeners();
      }
      onSuccess();
    } catch (e) {
      print('file tanlashda xato');
    }
  }
}
