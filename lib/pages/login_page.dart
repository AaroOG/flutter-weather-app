// ignore: unused_import
import 'package:SMPLWTHR/pages/main.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: const LoginPage());
  }
}

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center, // all in center
        children: [
          // Logo
          Icon(Icons.lock, size: 100), // needs to be visible
          // welcome
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: Text(
              'Welcome Back',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
          ),

          // Username
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            child: TextField(
              decoration: InputDecoration(
                contentPadding: EdgeInsets.symmetric(horizontal: 10.0),
                labelText: 'Username',
                border: OutlineInputBorder(borderRadius:BorderRadius.circular(5.0),
        borderSide: BorderSide(color: const Color.fromARGB(255, 0, 0, 0), width: 3.0)),
              ),
            ),
          ),

          // Password
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            child: TextField(
              obscureText: true,
              decoration: InputDecoration(
                labelText: 'Password',
                border: OutlineInputBorder(),
              ),
            ),
          ),

          ElevatedButton(
            child: Text('Sign In', style: TextStyle(color: Colors.blue),),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => MyHomePage(title: 'Weather'),
                ),
              );
            },
          ),

          // Or continue with
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: Text('Or continue with'),
          ),

          // Google + Apple sign in buttons
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                icon: Image.asset('assets/google.png', width: 30, height: 30),
                onPressed: () {
                  // Handle Google sign in
                },
              ),
              IconButton(
                icon: Image.asset('assets/apple.png', width: 30, height: 30),
                onPressed: () {
                  // apple logo
                },
              ),
            ],
          ),

          // Not a member? Register now
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: TextButton(
              onPressed: () {
                // Handle navigation to registration page
              },
              child: Text('Need an Account?, Register Here.', style: TextStyle(color: Colors.blue),),
              
            ),
          ),
        ],
      ),
    );
  }
}
