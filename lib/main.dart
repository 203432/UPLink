import 'package:flutter/material.dart';
import 'package:uplink/onboarding/onboarding.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: const Color(0xFF712F94),
      ),
      home: const Onboarding(),
    );
  }
}
