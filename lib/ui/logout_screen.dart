import 'package:flutter/material.dart';
import 'package:ticketing_apps/core/extensions/build_context_ext.dart';
import 'package:ticketing_apps/data/localdatasources/auth_local_datasource.dart';
import 'package:ticketing_apps/ui/auth/splash_screen.dart';

class LogoutScreen extends StatelessWidget {
  const LogoutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Logout')),
      body: Center(
        child: ElevatedButton(onPressed: () async {
          await AuthLocalDatasource().removeAuthToken();
          context.pushReplacement(SplashScreen());
        }, child: Text('Logout')),
      ),
    );
  }
}
