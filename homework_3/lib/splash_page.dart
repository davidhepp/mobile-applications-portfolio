import 'package:flutter/material.dart';
import 'landingpage.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    _goToLanding();
  }

  Future<void> _goToLanding() async {
    await Future<void>.delayed(const Duration(milliseconds: 2340));   // Splash screen duration
    if (!mounted) {
      return;
    }
    Navigator.of(context).pushReplacement(
      _SmoothMaterialPageRoute<void>(
        builder: (_) => const LandingPage(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final logoWidth = (width * 0.90).clamp(288.0, 456.0).toDouble();  //  Splash screen logo width with 90% of screen width, constrained between 288 and 456 pixels

    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Image.asset(
            'assets/images/logo.png',
            width: logoWidth,
            fit: BoxFit.contain,
          ),
        ),
      ),
    );
  }
}

class _SmoothMaterialPageRoute<T> extends MaterialPageRoute<T> {
  _SmoothMaterialPageRoute({required super.builder});

  @override
  Duration get transitionDuration => const Duration(milliseconds: 720);

  @override
  Duration get reverseTransitionDuration => const Duration(milliseconds: 450);
}
