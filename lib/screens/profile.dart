import 'package:flutter/material.dart';
import 'package:virtual_lab/components/appbar.dart';
import 'package:virtual_lab/components/bottom_navigation.dart';
import 'package:virtual_lab/components/swipe_navigation.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: HomeAppBar(),
      drawer: HomeDrawer(context),
      body: Center(
        child: Text("Profile"),
      ),
      bottomNavigationBar: HomeBottomNavigationBar(context),
    );
  }
}
