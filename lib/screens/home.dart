import "package:flutter/material.dart";
import 'package:virtual_lab/components/appbar.dart';
import 'package:virtual_lab/components/bottom_navigation.dart';
import 'package:virtual_lab/components/swipe_navigation.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<String> departmentList = [];
  List<String> subjectList = [];
  String departmentSelected = "";
  String subjectSelected = "";
  late BuildContext buildContext;

  bool isLoadingFromServer = false;

  @override
  void initState() {
    super.initState();
    getDepartmentList();
    getSubjectList();
  }

  bool shouldEnableForm() {
    return !isLoadingFromServer;
  }

  Future<void> getDepartmentList() async {
    setLoadingFromServer(true);
    await makeDepartmentGetRequest();
    setLoadingFromServer(false);
  }

  Future<void> getSubjectList() async {
    setLoadingFromServer(true);
    await makeSubjectGetRequest(departmentSelected);
    setLoadingFromServer(false);
  }

  void setLoadingFromServer(bool status) {
    setState(() {
      isLoadingFromServer = status;
    });
  }

  Future<void> makeDepartmentGetRequest() async {
    await Future.delayed(new Duration(seconds: 2), () {
      setState(() {
        for (int i = 1; i <= 5; i++) {
          departmentList.add('Department $i');
        }
        departmentSelected = departmentList[0];
      });
    });
  }

  void nextButtonClickHandler() {
    Navigator.pushNamed(buildContext, "/practical-list", arguments: {
      "department-name": departmentSelected,
      "subject-name": subjectSelected,
    });
  }

  Future<void> makeSubjectGetRequest(String departmentName) async {
    await Future.delayed(new Duration(seconds: 2), () {
      setState(() {
        subjectList = [];
        for (int i = 1; i <= 5; i++) {
          subjectList.add(
              'D${departmentSelected[departmentSelected.length - 1]} : Subject $i');
        }
        subjectSelected = subjectList[0];
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    buildContext = context;
    return Scaffold(
      appBar: HomeAppBar(),
      drawer: HomeDrawer(context),
      body: ListView(
        children: [
          _buildDepartmentDropDown(),
          _buildSubjectDropDown(),
          _buildNextButton(),
        ],
      ),
      bottomNavigationBar: HomeBottomNavigationBar(context),
    );
  }

  Widget _buildDepartmentDropDown() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: DropdownButtonHideUnderline(
        child: DropdownButtonFormField<String>(
          value: departmentSelected,
          decoration: new InputDecoration(
            labelText: "Department",
            border: OutlineInputBorder(),
          ),
          iconSize: 20,
          isExpanded: true,
          elevation: 16,
          onChanged: shouldEnableForm()
              ? (String? newValue) {
                  FocusScope.of(context).requestFocus(new FocusNode());
                  setState(() {
                    departmentSelected = newValue!;
                  });
                  getSubjectList();
                }
              : null,
          items: departmentList.map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Container(
                child: Text(value),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }

  Widget _buildSubjectDropDown() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: DropdownButtonHideUnderline(
        child: DropdownButtonFormField<String>(
          value: subjectSelected,
          decoration: new InputDecoration(
            labelText: "Subject",
            border: OutlineInputBorder(),
          ),
          iconSize: 20,
          isExpanded: true,
          elevation: 16,
          onChanged: shouldEnableForm()
              ? (String? newValue) {
                  FocusScope.of(context).requestFocus(new FocusNode());
                  setState(() {
                    subjectSelected = newValue!;
                  });
                }
              : null,
          items: subjectList.map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Container(
                child: Text(value),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }

  Widget _buildNextButton() {
    return Padding(
      padding: const EdgeInsets.only(top: 15.0),
      child: Container(
        height: 50,
        padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
        child: ElevatedButton(
          child: isLoadingFromServer
              ? CircularProgressIndicator(
                  color: Colors.white,
                )
              : Text('Next'),
          onPressed: shouldEnableForm() ? nextButtonClickHandler : null,
        ),
      ),
    );
  }
}
