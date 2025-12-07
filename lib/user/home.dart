import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text(
            'Puff Lab',
            style: TextStyle(
              fontFamily: 'Cursive', // Cursive font for the title
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Color(0xFFF2E3D5), // Peach/beige color
            ),
          ),
          leading: Navigator.canPop(context)
              ? IconButton(
                  icon: Icon(Icons.arrow_back, color: Color(0xFFF2E3D5)),
                  onPressed: () => Navigator.of(context).pop(),
                )
              : null,
          backgroundColor: Colors.black,
          elevation: 0,
        ),
        body: Container(
          width: double.infinity,
          height: double.infinity,
          color: Color(0xFFA9B998), // Sage green background color
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'Customer Sign In',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255, 0, 0, 0), // Peach/beige text color
                  shadows: [
                    Shadow(
                      blurRadius: 2,
                      color: Colors.black38,
                      offset: Offset(1, 1),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 40),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFFF2E3D5), // Peach/beige color
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 60, vertical: 16),
                  elevation: 5,
                  shadowColor: Colors.black26,
                ),
                child: Text(
                  'Login Account',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                onPressed: () {
                  Navigator.pushNamed(context, 'Login');
                },
              ),
              SizedBox(height: 20),
              TextButton(
                onPressed: () {
                  Navigator.pushNamed(context, 'NewAccount');
                },
                child: RichText(
                  text: TextSpan(
                    text: 'Not yet has account? ',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                    ),
                    children: [
                      TextSpan(
                        text: 'Sign Up',
                        style: TextStyle(
                          color: Colors.blue,
                          fontWeight: FontWeight.bold,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ],
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
