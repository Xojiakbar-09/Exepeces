import 'package:expensiv/consts/colors/color.dart';
import 'package:expensiv/models/expensmodels.dart';
import 'package:expensiv/provider/homeprovider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Customcont extends StatelessWidget {
  const Customcont({super.key, required this.expenseModel});

  final ExpenseModel expenseModel;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => Homeprovider(),
      child: Builder(
        builder: (context) {
          return Column(
            children: [
              Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                child: Row(
                  spacing: 16,
                  children: [
                    CircleAvatar(
                      radius: 20,
                      backgroundColor: Cols.lgrey,
                      child: Icon(
                        expenseModel.type.icon,
                        color: Cols.black,
                        size: 20,
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          expenseModel.note ?? 'EMPTIY',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        Row(
                         
                          children: [
                            Text(
                              expenseModel.type.name.toUpperCase(),
                              style: TextStyle(
                                color: Cols.lightgrey,
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                              Text(
                              ' • ',
                              style: TextStyle(
                                color: Cols.lightgrey,
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                              ),
                            ),

                            Text(
                              expenseModel.formattedCreatedAt,
                              style: TextStyle(
                                color: Cols.lightgrey,
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    Spacer(),
                    Row(
                      children: [
                        Text(
                          expenseModel.income == true ? '+\$' : '-\$',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: expenseModel.income == true
                                ? Cols.green
                                : Cols.black,
                          ),
                        ),
                        Text(
                          expenseModel.value.toStringAsFixed(2),
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: expenseModel.income == true
                                ? Cols.green
                                : Cols.black,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    height: 1,
                    width: MediaQuery.sizeOf(context).width * 0.9,
                    color: Cols.lightgrey,
                  ),
                ],
              ),
              
            ],
          );
        },
      ),
    );
  }
}
