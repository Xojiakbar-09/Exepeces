import 'package:flutter/material.dart';

enum ExpenseCategory {
  home,
  food,
  transit,
  shop,
  bill,
  more;

  IconData get icon {
    switch (this) {
      case ExpenseCategory.home:
        return Icons.home_rounded;
      case ExpenseCategory.food:
        return Icons.restaurant_rounded;
      case ExpenseCategory.transit:
        return Icons.directions_bus_rounded;
      case ExpenseCategory.shop:
        return Icons.shopping_bag_rounded;
      case ExpenseCategory.bill:
        return Icons.receipt_long_rounded;
      case ExpenseCategory.more:
        return Icons.more_horiz_rounded;
    }
  }
}

class ExpenseModel {
  int? id; 
  double value;
  bool income;
  ExpenseCategory type;
  String? note;
  DateTime? createdAt;

  ExpenseModel({
    this.id, 
    required this.value,
    required this.income,
    required this.type,
    this.note,
    this.createdAt,
  });

  
  String get formattedCreatedAt {
    final date = createdAt ?? DateTime.now();
    final monthsUz = [
      'Yan', 'Fev', 'Mart', 'Aprel', 'May', 'Iyun',
      'Iyul', 'Avg', 'Sent', 'Okt', 'Noy', 'Dek'
    ];

    return '${date.day}-${monthsUz[date.month - 1]}';
  }

  Map<String, dynamic> toJson() => {
        if (id != null) 'id': id, 
        'value': value,
        'income': income ? 1 : 0,
        'type': type.name, 
        'note': note,
        'createdAt': (createdAt ?? DateTime.now()).toIso8601String(),
      };

  factory ExpenseModel.fromJson(Map<String, dynamic> json) {
    return ExpenseModel(
      id: json['id'] as int?, 
      value: (json['value'] as num?)?.toDouble() ?? 0.0,
      income: json['income'] == 1 || json['income'] == true,
      type: ExpenseCategory.values.firstWhere(
        (e) => e.name.toLowerCase() == json['type']?.toString().toLowerCase(),
        orElse: () => ExpenseCategory.more,
      ),
      note: json['note']?.toString(),
      createdAt: json['createdAt'] != null
          ? DateTime.tryParse(json['createdAt'].toString())
          : null,
    );
  }
}