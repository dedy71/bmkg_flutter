import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:test_bmkg/pages/pages.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    statusBarBrightness: Brightness.light,
    statusBarIconBrightness: Brightness.light,
  ));

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'BMKG Demo',
      theme: ThemeData(
          useMaterial3: true,
          primarySwatch: Colors.blue,
          fontFamily: GoogleFonts.openSans().fontFamily),
      home: const HomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}
