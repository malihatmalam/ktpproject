import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'application/core/router/router.dart';
import 'application/core/services/dropdown_service.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'data/models/penduduk/penduduk.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Hive.initFlutter();
  Hive.registerAdapter(PendudukAdapter());
  await Hive.openBox<Penduduk>('pendudukBox');

  runApp(
    ChangeNotifierProvider(
        create: (context) => DropdownService(),
        child: const MyApp(),
    )
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      routerConfig: RouterNavigation().getRoute(),
      debugShowCheckedModeBanner: false,
    );
  }
}

