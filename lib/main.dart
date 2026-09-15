import 'package:audio_service/audio_service.dart';
import 'package:expensiv/consts/themes/theme.dart';
import 'package:expensiv/provider/homeprovider.dart';
import 'package:expensiv/screens/home.dart';
import 'package:expensiv/service/audioservis.dart';
import 'package:expensiv/service/data.bese.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

late AudioPlayerHandler audioHandler;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

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
