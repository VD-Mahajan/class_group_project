import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'home.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  Map userData = {'Vishal': 'Mahajan', 'Om': 'Pawar'};

  @override
  void initState() {
    super.initState();
    _usernameController.addListener(() {});
    _passwordController.addListener(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          "Login Page",
          style: TextStyle(
            color: Colors.white,
            fontSize: 27,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.green[800],
        centerTitle: true,
        elevation: 2,
        shadowColor: Colors.black,
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            // crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 80.0),
                  child: Container(
                    height: 200,
                    width: 200,
                    child: Image.asset('assets/loginCow.png'),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: TextFormField(
                  controller: _usernameController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    label: const Text('Username'),
                    hintText: 'Enter username',
                    prefixIcon: const Icon(Icons.person),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter username';
                    } else {
                      return null;
                    }
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: TextFormField(
                  obscureText: true,
                  obscuringCharacter: '*',
                  controller: _passwordController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    label: const Text('Password'),
                    hintText: 'Enter password',
                    prefixIcon: const Icon(Icons.lock_outline),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter password';
                    } else {
                      return null;
                    }
                  },
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20.0, vertical: 0),
                child: SizedBox(
                  height: 50,
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () async {
                      bool validated = _formKey.currentState!.validate();
                      if (validated) {
                        if (_passwordController.text ==
                            userData[_usernameController.text]) {
                          Navigator.pushReplacement(context,
                              MaterialPageRoute(builder: (context) {
                            return const Home();
                          }));
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Login Successful'),
                              backgroundColor: Colors.green,
                            ),
                          );
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text('No user found'),
                                backgroundColor: Colors.red),
                          );
                        }
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('invalid Data'),
                            backgroundColor: Colors.red,
                          ),
                        );
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green[800],
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: const Text('Login'),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Text(
                  'developed by Vishal & Om',
                  style: GoogleFonts.notoSansOldItalic(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
