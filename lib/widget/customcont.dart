import 'dart:io';
import 'package:expensiv/consts/colors/color.dart';
import 'package:expensiv/models/expensmodels.dart';
import 'package:expensiv/screens/fullscreen.dart';
import 'package:expensiv/utils/category.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:open_file/open_file.dart';
import 'package:path/path.dart' as path;

class Customcont extends StatelessWidget {
  const Customcont({super.key, required this.expenseModel});

  final ExpenseModel expenseModel;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                CircleAvatar(
                  radius: 20,
                  backgroundColor: Cols.lgrey,
                  child: SvgPicture.asset(expenseModel.type.name.checkcategory),
                ),
                 SizedBox(width: 10),
                   expenseModel.image != null &&
                      path
                          .basename(expenseModel.image!)
                          .toLowerCase()
                          .endsWith('.jpg')
                  ? ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  Fullscreen(rasm: File(expenseModel.image!)),
                            ),
                          );
                        },
                        child: Image.file(
                          File(expenseModel.image!),
                          width: 40,
                          height: 40,
                          fit: BoxFit.cover,
                        ),
                      ),
                    )
                  : expenseModel.image != null
                  ? InkWell(
                      onTap: () => OpenFile.open(expenseModel.image!),
                      child: Container(
                        height: 40,
                        width: 40,
                        padding: EdgeInsets.all(6),
                        decoration: BoxDecoration(
                          color: Cols.lgrey,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Icon(Icons.insert_drive_file, size: 30),
                      ),
                    )
                  : SizedBox(),
                    SizedBox(width: 10,) ,                      
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        expenseModel.note ?? 'EMPTY',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
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
                ),
                Text(
                  '${expenseModel.income == true ? '+\$' : '-\$'}${expenseModel.value.toStringAsFixed(2)}',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: expenseModel.income == true ? Cols.green : Cols.black,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Divider(height: 1, color: Cols.lightgrey),
          ],
        ),
      ),
    );
  }
}