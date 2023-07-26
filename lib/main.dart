import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:local_foodie/Database/db_handler.dart';
import 'login.dart';
import 'signup.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  /*await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );*/
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
                const SizedBox(
                  height: 10,
                ), // Adjust the spacing between image and buttons
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const LoginScreen(),
                            ),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                              Colors.white, // White color for Google button
                          foregroundColor: Colors
                              .black, // Black text color for Google button
                          side: const BorderSide(
                              color: Colors
                                  .black), // Black border for Google button
                        ),
                        child: Text(
                          'Login',
                          style: labelStyle,
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ), // Adjust the gap between buttons
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const SignupScreen(),
                            ),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.black,
                          backgroundColor: Colors
                              .yellow, // Black text color for Facebook button
                        ),
                        child: Text(
                          'Signup',
                          style: labelStyle,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ), // Adjust the spacing between buttons and Google button
                ElevatedButton.icon(
                  onPressed: () {
                    // Handle "Continue with Google" button press
                  },
                  icon: const Icon(Icons.login),
                  label: Text(
                    'Continue with Google',
                    style: labelStyle,
                  ),
                ),
                const SizedBox(height: 20),
                ElevatedButton.icon(
                  onPressed: () {
                    // Handle "Continue with Facebook" button press
                  },
                  icon: const Icon(Icons.login),
                  label: Text(
                    'Continue with Facebook',
                    style: labelStyle,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
