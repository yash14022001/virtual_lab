import 'package:flutter/material.dart';
import 'package:virtual_lab/components/appbar.dart';
import 'package:virtual_lab/components/bottom_navigation.dart';
import 'package:virtual_lab/components/swipe_navigation.dart';

class PracticalListScreen extends StatefulWidget {
  const PracticalListScreen({Key? key}) : super(key: key);

  @override
  _PracticalListScreenState createState() => _PracticalListScreenState();
}

class _PracticalListScreenState extends State<PracticalListScreen> {
  bool isLoadingFromServer = false;
  List<String> practicalList = [];
  late String subjectName, departmentName;

  Future<void> getPracticalList() async {
    setLoadingFromServer(true);
    await makePracticalListGetRequest();
    setLoadingFromServer(false);
  }

  Future<void> makePracticalListGetRequest() async {
    await Future.delayed(new Duration(seconds: 2), () {
      setState(() {
        practicalList = [
          "To study DDL-create and DML-insert commands.",
          "Create the below given table and insert the data accordingly.",
          "To Perform various data manipulation commands, aggregate functions and sorting concept on all created tables.",
          "To study Single-row functions.",
          "Displaying data from Multiple Tables (join)",
          "To apply the concept of Aggregating Data using Group functions. ",
          "To solve queries using the concept of sub query",
          "Manipulating Data",
          "To apply the concept of security and privileges",
          "To study Transaction control commands ",
        ];
      });
    });
  }

  void setLoadingFromServer(bool status) {
    setState(() {
      isLoadingFromServer = status;
    });
  }

  @override
  void initState() {
    super.initState();
    getPracticalList();
  }

  @override
  Widget build(BuildContext context) {
    departmentName =
        (ModalRoute.of(context)!.settings.arguments as Map)['department-name'];
    subjectName =
        (ModalRoute.of(context)!.settings.arguments as Map)['subject-name'];
    return Scaffold(
      appBar: HomeAppBar("$subjectName Practicals"),
      drawer: HomeDrawer(context),
      body: isLoadingFromServer
          ? Center(child: CircularProgressIndicator())
          : ListView(
              children: [
                SizedBox(
                  height: 15,
                ),
                // _buildHeader(),
                ..._buildPracticalList(),
              ],
            ),
      bottomNavigationBar: HomeBottomNavigationBar(context),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: EdgeInsets.all(15),
      child: Text(
        "Practicals for $subjectName",
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 24,
          color: Theme.of(context).primaryColor,
        ),
      ),
    );
  }

  List<Widget> _buildPracticalList() {
    if (practicalList.length == 0) {
      return [
        Container(
          padding: EdgeInsets.all(15),
          child:
              Text("There are no practicals for this subject at this moment!"),
        ),
        TextButton(
            child: Text(
              'Select another subject',
              // style: TextStyle(fontSize: 20),
            ),
            onPressed: () {
              Navigator.popUntil(
                  context, (route) => route.settings.name == "/home");
            }),
      ];
    }
    int index = 0;
    List<Widget> practicalsWidgetList = [];
    for (int i = 0; i < practicalList.length; i++) {
      practicalsWidgetList.add(_buildSinglePracticalTile(i));
    }

    return practicalsWidgetList;
  }

  Widget _buildSinglePracticalTile(int index) {
    return Column(children: [
      ListTile(
        leading: Icon(Icons.list),
        trailing: TextButton(
          child: Text(
            "See",
            style:
                TextStyle(color: Theme.of(context).primaryColor, fontSize: 15),
          ),
          onPressed: () {
            Navigator.pushNamed(context, "/practical", arguments: {
              "aim": practicalList[index],
            });
          },
        ),
        title: Text("Practical ${index + 1}"),
        subtitle: Text(practicalList[index]),
      ),
      if (index != practicalList.length - 1) Divider(),
    ]);
  }
}
