import 'package:expensiv/consts/colors/color.dart';
import 'package:expensiv/models/expensmodels.dart';
import 'package:expensiv/utils/category.dart';
import 'package:expensiv/utils/size.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Customcont extends StatelessWidget {
  const Customcont({super.key, required this.expenseModel});

  final ExpenseModel expenseModel;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      child: Container(
        width: context.width,
        height: context.height * 0.1,
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        child: Column(
          children: [
            Row(
              spacing: 16,
              children: [
                CircleAvatar(
                  radius: 20,
                  backgroundColor: Cols.lgrey,
                  child: SvgPicture.asset(expenseModel.type.name.checkcategory),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      expenseModel.note ?? 'EMPTIY',
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
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
            SizedBox(height: 10),
             Divider(height: 1, color: Cols.lightgrey),
          ],
        ),
      ),
    );
  }
}
