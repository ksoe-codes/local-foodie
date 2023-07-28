// ignore_for_file: camel_case_types, library_private_types_in_public_api
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:local_foodie/Model/user_class.dart' as u;

import 'Database/db_handler.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({Key? key}) : super(key: key);

  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _dobController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  late DatabaseHandler handler;

  @override
  void initState() {
    super.initState();
    handler = DatabaseHandler();
  }

  Future<int> addUser() async {
    u.User usr = u.User(
        fName: _firstNameController.text,
        lName: _lastNameController.text,
        email: _emailController.text,
        password: _passwordController.text);
    List<u.User> listOfUser = [];
    listOfUser.add(usr);
    return await handler.insertUser(listOfUser);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SignUp Page',
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: const Text('New Customer regisration'),
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
                    'SignUp',
                    style: GoogleFonts.poppins(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 20),
                  firstNameEntryWidget(
                      firstNameController: _firstNameController),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      Expanded(
                        flex: 6, // 70% width for Last Name
                        child: lastNameEntryWidget(
                            lastNameController: _lastNameController),
                      ),
                      const SizedBox(width: 20),
                      Expanded(
                        flex: 4, // 30% width for DOB
                        child: dobEntryWidget(dobController: _dobController),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  EmailEntryWidget(emailController: _emailController),
                  const SizedBox(height: 20),
                  PhoneEntryWidget(phoneController: _phoneController),
                  const SizedBox(height: 20),
                  PasswordEntryWidget(passwordController: _passwordController),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () => _onSignupButtonPressed(context),
                    child: Text(
                      'Sign Up',
                      style: GoogleFonts
                          .poppins(), // Applied Poppins font to the button text
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

  void _onSignupButtonPressed(BuildContext context) {
    // Call your SQLite method here
    _performSignup();
  }

  void _performSignup() {
    // Your signup logic here
    // For example, you can use the DatabaseHelper to insert the signup data into the database
    DatabaseHandler().initDB();

    String firstName = _firstNameController.text;
    String lastName = _lastNameController.text;
    String email = _emailController.text;
    String password = _passwordController.text;

    List<u.User> users = [
      u.User(
          fName: firstName, lName: lastName, email: email, password: password),
      // Add more User instances if needed
    ];
    DatabaseHandler().insertUser(users);
  }
}

class firstNameEntryWidget extends StatelessWidget {
  const firstNameEntryWidget({Key? key, required this.firstNameController})
      : super(key: key);

  final TextEditingController firstNameController;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: firstNameController,
      keyboardType: TextInputType.name,
      decoration: InputDecoration(
        labelText: 'First Name',
        labelStyle: GoogleFonts.poppins(
          fontWeight: FontWeight.w500,
          fontSize: 16,
        ),
        contentPadding:
            const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
        border: const OutlineInputBorder(),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter your First Name';
        }
        return null;
      },
    );
  }
}

class lastNameEntryWidget extends StatelessWidget {
  lastNameEntryWidget({Key? key, required this.lastNameController})
      : super(key: key);

  final TextEditingController lastNameController;

  final TextStyle labelStyle = GoogleFonts.poppins(
    fontWeight: FontWeight.w500,
    fontSize: 16,
  );

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: lastNameController,
      keyboardType: TextInputType.name,
      decoration: InputDecoration(
        labelText: 'Last Name',
        labelStyle: labelStyle,
        contentPadding:
            const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
        border: const OutlineInputBorder(),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter your Last Name';
        }
        return null;
      },
    );
  }
}

class dobEntryWidget extends StatefulWidget {
  const dobEntryWidget({Key? key, required this.dobController})
      : super(key: key);

  final TextEditingController dobController;

  @override
  _dobEntryWidgetState createState() => _dobEntryWidgetState();
}

class _dobEntryWidgetState extends State<dobEntryWidget> {
  DateTime? _selectedDate;

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );

    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
        widget.dobController.text =
            DateFormat('yyyy-MM-dd').format(_selectedDate!);
      });
    }
  }

  final TextStyle labelStyle = GoogleFonts.poppins(
    fontWeight: FontWeight.w500,
    fontSize: 16,
  );

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.dobController,
      keyboardType: TextInputType.datetime,
      onTap: () => _selectDate(context),
      readOnly: true, // To prevent manual text input
      decoration: InputDecoration(
        labelText: 'Date Of Birth',
        labelStyle: labelStyle,
        contentPadding:
            const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
        border: const OutlineInputBorder(),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please select your Date of Birth';
        }
        return null;
      },
    );
  }
}

class EmailEntryWidget extends StatelessWidget {
  EmailEntryWidget({Key? key, required this.emailController}) : super(key: key);

  final TextEditingController emailController;

  final TextStyle labelStyle = GoogleFonts.poppins(
    fontWeight: FontWeight.w500,
    fontSize: 16,
  );

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: emailController,
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
        labelText: 'Enter your Email',
        labelStyle: labelStyle,
        contentPadding:
            const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
        border: const OutlineInputBorder(),
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
  PhoneEntryWidget({Key? key, required this.phoneController}) : super(key: key);

  final TextEditingController phoneController;
  final TextStyle labelStyle = GoogleFonts.poppins(
    fontWeight: FontWeight.w500,
    fontSize: 16,
  );

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: phoneController,
      keyboardType: TextInputType.phone,
      maxLength: 12, // Maximum allowed digits (including "+")
      inputFormatters: [
        LengthLimitingTextInputFormatter(12), // To limit the length
        FilteringTextInputFormatter.digitsOnly, // To allow only digits
      ],
      decoration: InputDecoration(
          labelText: 'Enter your Phone Number',
          labelStyle: labelStyle,
          contentPadding:
              const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
          border: const OutlineInputBorder(),
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

  final TextStyle labelStyle = GoogleFonts.poppins(
    fontWeight: FontWeight.w500,
    fontSize: 16,
  );

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.passwordController,
      obscureText: _obscurePassword,
      decoration: InputDecoration(
        border: const OutlineInputBorder(),
        hintText: 'Password',
        hintStyle: labelStyle,
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
    final textTheme = Theme.of(context).textTheme.copyWith(
          displayLarge: GoogleFonts.ptSans(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        );

    return MaterialApp(
      title: 'SignUp Page',
      theme: ThemeData(textTheme: textTheme),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('SignUp Page'),
        ),
        body: const Center(
          child: SignupScreen(),
        ),
      ),
    );
  }
}


//jenkins check 
