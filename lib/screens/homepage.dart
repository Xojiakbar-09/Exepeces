import 'package:expensiv/consts/colors/color.dart';
import 'package:expensiv/gen/assets.gen.dart';
import 'package:expensiv/provider/homeprovider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.all(20),
          child: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: SvgPicture.asset(Assets.icons.x),
          ),
        ),
        centerTitle: true,
        title: Text(
          'New Entry',
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.w700),
        ),
        actionsPadding: EdgeInsets.only(right: 12),
        actions: [
          TextButton(
            onPressed: () {},
            child: Text(
              'Save',
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: Cols.black,
              ),
            ),
          ),
        ],
      ),
      body: ChangeNotifierProvider(
        create: (context) => Homeprovider(),
        child: Builder(
          builder: (context) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: 48),
                    Text(
                      'AMOUNT',
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
                          "\$",
                          style: GoogleFonts.jetBrainsMono(
                            fontSize: 22,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Text(
                          '0.00',
                          style: GoogleFonts.jetBrainsMono(
                            fontSize: 56,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 48),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.symmetric(horizontal: 5),
                        fixedSize: Size(256, 48),
                        backgroundColor: Cols.lgrey,
                      ),
                      onPressed: () {},
                      child: Row(
                        children: [
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              fixedSize: Size(124, 42),
                              backgroundColor: Cols.black,
                            ),
                            onPressed: () {},
                            child: Text(
                              'EXPENSE',
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: Cols.white,
                              ),
                            ),
                          ),
                          SizedBox(width: 20),
                          Text(
                            'INCOME',
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: Cols.grey,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 48),
                    Row(
                      children: [
                        Text(
                          'CATEGORY',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: Cols.grey,
                          ),
                        ),
                      ],
                    ),
                    Container(
                      height: 1,
                      margin: EdgeInsets.only(top: 8),
                      width: double.infinity,
                      color: Cols.grey,
                    ),
                    SizedBox(height: 24),
                    Wrap(
                      spacing: 16,
                      runAlignment: WrapAlignment.start,
                      runSpacing: 16,
                      children: List.generate(
                        context.watch<Homeprovider>().category.length,
                        (index) => SizedBox(
                          child: Column(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  context.read<Homeprovider>().coteindex =
                                      index;
                                  setState(() {});
                                },
                                child: CircleAvatar(
                                  radius: 28,
                                  backgroundColor:
                                      context.read<Homeprovider>().coteindex ==
                                          index
                                      ? Cols.black
                                      : Cols.lgrey,
                                  // ignore: deprecated_member_use
                                  child: SvgPicture.asset(
                                    context
                                        .watch<Homeprovider>()
                                        .category[index]['icon'],
                                    color:
                                        context
                                                .read<Homeprovider>()
                                                .coteindex ==
                                            index
                                        ? Cols.white
                                        : Cols.grey,
                                  ),
                                ),
                              ),
                              SizedBox(height: 8),
                              Text(
                                context
                                    .watch<Homeprovider>()
                                    .category[index]['title'],
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  color: Cols.grey,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    TextFormField(
                      keyboardType: TextInputType.number,
                      cursorColor: Cols.grey,
                      cursorWidth: 1,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(borderSide: BorderSide.none),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(width: 1, color: Cols.grey),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(width: 1, color: Cols.grey),
                        ),

                        hintText: 'ADD NOTE',
                        hintStyle: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w400,
                          color: Cols.grey,
                        ),
                      ),
                    ),
                    SizedBox(height: 100),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
