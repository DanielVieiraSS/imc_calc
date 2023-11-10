////
//// Dupla
//// Nome: Daniel
//// RA: 1431432312007
////
//// Nome: Victor Hugo
//// RA: 1431432312001

import 'package:flutter/material.dart';
import 'package:imc_calc/home.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      home: const Home(),
    );
  }
}
