import 'package:flutter/material.dart';

import 'package:merhab/screens/home_screen.dart';
import 'package:merhab/screens/login_screen.dart';
import 'package:merhab/screens/signup_screen.dart';
import 'package:merhab/theme/themes.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Merhab',
      theme: AppTheme.lightTheme,
      home: const LoginScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
