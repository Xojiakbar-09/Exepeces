import 'dart:io';
import 'package:expensiv/consts/colors/color.dart';
import 'package:expensiv/gen/assets.gen.dart';
import 'package:expensiv/models/expensmodels.dart';
import 'package:expensiv/provider/homeprovider.dart';
import 'package:expensiv/screens/fullscreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:open_file/open_file.dart';
import 'package:provider/provider.dart';
import 'package:path/path.dart' as path;

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
    WidgetsBinding.instance.addPostFrameCallback((_) {
    context.read<Homeprovider>().clearImage();
  });
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<Homeprovider>();
    return Scaffold(
      appBar: AppBar(
        leading: Padding(
          padding: EdgeInsets.all(20),
          child: GestureDetector(
            onTap: () => Navigator.pop(context),
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
            onPressed: () async {
              final double? parsedValue = double.tryParse(
                _valueController.text,
              );

              if (parsedValue == null) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Iltimos, to\'g\'ri summa kiriting')),
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
                    SnackBar(content: Text('Saqlashda xatolik yuz berdi')),
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
        padding: EdgeInsets.symmetric(horizontal: 20),
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
                  Padding(
                    padding: EdgeInsets.only(top: 18),
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
                      keyboardType: TextInputType.numberWithOptions(
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
              SizedBox(height: 48),
              Container(
                height: 50,
                width: 260,
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
                        fixedSize: Size(124, 42),
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
                          color: provider.elevet ? Cols.white : Cols.black,
                        ),
                      ),
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        elevation: 0,
                        shadowColor: Colors.transparent,
                        side: BorderSide.none,
                        fixedSize: Size(124, 42),
                        backgroundColor: !provider.elevet
                            ? Cols.black
                            : Cols.lgrey,
                      ),
                      onPressed: () {
                        context.read<Homeprovider>().income(false);
                      },
                      child: Text(
                        'Expend',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: !provider.elevet ? Cols.white : Cols.black,
                        ),
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
                  provider.category.length,
                  (index) => SizedBox(
                    child: Column(
                      children: [
                        GestureDetector(
                          onTap: () {
                            context.read<Homeprovider>().cotealmash(index);
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
                        SizedBox(height: 8),
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
              SizedBox(height: 24),
              TextFormField(
                controller: _noteController,
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
              SizedBox(height: 20),
              Container(
                margin: EdgeInsets.only(bottom: 10),
                padding: EdgeInsets.symmetric(horizontal: 7),
                decoration: BoxDecoration(
                  color: Cols.lgrey,
                  borderRadius: BorderRadius.circular(40),
                ),
                child: TextButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: Text(
                          'Insert Image from ?',
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.w500,
                            color: Cols.black,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        content: Row(
                          spacing: 5,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadiusGeometry.circular(20),
                              child: TextButton(
                                onPressed: () {
                                  context.read<Homeprovider>().pickimage(
                                    onSuccess: () {
                                      Navigator.pop(context);
                                    },
                                  );
                                },
                                child: Text(
                                  'Gallery',
                                  style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w500,
                                    color: Cols.black,
                                  ),
                                ),
                              ),
                            ),
                            ClipRRect(
                              borderRadius: BorderRadiusGeometry.circular(20),
                              child: TextButton(
                                onPressed: () {
                                  context
                                      .read<Homeprovider>()
                                      .pickFileFromFolder(
                                        onSuccess: () {
                                          Navigator.pop(context);
                                        },
                                      );
                                },
                                child: Text(
                                  'File',
                                  style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w500,
                                    color: Cols.black,
                                  ),
                                ),
                              ),
                            ),
                            ClipRRect(
                              borderRadius: BorderRadiusGeometry.circular(20),
                              child: TextButton(
                                onPressed: () {
                                  context.read<Homeprovider>().pickimagecamera(
                                    onSuccess: () {
                                      Navigator.pop(context);
                                    },
                                  );
                                },
                                child: Text(
                                  'Camera',
                                  style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w500,
                                    color: Cols.black,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                  child: Text(
                    'Insert Image +',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                      color: Cols.black,
                    ),
                  ),
                ),
              ),
              provider.rasm != null &&
                      path
                          .basename(provider.rasm!.path)
                          .toLowerCase()
                          .endsWith('.jpg')
                  ? ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  Fullscreen(rasm: provider.rasm!),
                            ),
                          );
                        },
                        child: Hero(
                          tag: 'rasm1',
                          child: Image.file(
                            File(provider.rasm!.path),
                            width: 250,
                            height: 200,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),  
                    )
                  : provider.rasm != null
                  ? InkWell(
                      onTap: () => OpenFile.open(provider.rasm!.path),
                      child: Container(
                        height: 50,
                        width: 50,
                        padding: EdgeInsets.all(6),
                        decoration: BoxDecoration(
                          color: Cols.lgrey,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Icon(Icons.insert_drive_file, size: 30),
                      ),
                    )
                  : SizedBox(),
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
