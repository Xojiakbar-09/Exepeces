import 'package:expensiv/consts/colors/color.dart';
import 'package:expensiv/gen/assets.gen.dart';
import 'package:expensiv/models/expensmodels.dart';
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
  final TextEditingController _valueController = TextEditingController();
  final TextEditingController _noteController = TextEditingController();

  @override
  void dispose() {
    _valueController.dispose();
    _noteController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Single provider wrap at root level
    return ChangeNotifierProvider(
      create: (context) => Homeprovider(),
      child: Builder(
        builder: (context) {
          final provider = context.watch<Homeprovider>();

          return Scaffold(
            appBar: AppBar(
              leading: Padding(
                padding: const EdgeInsets.all(20),
                child: GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: SvgPicture.asset(Assets.icons.x),
                ),
              ),
              centerTitle: true,
              title: const Text(
                'New Entry',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.w700),
              ),
              actionsPadding: const EdgeInsets.only(right: 12),
              actions: [
                TextButton(
                  onPressed: () async {
                    final double? parsedValue =
                        double.tryParse(_valueController.text);

                    if (parsedValue == null) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Iltimos, to\'g\'ri summa kiriting'),
                        ),
                      );
                      return;
                    }

                    final selectedCategory =
                        provider.category[provider.coteindex]['type'] ??
                            ExpenseCategory.home;

                    context.read<Homeprovider>().send(
                          expense: ExpenseModel(
                            value: parsedValue,
                            income: provider.elevet,
                            type: selectedCategory,
                            note: _noteController.text,
                            createdAt: DateTime.now(),
                          ),
                          onError: () {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Saqlashda xatolik yuz berdi'),
                              ),
                            );
                          },
                          onsucces: () {
                            Navigator.pop(context);
                          },
                        );
                  },
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
            body: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(height: 48),
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
                        Padding(
                          padding: const EdgeInsets.only(top: 18),
                          child: Text(
                            '\$',
                            style: GoogleFonts.jetBrainsMono(
                              fontSize: 22,
                              fontWeight: FontWeight.w600,
                              color: Colors.black,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 64,
                          width: 160,
                          child: TextFormField(
                            controller: _valueController,
                            keyboardType: const TextInputType.numberWithOptions(
                              decimal: true,
                            ),
                            textAlign: TextAlign.center,
                            style: GoogleFonts.jetBrainsMono(
                              fontSize: 56,
                              fontWeight: FontWeight.w500,
                              color: Colors.black,
                              letterSpacing: 2,
                            ),
                            decoration: InputDecoration(
                              hintText: '0.00',
                              hintStyle: GoogleFonts.jetBrainsMono(
                                fontSize: 56,
                                fontWeight: FontWeight.w500,
                                color: Colors.black,
                                letterSpacing: 2,
                              ),
                              border: InputBorder.none,
                              enabledBorder: InputBorder.none,
                              focusedBorder: InputBorder.none,
                              contentPadding: EdgeInsets.zero,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 48),
                    Container(
                      height: 45,
                      width: 248,
                      decoration: BoxDecoration(
                        color: Cols.lgrey,
                        borderRadius: BorderRadius.circular(40),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              elevation: 0,
                              shadowColor: Colors.transparent,
                              side: BorderSide.none,
                              fixedSize: const Size(124, 42),
                              backgroundColor: provider.elevet
                                  ? Cols.black
                                  : Cols.lgrey,
                            ),
                            onPressed: () {
                              context.read<Homeprovider>().income(true);
                            },
                            child: Text(
                              'INCOME',
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: provider.elevet
                                    ? Cols.white
                                    : Cols.black,
                              ),
                            ),
                          ),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              elevation: 0,
                              shadowColor: Colors.transparent,
                              side: BorderSide.none,
                              fixedSize: const Size(124, 42),
                              backgroundColor: !provider.elevet
                                  ? Cols.black
                                  : Cols.lgrey,
                            ),
                            onPressed: () {
                              context.read<Homeprovider>().income(false);
                            },
                            child: Text(
                              'OUTCOME',
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: !provider.elevet
                                    ? Cols.white
                                    : Cols.black,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 48),
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
                      margin: const EdgeInsets.only(top: 8),
                      width: double.infinity,
                      color: Cols.grey,
                    ),
                    const SizedBox(height: 24),
                    Wrap(
                      spacing: 16,
                      runAlignment: WrapAlignment.start,
                      runSpacing: 16,
                      children: List.generate(
                        provider.category.length,
                        (index) => SizedBox(
                          child: Column(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  context
                                      .read<Homeprovider>()
                                      .cotealmash(index);
                                },
                                child: CircleAvatar(
                                  radius: 28,
                                  backgroundColor: provider.coteindex == index
                                      ? Cols.black
                                      : Cols.lgrey,
                                  child: SvgPicture.asset(
                                    provider.category[index]['icon'],
                                    colorFilter: ColorFilter.mode(
                                      provider.coteindex == index
                                          ? Cols.white
                                          : Cols.grey,
                                      BlendMode.srcIn,
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                provider.category[index]['title'],
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
                    const SizedBox(height: 24),
                    TextFormField(
                      controller: _noteController,
                      cursorColor: Cols.grey,
                      cursorWidth: 1,
                      decoration: InputDecoration(
                        border: const OutlineInputBorder(
                          borderSide: BorderSide.none,
                        ),
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
                    const SizedBox(height: 100),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}