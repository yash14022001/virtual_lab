import 'package:flutter/material.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController numberController = TextEditingController();
  bool _loadingAfterRegister = false;
  bool _loadingBeforeRegister = false;
  List<String> universityList = [];
  String? _universitySelected = "";
  String messageFromServer = "";
  bool _succeedRegister = false;

  @override
  void dispose() {
    // Clean up the controller when the widget is removed from the
    // widget tree.
    nameController.dispose();
    emailController.dispose();
    numberController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _getUniversityData();
  }

  bool shouldEnableForm() {
    return !_loadingBeforeRegister && !_loadingAfterRegister;
  }

  Future<void> _doRegister() async {
    setState(() {
      _loadingAfterRegister = true;
    });
    await Future.delayed(const Duration(seconds: 2), () {
      setState(() {
        if (emailController.text.isEmpty ||
            numberController.text.isEmpty ||
            nameController.text.isEmpty) {
          messageFromServer = "Please fill up all the fields!";
        } else {
          _succeedRegister = true;
        }
        _loadingAfterRegister = false;
      });
    });
  }

  Future<void> _getUniversityData() async {
    setState(() {
      _loadingBeforeRegister = true;
    });
    await Future.delayed(new Duration(seconds: 2), () {
      setState(() {
        universityList = [
          "University 1",
          "University 2",
          "University 3",
          "University 4"
        ];
        _loadingBeforeRegister = false;
        _universitySelected = universityList[0];
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(10),
        child: _loadingBeforeRegister
            ? _showLoadingAlertDialog()
            : _succeedRegister
                ? _showAlertDialog(
                    "Successfully registered",
                    "You have successfully registered...Now proceed to login.",
                    "Ok, take me to login", () {
                    Navigator.pushReplacementNamed(context, "/");
                  }, false)
                : messageFromServer != ""
                    ? _showAlertDialog(
                        "Error occurred", "Please fill up all fields!", "Ok",
                        () {
                        setState(() {
                          messageFromServer = "";
                        });
                      }, true)
                    : ListView(
                        children: <Widget>[
                          Container(height: 25),
                          _buildLogo(),
                          Container(height: 50),
                          _buildTitle(),
                          Divider(
                            thickness: 1.5,
                          ),
                          _buildName(),
                          _buildEmail(),
                          _buildUniversityDropDown(),
                          _buildNumber(),
                          _buildRegisterButton(),
                          _buildSignInButton(),
                        ],
                      ),
      ),
    );
  }

  Widget _showAlertDialog(String title, String message, String buttonText,
      Function()? callback, bool isError) {
    return Center(
      child: AlertDialog(
        title: Container(
          child: Text(
            title,
            style: isError
                ? TextStyle(color: Colors.red)
                : TextStyle(color: Colors.green),
          ),
        ),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: callback,
            child: Text(buttonText),
          ),
        ],
      ),
    );
  }

  Widget _showLoadingAlertDialog() {
    return Center(
      child: AlertDialog(
        title: Text("Please wait...."),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text("Connecting to the server..."),
            Container(
              height: 20,
            ),
            CircularProgressIndicator(),
          ],
        ),
      ),
    );
  }

  Widget _buildLogo() {
    return Image.asset(
      "assets/images/lj-main-logo.png",
      width: 100,
      height: 50,
      fit: BoxFit.contain,
    );
  }

  Widget _buildEmail() {
    return Container(
      padding: EdgeInsets.all(10),
      child: TextField(
        controller: emailController,
        enabled: shouldEnableForm(),
        textInputAction: TextInputAction.next,
        decoration: InputDecoration(
          border: OutlineInputBorder(),
          labelText: 'Email',
          hintText: 'Enter your email',
          prefixIcon: new Icon(Icons.account_circle),
        ),
      ),
    );
  }

  Widget _buildName() {
    return Container(
      padding: EdgeInsets.all(10),
      child: TextField(
        enabled: shouldEnableForm(),
        controller: nameController,
        textInputAction: TextInputAction.next,
        decoration: InputDecoration(
          border: OutlineInputBorder(),
          labelText: 'Name',
          hintText: 'Enter your Name',
          prefixIcon: new Icon(Icons.person),
        ),
      ),
    );
  }

  Widget _buildNumber() {
    return Container(
      padding: EdgeInsets.all(10),
      child: TextField(
        enabled: shouldEnableForm(),
        controller: numberController,
        keyboardType: TextInputType.phone,
        textInputAction: TextInputAction.done,
        decoration: InputDecoration(
          border: OutlineInputBorder(),
          labelText: 'Number',
          hintText: 'Enter your mobile number',
          prefixIcon: new Icon(Icons.phone),
        ),
      ),
    );
  }

  Widget _buildTitle() {
    return Container(
      alignment: Alignment.center,
      padding: EdgeInsets.all(10),
      child: Text(
        'Register',
        style: TextStyle(fontSize: 20),
      ),
    );
  }

  Widget _buildRegisterButton() {
    return Padding(
      padding: const EdgeInsets.only(top: 15.0),
      child: Container(
        height: 50,
        padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
        child: ElevatedButton(
          child: _loadingAfterRegister
              ? CircularProgressIndicator(
                  color: Colors.white,
                )
              : Text('Register'),
          onPressed: shouldEnableForm()
              ? () {
                  print(nameController.text);
                  print(emailController.text);
                  print(numberController.text);
                  _doRegister();
                }
              : null,
        ),
      ),
    );
  }

  Widget _buildSignInButton() {
    return Row(
      children: <Widget>[
        Text('Already have account?'),
        TextButton(
          child: Text(
            'Sign in here',
            // style: TextStyle(fontSize: 20),
          ),
          onPressed: shouldEnableForm()
              ? () {
                  Navigator.pushReplacementNamed(context, "/");
                }
              : null,
        )
      ],
      mainAxisAlignment: MainAxisAlignment.center,
    );
  }

  Widget _buildUniversityDropDown() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: DropdownButtonHideUnderline(
        child: DropdownButtonFormField<String>(
          value: _universitySelected,
          decoration: new InputDecoration(
            labelText: "University",
            border: OutlineInputBorder(),
          ),
          iconSize: 20,
          isExpanded: true,
          elevation: 16,
          onChanged: shouldEnableForm()
              ? (String? newValue) {
                  FocusScope.of(context).requestFocus(new FocusNode());
                  setState(() {
                    _universitySelected = newValue!;
                  });
                }
              : null,
          items: universityList.map<DropdownMenuItem<String>>((String value) {
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
}
