import 'package:firebase_auth/firebase_auth.dart';
import 'package:new_/Model/model.dart';
import 'package:new_/Screen/intro_screen.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

import 'register.dart';

class LoginScreen extends StatefulWidget {
  final VoidCallback toggleTheme;
  final bool isDarkMode;

  LoginScreen({required this.toggleTheme, required this.isDarkMode});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController userNameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  void _login() async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: userNameController.text.trim(),
        password: passwordController.text.trim(),
      );
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) => IntroScreen(
                    isDarkMode: widget.isDarkMode,
                    toggleDarkMode: widget.toggleTheme,
                  )));
    } catch (e) {
      print('login failed: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('login failed')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(widget.isDarkMode ? Icons.light_mode : Icons.dark_mode),
            onPressed: widget.toggleTheme,
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildBooksCarousel(),
                SizedBox(
                  height: 80,
                ),
                _buildTexstField(userNameController, 'User Name',
                    maxLength: 15),
                SizedBox(
                  height: 10,
                ),
                _buildTexstField(passwordController, 'Password',
                    obscureTexst: true, maxLength: 8),
                SizedBox(
                  height: 80,
                ),
                ElevatedButton(
                  onPressed: _login,
                  child: Text('Login'),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => RegisterScreen(
                          toggleTheme: widget.toggleTheme,
                          isDarkMode: widget.isDarkMode,
                        ),
                      ),
                    );
                  },
                  child: Text(
                    'Don\'t have an account? Sign up hear',
                    style: TextStyle(
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTexstField(TextEditingController controller, String labelText,
      {bool obscureTexst = false, int? maxLength}) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: labelText,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        counterText: maxLength != null ? '' : null,
      ),
      obscureText: obscureTexst,
      maxLength: maxLength,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'This field is required';
        }
        return null;
      },
    );
  }

  Widget _buildBooksCarousel() {
    return CarouselSlider.builder(
      itemCount: books.length,
      itemBuilder: (context, index, child) {
        final book = books[index];
        return _buildBookItem(book);
      },
      options: CarouselOptions(
        autoPlay: true,
        enlargeCenterPage: true,
        aspectRatio: 2,
        autoPlayInterval: Duration(seconds: 2),
      ),
    );
  }

  Widget _buildBookItem(Book book) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 5),
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(book.imageURL),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
