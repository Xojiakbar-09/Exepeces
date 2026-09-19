import 'package:audio_service/audio_service.dart';
import 'package:expensiv/consts/themes/theme.dart';
import 'package:expensiv/provider/homeprovider.dart';
import 'package:expensiv/screens/splesh.dart';
import 'package:expensiv/service/audioservis.dart';
import 'package:expensiv/service/data.bese.dart';
import 'package:expensiv/service/internetsarves.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:provider/provider.dart';

final GlobalKey<NavigatorState> navigatorkey = GlobalKey();

late AudioPlayerHandler audioHandler;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  audioHandler = await AudioService.init(
    builder: () => AudioPlayerHandler(),
    config: const AudioServiceConfig(
      androidNotificationChannelId: 'com.example.expensiv.channel.audio',
      androidNotificationChannelName: 'Audio Service',
      androidNotificationOngoing: true,
    ),
  );

  WidgetsFlutterBinding.ensureInitialized();
  await Databeseserivs.init('expenses');
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => Homeprovider()..getExpensesfromDb(),
        ),
      ],
      child: const MainApp(),
    ),
  );
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  @override
  void initState() {
    super.initState();
    Internetsarves.lisenConnetion();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: navigatorkey,
      debugShowCheckedModeBanner: false,
      title: 'Exspenses',
      theme: Apptheme.light,
      home: Splesh(),
    );
  }
}
