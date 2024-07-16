import 'package:carousel_slider/carousel_slider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../Model/model.dart';
import 'intro_screen.dart';

class RegisterScreen extends StatefulWidget {
  final VoidCallback toggleTheme;
  final bool isDarkMode;

  RegisterScreen({required this.toggleTheme, required this.isDarkMode});

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController userNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  void _register() async {
    try {
      
          await _auth.createUserWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => IntroScreen(
            toggleDarkMode: widget.toggleTheme,
            isDarkMode: widget.isDarkMode,
          ),
        ),
      );
      
    } catch (e) {
      print('Regestration failed: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Regestration failed')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sign up'),
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
                _buildTexstField(emailController, 'Email', maxLength: 22),
                SizedBox(
                  height: 10,
                ),
                _buildTexstField(passwordController, 'Password',
                    maxLength: 10, obscureTexst: true),
                SizedBox(
                  height: 40,
                ),
                ElevatedButton(
                  onPressed: _register,
                  child: Text("Register"),
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
