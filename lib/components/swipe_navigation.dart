import 'package:flutter/material.dart';

Widget HomeDrawer(BuildContext context) {
  return Drawer(
    // Add a ListView to the drawer. This ensures the user can scroll
    // through the options in the drawer if there isn't enough vertical
    // space to fit everything.
    child: ListView(
      // Important: Remove any padding from the ListView.
      padding: EdgeInsets.zero,
      children: <Widget>[
        DrawerHeader(
          decoration: BoxDecoration(
            color: Colors.blue,
          ),
          child: Center(
            child: Text(
              'Virtual lab',
              style: TextStyle(
                fontSize: 40,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        ListTile(
          title: Text('Department'),
          onTap: () {
            _cleanStack(context);
            Navigator.pushNamed(context, "/department-list");
          },
        ),
        // Divider(),
        ListTile(
          title: Text('Subject'),
          onTap: () {
            _cleanStack(context);
            Navigator.pushNamed(context, "/subject-list");
          },
        ),
        // Divider(),
        ListTile(
          title: Text('About'),
          onTap: () {
            _cleanStack(context);
            Navigator.pushNamed(context, "/about");
          },
        ),
        // Divider(),
        ListTile(
          title: Text('Inquiry'),
          onTap: () {
            _cleanStack(context);
            Navigator.pushNamed(context, "/inquiry");
          },
        ),
      ],
    ),
  );
}

void _cleanStack(BuildContext context) {
  Navigator.pop(context);
  Navigator.popUntil(context, (route) {
    return route.settings.name == "/home";
  });
}
