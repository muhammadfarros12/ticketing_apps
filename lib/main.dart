import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ticketing_apps/core/constants/color.dart';
import 'package:ticketing_apps/data/localdatasources/product_local_datasource.dart';
import 'package:ticketing_apps/data/remotedatasources/auth_remote_datasource.dart';
import 'package:ticketing_apps/data/remotedatasources/product_remote_datasource.dart';
import 'package:ticketing_apps/ui/auth/bloc/login/auth_bloc.dart';
import 'package:ticketing_apps/ui/auth/splash_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ticketing_apps/ui/home/bloc/checkout/checkout_bloc.dart';
import 'package:ticketing_apps/ui/home/bloc/order/order_bloc.dart';
import 'package:ticketing_apps/ui/home/bloc/product/product_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => AuthBloc(AuthRemoteDatasource())),
        BlocProvider(create: (context) => CheckoutBloc()),
        BlocProvider(create: (context) => OrderBloc()),
        BlocProvider(create: (context) {
          final remote = ProductRemoteDatasource();
          final local = ProductLocalDatasource.instance;

          final bloc = ProductBloc(remote, local);
          bloc.add(ProductEvent.syncProducts());
          return bloc;
        }),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: AppColors.primary),
          dialogTheme: DialogTheme(elevation: 0),
          textTheme: GoogleFonts.plusJakartaSansTextTheme(
            Theme.of(context).textTheme,
          ),
          appBarTheme: AppBarTheme(
            color: Colors.white,
            elevation: 0,
            titleTextStyle: GoogleFonts.plusJakartaSans(
              color: AppColors.primary,
              fontSize: 18,
              fontWeight: FontWeight.w500,
            ),
            iconTheme: IconThemeData(color: AppColors.black),
            centerTitle: true,
          ),
        ),
        home: SplashScreen(),
      ),
    );
  }
}
