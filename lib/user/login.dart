import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:project1/new_account.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  String email = '';
  String password = '';
  final FirebaseAuth _auth = FirebaseAuth.instance;
  bool _obscurePassword = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          'Puff Lab',
          style: TextStyle(
            fontSize: 24,
            color: Colors.white,
            fontFamily:
                'Script', // You'll need to add this font to pubspec.yaml
          ),
        ),
        centerTitle: true,
      ),
      body: Container(
        color: Color(0xFFB5C7A5), // Sage green background
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(height: 40),
              Center(
                child: Text(
                  'Sign In',
                  style: TextStyle(
                    fontSize: 40,
                    color: Color.fromARGB(255, 253, 235, 201),
                    fontWeight: FontWeight.w500,
                    shadows: [
                      Shadow(
                        offset: Offset(2, 2),
                        blurRadius: 3.0,
                        color: Colors.black.withOpacity(0.45),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 40),
              Text(
                'Email',
                style: TextStyle(
                  color: Colors.black87,
                  fontSize: 16,
                ),
              ),
              SizedBox(height: 8),
              TextField(
                onChanged: (value) => setState(() => email = value),
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide.none,
                  ),
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 14,
                  ),
                ),
              ),
              SizedBox(height: 24),
              Text(
                'Password',
                style: TextStyle(
                  color: Colors.black87,
                  fontSize: 16,
                ),
              ),
              SizedBox(height: 8),
              TextField(
                onChanged: (value) => setState(() => password = value),
                obscureText: _obscurePassword,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide.none,
                  ),
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 14,
                  ),
                  suffixIcon: IconButton(
                    icon: Icon(
                      _obscurePassword
                          ? Icons.visibility_off
                          : Icons.visibility,
                      color: Colors.black54,
                    ),
                    onPressed: () =>
                        setState(() => _obscurePassword = !_obscurePassword),
                  ),
                ),
              ),
              SizedBox(height: 16),
              Row(
                children: [
                  Text(
                    'If you dont have account yet register here: ',
                    style: TextStyle(color: Colors.black87),
                  ),
                  TextButton(
                    onPressed: () {
                      // Navigate to sign up page
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => NewAccount()),
                      );
                    },
                    child: Text(
                      'Sign Up',
                      style: TextStyle(
                        color: Colors.black87,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () async {
                    try {
                      await _auth.signInWithEmailAndPassword(
                        email: email,
                        password: password,
                      );
                      Navigator.pushNamed(context, 'UserMenuPage');
                    } catch (e) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Login failed. Please try again.'),
                          backgroundColor: Colors.red,
                        ),
                      );
                    }
                  },
                  child: Text(
                    'Sign In',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.black87,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFFF2E3D5), // Peach/beige color
                    padding: EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 16),
              Center(
                child: TextButton(
                  onPressed: () {
                    // Handle forgot password
                  },
                  child: Text(
                    'Forgot password?',
                    style: TextStyle(
                      color: Colors.black87,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// This line indicate for demo purpose for scm project