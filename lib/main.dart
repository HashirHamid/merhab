import 'package:email_otp/email_otp.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mapbox_maps_flutter/mapbox_maps_flutter.dart';
import 'package:merhab/controllers/auth_controller.dart';
import 'package:merhab/controllers/place_controller.dart';
import 'package:merhab/controllers/store_controller.dart';

import 'package:merhab/screens/login_screen.dart';
import 'package:merhab/theme/themes.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

Future<void> main() async {
  await Supabase.initialize(
    url: 'https://xuappslnruqekgevplor.supabase.co',
    anonKey:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Inh1YXBwc2xucnVxZWtnZXZwbG9yIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NDQyOTgyNTQsImV4cCI6MjA1OTg3NDI1NH0.fDOlkzlwAg9VhpzCzDqwJN7i5dWNnQOkRfPodyhmFgg',
  );
  MapboxOptions.setAccessToken(
      "pk.eyJ1IjoiaGFzaGlyMTIiLCJhIjoiY2x3NTg1YWNoMWRxeDJpbXV0dXU3dDMxMiJ9.WrBZRJ6L6AnAGPJmr10leA");
  EmailOTP.config(
    appName: 'Merhab',
    otpType: OTPType.numeric,
    expiry: 30000,
    emailTheme: EmailTheme.v6,
    appEmail: 'app@merhab.com',
    otpLength: 4,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Merhab',
      theme: AppTheme.lightTheme,
      initialBinding: BindingsBuilder(() {
        Get.put(AuthController());
        Get.put(StoreController());
        Get.put(PlaceController());
      }),
      home: const LoginScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
