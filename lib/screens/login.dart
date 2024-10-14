import 'package:asugs/constants.dart';
import 'package:asugs/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
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
                  color: kSecondaryColor,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 10),
              const Spacer(),
              ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  foregroundColor: Colors.black,
                  padding:
                      const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
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
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
              ),
              const SizedBox(
                height: 80,
              )
            ],
          ),
        ),
      ),
    );
  }
}
