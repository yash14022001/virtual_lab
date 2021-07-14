import 'package:flutter/material.dart';
import 'package:virtual_lab/components/appbar.dart';
import 'package:virtual_lab/components/bottom_navigation.dart';
import 'package:virtual_lab/components/swipe_navigation.dart';

class SubjectListScreen extends StatefulWidget {
  const SubjectListScreen({Key? key}) : super(key: key);

  @override
  _SubjectListScreenState createState() => _SubjectListScreenState();
}

class _SubjectListScreenState extends State<SubjectListScreen> {
  bool _loadingFromServer = false;
  List<String> subjectList = [];

  Future<void> _getSubjectList() async {
    setState(() {
      _loadingFromServer = true;
    });
    await Future.delayed(new Duration(seconds: 2), () {
      setState(() {
        subjectList = [
          "Chemistry",
          "English",
          "Programming for Problem Solving",
          "Basic Civil Engineering",
          "Basic Mechanical Engineering",
          "Environmental Science",
          "Physics Group - I",
          "Workshop",
          "Engineering Graphics & Design",
          "Mathematics-I",
          "Mathematics-II",
          "BASIC MATHEMATICS",
          "English",
          "ENVIRONMENT CONSERVATION & HAZARD MANAGEMENT",
          "ENGINEERING PHYSICS ( GROUP-1 )",
          "ENGINEERING CHEMISTRY ( GROUP-2 )",
          "BASIC ENGINEERING DRAWING",
          "APPLIED MECHANICS",
          "APPLIED CHEMISTRY ( GROUP-1 )",
          "BASIC CHEMISTRY(GROUP-4)",
          "COMPUTER APPLICATION AND GRAPHICS",
          "BASIC OF ELECTRICAL & ELECTRONICS ENGINEERING",
          "FUNDAMENTAL OF MECHANICAL ENGINEERING",
          "ENGINEERING WORKSHOP PRACTICE",
          "PHYSICAL ANALYTICAL & INORGANIC CHEMISTRY",
          "CHEMICAL ENGINEERING DRAWING",
          "ELECTRONIC PRACTICE",
          "BASIC POLYMER CHEMISTRY",
          "ELEMENTS OF TEXTILE TECHNOLOGY",
          "BASIC OF TEXTILE",
          "ADVANCED MATHEMATICS (GROUP-1)",
          "ADVANCED MATHEMATICS(GROUP-2)",
          "BASIC OF CIVIL ENGINEERING",
          "THERMODYNAMICS & HYDRAULICS",
          "ORGANIC CHEMISTRY",
          "BUILDING DRAWING",
          "BASIC MECHANICAL ENGINEERING",
          "CIVIL ENGINEERING WORKSHOP PRACTICE",
          "BASIC OF ELECTRICAL ENGINEERING",
          "MECHANICAL DRAFTING",
          "MATERIAL SCIENCE & METALLURGY",
          "FUNDAMENTALS OF ELECTRONICS ENGINEERING",
        ];
        _loadingFromServer = false;
      });
    });
  }

  @override
  void initState() {
    super.initState();
    _getSubjectList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: HomeAppBar("List of subjects"),
      drawer: HomeDrawer(context),
      body: _loadingFromServer
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: subjectList.length,
              itemBuilder: (BuildContext context, int index) {
                return Column(children: [
                  ListTile(
                      leading: Icon(Icons.list),
                      trailing: TextButton(
                        child: Text(
                          "See",
                          style: TextStyle(
                              color: Theme.of(context).primaryColor,
                              fontSize: 15),
                        ),
                        onPressed: () {},
                      ),
                      title: Text(subjectList[index])),
                  Divider(),
                ]);
              },
            ),
      bottomNavigationBar: HomeBottomNavigationBar(context),
    );
  }
}
