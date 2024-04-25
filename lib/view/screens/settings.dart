import 'dart:ui';

import 'package:expense_tracker_2024/constants/colors.dart';
import 'package:expense_tracker_2024/helpers/helpers.dart';
import 'package:expense_tracker_2024/view/widgets/spacing.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';

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
          const SignInWithGoogle(),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(right: 10, left: 10),
              child: ListView(
                padding: const EdgeInsets.only(top: 10),
                children: const [
                  SettingsListItem(
                    name: "change currency",
                    icon: Icons.travel_explore,
                    showSeperator: true,
                    showTrailing: true,
                    trailingText: "PKR",
                  ),
                  SettingsListItem(
                    name: "backup data",
                    icon: Icons.backup,
                    showSeperator: true,
                    showTrailing: false,
                  ),
                  SettingsListItem(
                    name: "restore data",
                    icon: Icons.restore,
                    showSeperator: false,
                    showTrailing: false,
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class SettingsListItem extends StatelessWidget {
  final String name;
  final IconData icon;
  final bool showSeperator;
  final bool showTrailing;
  final String? trailingText;
  const SettingsListItem({
    super.key,
    required this.name,
    required this.icon,
    required this.showSeperator,
    required this.showTrailing,
    this.trailingText,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 10, bottom: 10),
          child: ListTile(
            leading: Icon(
              icon,
              color: MAIN_APP_COLOR_DARK,
            ),
            title: Text(
              name.capitalize(),
              style: GoogleFonts.lato(
                fontSize: 16,
                color: const Color.fromARGB(255, 92, 91, 91),
                fontWeight: FontWeight.w600,
              ),
            ),
            trailing: showTrailing
                ? Text(
                    trailingText.toString(),
                    style: GoogleFonts.lato(
                      color: MAIN_APP_COLOR_DARK,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  )
                : null,
          ),
        ),
        showSeperator
            ? Container(
                width: MediaQuery.of(context).size.width,
                height: 1,
                decoration: const BoxDecoration(
                  color: Color.fromARGB(255, 182, 180, 180),
                ),
              )
            : const AddSpacing(),
      ],
    );
  }
}

class SignInWithGoogle extends StatelessWidget {
  const SignInWithGoogle({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10, left: 10, right: 10),
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
