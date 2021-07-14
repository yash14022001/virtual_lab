import 'package:flutter/material.dart';
import 'package:virtual_lab/components/appbar.dart';
import 'package:virtual_lab/components/bottom_navigation.dart';
import 'package:virtual_lab/components/swipe_navigation.dart';

class DepartmentListScreen extends StatefulWidget {
  const DepartmentListScreen({Key? key}) : super(key: key);

  @override
  _DepartmentListScreenState createState() => _DepartmentListScreenState();
}

class _DepartmentListScreenState extends State<DepartmentListScreen> {
  bool _loadingFromServer = false;
  List<String> departmentList = [];

  Future<void> _getDepartmentList() async {
    setState(() {
      _loadingFromServer = true;
    });

    await Future.delayed(new Duration(seconds: 2), () {
      setState(() {
        departmentList = [
          "Aeronautical Engineering",
          "Automobile Engineering",
          "Bio Medical Engineering",
          "Bio- Technology",
          "Chemical Engineering",
          "Civil Engineering",
          "Computer Engineering",
          "Electrical & Electronics Engineering",
          "Electrical Engineering",
          "Electronics Engineering",
          "Electronics & Communication Engineering",
          "Electronics & Telecommunication Engineering",
          "Environmental Engineering",
          "Food Processing & Technology",
          "Industrial Engineering",
          "Information Technology",
          "Instrumentation & Control Engineering",
          "Marine Engineering",
          "Mechanical Engineering",
          "Mechatronics Engineering",
          "Metallurgy Engineering",
          "Mining Engineering",
          "Plastic Technology",
          "Power Electronics",
          "Production Engineering",
          "Rubber Technology",
          "Textile Processing",
          "Textile Technology",
          "Computer Science & Engineering",
          "Information & Communication Technology",
          "Manufacturing Engineering",
          "Environmental Science And Technology",
          "Chemical Technology",
          "Environmental Science & Engineering",
        ];
        _loadingFromServer = false;
      });
    });
  }

  @override
  void initState() {
    super.initState();
    _getDepartmentList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: HomeAppBar("List of department"),
      drawer: HomeDrawer(context),
      body: _loadingFromServer
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: departmentList.length,
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
                      title: Text(departmentList[index])),
                  Divider(),
                ]);
              },
            ),
      bottomNavigationBar: HomeBottomNavigationBar(context),
    );
  }
}
