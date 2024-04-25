import 'package:expense_tracker_2024/constants/colors.dart';
import 'package:expense_tracker_2024/view/widgets/spacing.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: APP_BG_WHITE,
      body: Column(
        children: [
          Container(
            decoration: BoxDecoration(color: MAIN_APP_COLOR),
            padding: const EdgeInsets.only(
                top: 50.0, left: 20, right: 20, bottom: 10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Settings",
                  style: GoogleFonts.lato(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          const AddSpacing(),
          const ProfileDetails(),
          const SignInWithGoogle()
        ],
      ),
    );
  }
}

class SignInWithGoogle extends StatelessWidget {
  const SignInWithGoogle({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.white60,
        ),
        onPressed: () {},
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/images/google_logo.png',
                height: 30.0,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 8),
                child: Text(
                  'Sign in with Google',
                  style: GoogleFonts.lato(
                    fontSize: 18,
                    color: Colors.black87,
                    fontWeight: FontWeight.bold,
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

class ProfileDetails extends StatelessWidget {
  const ProfileDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        child: ClipRRect(
          borderRadius: BorderRadius.circular(50),
          child: Image.network(
            "https://ui-avatars.com/api/?name=Guest",
            key: key,
            fit: BoxFit.cover,
          ),
        ),
      ),
      title: Text(
        "Guest User",
        style: GoogleFonts.lato(
          fontSize: 20,
          color: MAIN_APP_COLOR_DARK,
          fontWeight: FontWeight.bold,
        ),
      ),
      subtitle: Text(
        "Sign in to display email",
        style: GoogleFonts.lato(
          fontSize: 16,
          color: Colors.grey,
        ),
      ),
    );
  }
}
