import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({Key? key}) : super(key: key);

  @override
  _ForgotPasswordScreenState createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  TextEditingController emailController = TextEditingController();
  bool _loadingAfterForgotPassword = false;
  bool _succeedIntoReset = false;
  String messageFromServer = '';

  @override
  void dispose() {
    // Clean up the controller when the widget is removed from the
    // widget tree.
    emailController.dispose();
    super.dispose();
  }

  bool shouldEnableForm() {
    return !_loadingAfterForgotPassword;
  }

  Future<void> _sendPasswordToMail() async {
    setState(() {
      _loadingAfterForgotPassword = true;
    });
    await Future.delayed(const Duration(seconds: 2), () {
      setState(() {
        if (emailController.text.isNotEmpty) {
          _succeedIntoReset = true;
        } else {
          messageFromServer = "Please fill up all fields!";
        }
        _loadingAfterForgotPassword = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _succeedIntoReset
          ? _showAlertDialog(
              "Password reset done successfully",
              "Your new password has been sent to your registered mail id. Please log in with new password!",
              "OK, take me to Login", () {
              Navigator.pushReplacementNamed(context, "/");
            }, false)
          : messageFromServer != ""
              ? _showAlertDialog("Error occurred",
                  "Please enter your registered mail id", "OK", () {
                  setState(() {
                    messageFromServer = "";
                  });
                }, true)
              : Padding(
                  padding: EdgeInsets.all(10),
                  child: ListView(
                    children: <Widget>[
                      Container(height: 25),
                      _buildLogo(),
                      Container(height: 50),
                      _buildTitle(),
                      Divider(
                        thickness: 1.5,
                      ),
                      _buildEmail(),
                      _buildForgotPasswordButton(),
                      _buildRegisterButton(),
                      _buildSignInButton(),
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

  Widget _buildTitle() {
    return Container(
      alignment: Alignment.center,
      padding: EdgeInsets.all(10),
      child: Text(
        'Forgot Password',
        style: TextStyle(fontSize: 20),
      ),
    );
  }

  Widget _buildForgotPasswordButton() {
    return Padding(
      padding: const EdgeInsets.only(top: 15.0),
      child: Container(
        height: 50,
        padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
        child: ElevatedButton(
          child: _loadingAfterForgotPassword
              ? CircularProgressIndicator(
                  color: Colors.white,
                )
              : Text('Mail me new Password'),
          onPressed: shouldEnableForm()
              ? () {
                  print(emailController.text);
                  _sendPasswordToMail();
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

  Widget _buildRegisterButton() {
    return Row(
      children: <Widget>[
        Text('Don\'t have account?'),
        TextButton(
          child: Text(
            'Register here',
            // style: TextStyle(fontSize: 20),
          ),
          onPressed: shouldEnableForm()
              ? () {
                  //signup screen
                  Navigator.pushReplacementNamed(context, "/register");
                }
              : null,
        )
      ],
      mainAxisAlignment: MainAxisAlignment.center,
    );
  }
}
