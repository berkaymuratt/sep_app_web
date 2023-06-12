import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sep_app_web/app/shared/sep_colors.dart';
import 'package:sep_app_web/app/shared/view_models/auth_view_model.dart';
import 'package:sep_app_web/locator.dart';
import 'package:sep_app_web/router/sep_router.dart';

void main() {
  setupLocator();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => AuthViewModel(),
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        title: 'SEP',
        theme: ThemeData(
          primarySwatch: SepColors.primaryColor,
        ),
        routerConfig: router,
      ),
    );
  }
}
