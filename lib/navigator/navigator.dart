import 'package:flutter/material.dart';

class AppNavigator {
  void onNavigatePush(BuildContext context, Widget screen) {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) => screen));
  }

  void onNavigatorPop(BuildContext context) {
    Navigator.pop(context);
  }
}
