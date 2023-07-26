// ignore_for_file: library_private_types_in_public_api
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Login Page',
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Existing Customer'),
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    'Login',
                    style: GoogleFonts.poppins(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 20),
                  EmailEntryWidget(emailController: _emailController),
                  const SizedBox(height: 20),
                  PhoneEntryWidget(phoneController: _phoneController),
                  const SizedBox(height: 20),
                  PasswordEntryWidget(passwordController: _passwordController),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {}
                    },
                    child: Text(
                      'Login',
                      style: GoogleFonts
                          .poppins(), // Apply Poppins font to the button text
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class EmailEntryWidget extends StatelessWidget {
  const EmailEntryWidget({Key? key, required this.emailController})
      : super(key: key);

  final TextEditingController emailController;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: emailController,
      keyboardType: TextInputType.emailAddress,
      decoration: const InputDecoration(
        labelText: 'Enter your Email',
        contentPadding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
        border: OutlineInputBorder(),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter your Email';
        }
        return null;
      },
    );
  }
}

class PhoneEntryWidget extends StatelessWidget {
  const PhoneEntryWidget({Key? key, required this.phoneController})
      : super(key: key);

  final TextEditingController phoneController;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: phoneController,
      keyboardType: TextInputType.phone,
      maxLength: 12, // Maximum allowed digits (including "+")
      inputFormatters: [
        LengthLimitingTextInputFormatter(10), // To limit the length
        FilteringTextInputFormatter.digitsOnly, // To allow only digits
      ],
      decoration: const InputDecoration(
          labelText: 'Enter your Phone Number',
          contentPadding:
              EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
          border: OutlineInputBorder(),
          prefixText: '+91 ',
          counterText: ''),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter your Phone Number';
        }
        if (value.length < 4) {
          return 'Invalid phone number';
        }
        return null;
      },
    );
  }
}

class PasswordEntryWidget extends StatefulWidget {
  const PasswordEntryWidget({Key? key, required this.passwordController})
      : super(key: key);

  final TextEditingController passwordController;

  @override
  _PasswordEntryWidgetState createState() => _PasswordEntryWidgetState();
}

class _PasswordEntryWidgetState extends State<PasswordEntryWidget> {
  bool _obscurePassword = true;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.passwordController,
      obscureText: _obscurePassword,
      decoration: InputDecoration(
        border: const OutlineInputBorder(),
        hintText: 'Password',
        contentPadding:
            const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
        suffixIcon: IconButton(
          icon: _obscurePassword
              ? const Icon(Icons.visibility_off)
              : const Icon(Icons.visibility),
          onPressed: () {
            setState(() {
              _obscurePassword = !_obscurePassword;
            });
          },
        ),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter your password';
        }
        // You can add additional password format/validation logic here if needed
        return null;
      },
    );
  }
}

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Login Page',
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Login Page'),
        ),
        body: const Center(
          child: LoginScreen(),
        ),
      ),
    );
  }
}

//AI