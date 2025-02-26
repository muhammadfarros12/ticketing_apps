import 'package:flutter/material.dart';
import 'package:ticketing_apps/core/assets/assets.gen.dart';
import 'package:ticketing_apps/core/extensions/build_context_ext.dart';
import 'package:ticketing_apps/ui/auth/login_screen.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Future.delayed(
      Duration(seconds: 2),
      () => context.pushReplacement(LoginScreen()),
    );
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(96.0),
        child: Center(child: Assets.images.logoBlue.image()),
      ),
      bottomNavigationBar: SizedBox(
        height: 100,
        child: Assets.images.logo.image(width: 96),
      ),
    );
  }
}
