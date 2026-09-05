import 'package:expensiv/consts/colors/color.dart';
import 'package:expensiv/gen/assets.gen.dart';
import 'package:expensiv/models/expensmodels.dart';
import 'package:expensiv/provider/homeprovider.dart';
import 'package:expensiv/screens/homepage.dart';
import 'package:expensiv/widget/customcont.dart';
import 'package:expensiv/widget/customdrower.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final GlobalKey<ScaffoldState> _globalKey = GlobalKey();
  Homeprovider get provider => context.watch<Homeprovider>();
  List<ExpenseModel> get expenses => provider.expenses;
  double get totalIncome => provider.totalIncome;
  double get totalOutcome => provider.totalOutcome;
  double get totalBalance => provider.totalBalance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _globalKey,
      drawer: Customdrower(),
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            _globalKey.currentState!.openDrawer();
          },
          icon: SvgPicture.asset(Assets.icons.manu),
        ),
        centerTitle: true,
        title: Text(
          'Overview',
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        ),
        actionsPadding: EdgeInsets.only(right: 20),
        actions: [SvgPicture.asset(Assets.icons.profile)],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  SizedBox(height: 56),
                  Text(
                    'TOTAL BALANCE',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: Cols.grey,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        '\$',
                        style: GoogleFonts.jetBrainsMono(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        totalBalance.toStringAsFixed(2),
                        style: GoogleFonts.jetBrainsMono(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 24),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          fixedSize: Size(124, 34),
                          backgroundColor: Cols.black,
                        ),
                        onPressed: () async {
                          await Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => Homepage()),
                          );
                          if (context.mounted) {
                            context.read<Homeprovider>().getExpensesfromDb();
                          }
                        },
                        child: Text(
                          'ADD FUNDS',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      SizedBox(width: 16),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          fixedSize: Size(85, 34),
                          backgroundColor: Cols.lgrey,
                        ),
                        onPressed: () {},
                        child: Text(
                          'SEND',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: Cols.black,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 86),
                  Row(
                    children: [
                      Expanded(
                        child: SizedBox(
                          height: 45,
                          child: Row(
                            children: [
                              Container(
                                height: 45,
                                margin: EdgeInsets.only(right: 16),
                                width: 1,
                                color: Cols.green,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.arrow_downward,
                                        color: Cols.lightgrey,
                                        size: 20,
                                      ),
                                      Text(
                                        'INCOME',
                                        style: GoogleFonts.jetBrainsMono(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w600,
                                          color: Cols.lightgrey,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        '+\$',
                                        style: GoogleFonts.jetBrainsMono(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500,
                                          color: Cols.black,
                                        ),
                                      ),
                                      Text(
                                        totalIncome.toStringAsFixed(2),
                                        style: GoogleFonts.jetBrainsMono(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500,
                                          color: Cols.black,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        child: SizedBox(
                          height: 45,
                          child: Row(
                            children: [
                              Container(
                                height: 45,
                                margin: EdgeInsets.only(right: 16),
                                width: 1,
                                color: Cols.red,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.arrow_upward,
                                        color: Cols.lightgrey,
                                        size: 20,
                                      ),
                                      Text(
                                        'OUTCOME',
                                        style: GoogleFonts.jetBrainsMono(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w600,
                                          color: Cols.lightgrey,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        '-\$',
                                        style: GoogleFonts.jetBrainsMono(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500,
                                          color: Cols.black,
                                        ),
                                      ),
                                      Text(
                                        totalOutcome.toStringAsFixed(2),
                                        style: GoogleFonts.jetBrainsMono(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500,
                                          color: Cols.black,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 48, bottom: 36),
                    child: Row(
                      children: [
                        Text(
                          'Recent Transactions',
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: Cols.black,
                          ),
                        ),
                        Spacer(),
                        Text(
                          'VIEW ALL',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: Cols.lightgrey,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            expenses.isEmpty
                ? Center(
                  child: SizedBox(
                    height: 200,
                    width: 200,
                    child: Lottie.asset(Assets.lottie.box),
                  ),
                )
                : ListView.builder(
                    reverse: true,
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: expenses.length,
                    itemBuilder: (context, index) {
                      final item = expenses[index];
                      return
                      CupertinoContextMenu.builder(
                        actions: [
                          CupertinoContextMenuAction(
                            onPressed: () {
                              context.read<Homeprovider>().deleteExpense(item);
                              Navigator.pop(context);
                            },
                            child: Text("O'chirish"),
                          ),
                        ],
                        builder: (context, animation) =>
                            Customcont(expenseModel: item),
                            
                      );

                      // );
                    },
                  ),
            SizedBox(height: 100),
          ],
        ),
      ),
    );
  }
}
