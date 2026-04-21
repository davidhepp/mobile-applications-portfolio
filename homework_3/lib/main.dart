import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'splash_page.dart';

void main() {
  runApp(const CoffeeShopApp());
}

class CoffeeShopApp extends StatelessWidget {
  const CoffeeShopApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Caffe Lento',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFFC67C4E)),
        scaffoldBackgroundColor: const Color(0xFFFCF8F3),
        textTheme: GoogleFonts.soraTextTheme(),
        appBarTheme: AppBarTheme(
          titleTextStyle: GoogleFonts.sora(
            fontSize: 20,
            fontWeight: FontWeight.w600,
            color: Colors.black,
          ),
        ),
      ),
      home: const SplashPage(),
    );
  }
}
