import 'package:expense_tracker_2024/constants/colors.dart';
import 'package:expense_tracker_2024/navigator/navigator.dart';
import 'package:expense_tracker_2024/view/screens/accounts.dart';
import 'package:expense_tracker_2024/view/screens/categories.dart';
import 'package:expense_tracker_2024/view/screens/coming_soon.dart';
import 'package:expense_tracker_2024/view/widgets/spacing.dart';
import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:google_fonts/google_fonts.dart';

class AppNavigationDrawer extends StatelessWidget {
  const AppNavigationDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        ZoomDrawer.of(context)!.close();
      },
      child: Scaffold(
        backgroundColor: MAIN_APP_COLOR_LIGHT_SHADE,
        body: Center(
          child: SizedBox(
            height: MediaQuery.of(context).size.height * 0.5,
            child: ListView(
              children: [
                ListTile(
                  leading: CircleAvatar(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(50),
                      child: Image.network(
                        "https://ui-avatars.com/api/?name=Guest",
                        key: key,
                      ),
                    ),
                  ),
                  title: Text(
                    "Guest User",
                    style: GoogleFonts.lato(
                      fontSize: 22,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                DrawerItem(
                  drawerIcon: Icons.currency_exchange,
                  drawerText: "All Transactions",
                  itemClick: () => _navigate(const ComingSoonScreen(), context),
                ),
                DrawerItem(
                  drawerIcon: Icons.category,
                  drawerText: "All Categories",
                  itemClick: () => _navigate(const CategoriesScreen(), context),
                ),
                DrawerItem(
                  drawerIcon: Icons.alarm_add,
                  drawerText: "All Reminders",
                  itemClick: () => _navigate(const ComingSoonScreen(), context),
                ),
                DrawerItem(
                  drawerIcon: Icons.person,
                  drawerText: "All Accounts",
                  itemClick: () => _navigate(const AccountsScreen(), context),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

_navigate(Widget screenName, BuildContext context) {
  ZoomDrawer.of(context)!.close();
  AppNavigator().onNavigatePush(context, screenName);
}

class DrawerItem extends StatelessWidget {
  final IconData drawerIcon;
  final String drawerText;
  final void Function() itemClick;

  const DrawerItem({
    super.key,
    required this.drawerIcon,
    required this.drawerText,
    required this.itemClick,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: itemClick,
      child: ListTile(
        iconColor: Colors.white,
        leading: Icon(
          drawerIcon,
          color: Colors.white38,
        ),
        title: Text(
          drawerText,
          style: GoogleFonts.lato(
            color: Colors.white38,
            fontWeight: FontWeight.bold,
            fontSize: 14,
          ),
        ),
      ),
    );
  }
}
