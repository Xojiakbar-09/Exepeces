import 'package:expensiv/gen/assets.gen.dart';
import 'package:expensiv/models/expensmodels.dart';

extension Typeextesion on String {
  String get checkcategory {
    if (this == ExpenseCategory.bill.name) {
      return Assets.icons.chaqmo;
    } else if (this == ExpenseCategory.food.name) {
      return Assets.icons.vilka;
    } else if (this == ExpenseCategory.home.name) {
      return Assets.icons.qorahome;
    } else if (this == ExpenseCategory.more.name) {
      return Assets.icons.uchnuq;
    } else if (this == ExpenseCategory.shop.name) {
      return Assets.icons.oqsumka;
    } else {
      return Assets.icons.moshina;
    }
  }
}
