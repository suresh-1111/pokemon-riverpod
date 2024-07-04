import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_it/get_it.dart';
import 'dart:ui';

import 'package:pokemon_riverpod/pages/home_page.dart';
import 'package:pokemon_riverpod/services/database_service.dart';
import 'package:pokemon_riverpod/services/http_service.dart';

void main() async {
  await _setupServices();
  runApp(const MyApp());
}

Future<void> _setupServices() async{

  GetIt.instance.registerSingleton<HTTPService>(HTTPService(),
  );
  GetIt.instance.registerSingleton<DatabaseService>(DatabaseService(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ProviderScope(
      child: MaterialApp(
        title: 'Pokemon riverpod',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
      
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.lightGreen),
          useMaterial3: true,

        ),
        home: const HomePage(),
      ),
    );
  }
}


