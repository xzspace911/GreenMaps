import 'package:flutter/material.dart';
import 'package:flutter_maps/presentation/screens/auth/create_an_account.dart';
import 'package:flutter_maps/presentation/screens/auth/login_screen.dart';
import 'package:flutter_maps/presentation/screens/ui/home_screen.dart';
import 'package:flutter_maps/presentation/screens/ui/on_boarding_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const OnBoardingScreen(),
      routes: {
        '/createAnAccount': (context) => CreateAnAccount(),
        '/login': (context) => LoginScreen(),
        '/home_screen': (context) => HomeScreen(),
      },
    );
  }
}
