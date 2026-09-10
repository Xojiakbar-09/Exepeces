import 'package:expensiv/consts/themes/theme.dart';
import 'package:expensiv/provider/homeprovider.dart';
import 'package:expensiv/screens/home.dart';
import 'package:expensiv/service/data.bese.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Databeseserivs.init('expenses');
  runApp(
    
   MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => Homeprovider() .. getExpensesfromDb()),
      ],
      child: const MainApp(),
    ),
    );
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Exspenses',
      theme: Apptheme.light,
      home: Home(),
    );  
  }
}
