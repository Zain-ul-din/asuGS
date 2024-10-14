import 'package:asugs/constants.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Create controllers for the text fields
    final TextEditingController emailController = TextEditingController();
    final TextEditingController passwordController = TextEditingController();

    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Spacer(),
              // Logo
              Center(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(
                      75), // Half of the width/height for a perfect circle
                  child: Image.asset(
                    "assets/images/logo_white.png",
                    width: 150,
                    height: 150,
                  ),
                ),
              ),
              const SizedBox(height: 20), // Spacing between logo and text
              // Text below the logo
              Text(
                'Welcome to Grid Scout!',
                style: GoogleFonts.bebasNeue(
                  fontSize: 28,
                  color:
                      kSecondaryColor, // You can replace kSecondaryColor with a color
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              // Email input
              Container(
                width: double.infinity,
                constraints: BoxConstraints(
                    maxWidth: 400), // Set max width for the input fields
                child: TextField(
                  controller: emailController,
                  decoration: InputDecoration(
                    labelText: 'Email',
                    border: OutlineInputBorder(),
                    filled: true,
                    fillColor:
                        Colors.white, // Background color of the input field
                  ),
                  keyboardType: TextInputType.emailAddress,
                ),
              ),
              const SizedBox(height: 10), // Spacing between fields
              // Password input
              Container(
                width: double.infinity,
                constraints: BoxConstraints(
                    maxWidth: 400), // Set max width for the input fields
                child: TextField(
                  controller: passwordController,
                  decoration: InputDecoration(
                    labelText: 'Password',
                    border: OutlineInputBorder(),
                    filled: true,
                    fillColor:
                        Colors.white, // Background color of the input field
                  ),
                  obscureText: true,
                ),
              ),
              const SizedBox(height: 20), // Spacing between fields and button
              // Login Button
              Container(
                width: double.infinity,
                constraints: BoxConstraints(
                    maxWidth: 400), // Set max width for the button
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue, // Change color as needed
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(
                        vertical: 12, horizontal: 24),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                  ),
                  onPressed: () {
                    // For now, just navigate to the home screen
                    Navigator.pushNamed(context, '/');
                  },
                  child: const Text(
                    'Login',
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ),
              const SizedBox(
                  height: 20), // Spacing before Google sign-in button
              // Google Sign-In Button
              Container(
                width: double.infinity,
                constraints: BoxConstraints(
                    maxWidth: 400), // Set max width for the button
                child: ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: Colors.black,
                    padding: const EdgeInsets.symmetric(
                        vertical: 12, horizontal: 24),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0),
                      side: BorderSide(color: Colors.grey.shade300),
                    ),
                  ),
                  onPressed: () {
                    // AuthService().googleSignIn().then((user) => {
                    //       if (user != null) {Navigator.pushNamed(context, '/')}
                    //     });
                    Navigator.pushNamed(context, '/');
                  },
                  icon: Image.asset(
                    'assets/images/google_icon.png', // Path to your Google icon
                    height: 24.0,
                  ),
                  label: const Text(
                    'Sign in with Google',
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ),
              const SizedBox(height: 80),
            ],
          ),
        ),
      ),
    );
  }
}
