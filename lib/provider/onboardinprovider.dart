import 'package:flutter/material.dart';

class OnbordProvider extends ChangeNotifier {
  List<Map<String, String>> soz = [
    {
      'title': 'Track Everything',
      'subtitle':
          'Log your transactions with absolute precision. No clutter, just the data you need.',
    },
    {
      'title': 'Smart Analytics',
      'subtitle':
          'Analyze your spending habits with effortless charts. Know exactly where your money goes.',
    },
    {
      'title': 'Reach Your Goals',
      'subtitle':
          'Set monthly budgets and save up for what truly matters. Take control of your financial future.',
    },
  ];

  int pageindex = 0;

  void pagealmash(int index) {
    pageindex = index;
    notifyListeners();
  }
}
