import 'package:flutter/material.dart';

Widget HomeBottomNavigationBar(BuildContext context) {
  int currentIndex = 1;
  if (ModalRoute.of(context)!.settings.name == "/subject-list")
    currentIndex = 0;
  else if (ModalRoute.of(context)!.settings.name == "/profile")
    currentIndex = 2;
  return BottomNavigationBar(
    items: const <BottomNavigationBarItem>[
      BottomNavigationBarItem(
        icon: Icon(Icons.book),
        label: 'Subject',
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.home),
        label: 'Home',
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.person),
        label: 'Profile',
      ),
    ],
    currentIndex: currentIndex,
    onTap: (index) {
      Navigator.popUntil(context, (route) => route.settings.name == "/home");
      if (index == 0) {
        Navigator.pushNamed(context, "/subject-list");
      } else if (index == 2) {
        Navigator.pushNamed(context, "/profile");
      }
    },
  );
}
