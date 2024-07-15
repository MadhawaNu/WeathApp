import 'package:flutter/material.dart';
import 'package:weath_app/pages/home..dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({super.key});

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/background.jpg"), // Replace with your image
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          //mainAxisSize: MainAxisSize.min, 
          child: Column(
            children: [
              SizedBox(height: 300),
              Text(
        'Welcome to Weather Update',
        style: TextStyle(
          fontSize: 24, // Adjust the font size as needed
          fontWeight: FontWeight.bold, // Makes the text bold
          color: Colors.white, // Sets the text color to white
          shadows: [
            Shadow(
              blurRadius: 10.0,
              color: Colors.black.withOpacity(0.5),
              offset: Offset(5.0, 5.0),
            ),
          ], // Adds a shadow for better readability over the background image
        ),
      ),
      SizedBox(height: 250),
              ElevatedButton(
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => HomePage()),
                  );
                   
                },
                child: Text('Continue'),
                style: ElevatedButton.styleFrom(
                  primary: Colors.white, // Button color
                  onPrimary: Colors.black, // Text color
                  padding: EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}