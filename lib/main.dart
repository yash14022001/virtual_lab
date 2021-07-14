import 'package:flutter/material.dart';
import 'package:virtual_lab/screens/about.dart';
import 'package:virtual_lab/screens/department_list.dart';
import 'package:virtual_lab/screens/forgot_password.dart';
import 'package:virtual_lab/screens/home.dart';
import 'package:virtual_lab/screens/inquiry.dart';
import 'package:virtual_lab/screens/login.dart';
import 'package:virtual_lab/screens/pracitcal_list.dart';
import 'package:virtual_lab/screens/practical.dart';
import 'package:virtual_lab/screens/profile.dart';
import 'package:virtual_lab/screens/register.dart';
import 'package:virtual_lab/screens/subject_list.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Virtual Lab',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Lato',
      ),
      routes: {
        '/': (context) => LoginScreen(),
        '/register': (context) => RegisterScreen(),
        '/forgot-password': (context) => ForgotPasswordScreen(),
        '/home': (context) => HomeScreen(),
        '/about': (context) => AboutScreen(),
        '/department-list': (context) => DepartmentListScreen(),
        '/inquiry': (context) => InquiryScreen(),
        '/practical-list': (context) => PracticalListScreen(),
        '/practical': (context) => PracticalScreen(),
        '/profile': (context) => ProfileScreen(),
        '/subject-list': (context) => SubjectListScreen(),
      },
    );
  }
}
