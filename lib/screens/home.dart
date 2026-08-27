import 'package:expensiv/consts/colors/color.dart';
import 'package:expensiv/gen/assets.gen.dart';
import 'package:expensiv/screens/homepage.dart';
import 'package:expensiv/widget/customcont.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.all(19),
          child: SvgPicture.asset(Assets.icons.manu),
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
              padding: const EdgeInsets.symmetric(horizontal: 20),
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
                  Text(
                    '\$12,450.00',
                    style: GoogleFonts.jetBrainsMono(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 24),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    spacing: 16,
                    children: [
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          fixedSize: Size(124, 34),
                          backgroundColor: Cols.black,
                        ),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => Homepage()),
                          );
                        },
                        child: Text(
                          'ADD FUNDS',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
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
                                  Text(
                                    '+\$4,200.50',
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
                                  Text(
                                    '-\$1,840.00',
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
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 48, bottom: 36),
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
            Customcont(
              widget: SvgPicture.asset(Assets.icons.sumka),
              title: 'Whole Foods Market',
              subtitle: 'Groceries • Today',
              pul: '-\$142.30',
            ),
            Customcont(
              widget: SvgPicture.asset(Assets.icons.pul),
              title: 'Acme Corp Salary',
              subtitle: 'Income • Yesterday',
              pul: '+\$3,500.00',
            ),
            Customcont(
              widget: SvgPicture.asset(Assets.icons.chaqmo),
              title: 'Electric Utility',
              subtitle: 'Bills • Jun 12',
              pul: '-\$85.00',
            ),
            Customcont(
              widget: SvgPicture.asset(Assets.icons.choy),
              title: 'Artisan Roasters',
              subtitle: 'Dining • Jun 11',
              pul: '-\$6.50',
            ),
            SizedBox(height: 100,)
          ],
        ),
      ),
    );
  }
}
