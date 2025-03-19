import 'package:flutter/material.dart';
import 'package:ticketing_apps/core/assets/assets.gen.dart';
import 'package:ticketing_apps/core/components/spaces.dart';
import 'package:ticketing_apps/data/localdatasources/auth_local_datasource.dart';
import 'package:ticketing_apps/ui/auth/login_screen.dart';
import 'package:ticketing_apps/ui/home/main_screen.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: Future.delayed(
          Duration(seconds: 3),
          () => AuthLocalDatasource().isLogin(),
        ),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.data == true) {
              return MainScreen();
            } else {
              return LoginScreen();
            }
          }
          return Stack(
            children: [
              Column(
                children: [
                  Spacer(),
                  Padding(
                    padding: const EdgeInsets.all(96),
                    child: Assets.images.logoBlue.image(),
                  ),
                  Spacer(),
                  Center(
                    child: CircularProgressIndicator(
                      color: Colors.deepOrangeAccent,
                    ),
                  ),
                  SpaceHeight(40),
                  SizedBox(
                    height: 100,
                    child: Align(
                      alignment: Alignment.center,
                      child: Assets.images.logo.image(width: 96),
                    ),
                  ),
                ],
              ),
            ],
          );
        },
      ),
    );
  }
}
