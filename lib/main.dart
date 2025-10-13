import 'package:fake_store_lyqx/core/di/get_it.dart';
import 'package:fake_store_lyqx/core/navigation/app_router.dart';
import 'package:flutter/material.dart';

void main() {
  setupLocator();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(title: 'Fake Store', routerConfig: router);
  }
}
