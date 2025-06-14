import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:waroeng_kita/controllers/scale_factor_controller.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    // Use addPostFrameCallback to ensure the context is available
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final scaleController = Provider.of<ScaleFactorController>(
        context,
        listen: false,
      );
      scaleController.initScaleHelper(context);

      Future.delayed(const Duration(seconds: 3), () {
        Navigator.pushReplacementNamed(context, '/onboarding');
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final scaleHelper = Provider.of<ScaleFactorController>(context).scaleHelper;

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            transform: GradientRotation(
              169 * 3.1416 / 180,
            ), // 169 degrees to radians
            colors: [Color(0xFF1D4AAA), Color(0xFF7DC3F7)],
          ),
        ),
        child: Center(
          child: Image.asset(
            'assets/images/logo.png',
            width: scaleHelper.scaleWidth(100),
          ),
        ),
      ),
    );
  }
}
