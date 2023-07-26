import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void main() async {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'HomePage',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.cyan,
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);

  final TextStyle labelStyle = GoogleFonts.poppins(
    fontWeight: FontWeight.w500,
    fontSize: 16,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Start healthy'),
        titleTextStyle: labelStyle,
        centerTitle: true,
        primary: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 50),
            child: Column(
              children: <Widget>[
                Image.asset(
                  'assets/main_logo.png', // Replace 'assets/main_logo.png' with your image path
                  width: 400,
                  height: 300,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
