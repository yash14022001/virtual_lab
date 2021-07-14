import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool _showPassword = false;
  bool _loading = false;
  String messageFromServer = "";

  @override
  void dispose() {
    // Clean up the controller when the widget is removed from the
    // widget tree.
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  bool shouldEnableForm() {
    return !_loading;
  }

  Future<void> _doLogin() async {
    _showLoaderInLoginButton();
    await _makeLoginRequest();
    _unshowLoaderInLoginButton();
  }

  void _showLoaderInLoginButton() {
    setState(() {
      _loading = true;
    });
  }

  void _unshowLoaderInLoginButton() {
    setState(() {
      _loading = false;
    });
  }

  Future<void> _makeLoginRequest() async {
    await Future.delayed(const Duration(seconds: 2), () {
      if (emailController.text == "test@mail.com" &&
          passwordController.text == "1234") {
        Navigator.pushReplacementNamed(context, "/home");
      } else {
        messageFromServer =
            "Wrong Credentials entered. Please check your if your email or password is right!";
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
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
            if (messageFromServer != "") _showAlertBox(),
            if (messageFromServer == "") ...[
              _buildEmail(),
              _buildPassword(),
              _buildLoginButton(),
              _buildForgotPasswordButton(),
              _buildRegisterButton(),
            ],
          ],
        ),
      ),
    );
  }

  Widget _showAlertBox() {
    return AlertDialog(
      title: Text("Error occurred", style: TextStyle(color: Colors.red)),
      content: Text(messageFromServer),
      actions: [
        TextButton(
          onPressed: () {
            setState(() {
              messageFromServer = "";
            });
          },
          child: Text("OK"),
        )
      ],
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
        enabled: shouldEnableForm(),
        controller: emailController,
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

  Widget _buildPassword() {
    return Container(
      padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
      child: TextField(
        enabled: shouldEnableForm(),
        textInputAction: TextInputAction.done,
        obscureText: !_showPassword,
        controller: passwordController,
        decoration: InputDecoration(
          border: OutlineInputBorder(),
          labelText: 'Password',
          hintText: 'Enter your password',
          prefixIcon: new Icon(Icons.password),
          suffixIcon: new IconButton(
            icon: Icon(
              _showPassword ? Icons.visibility : Icons.visibility_off,
            ),
            onPressed: () {
              setState(() {
                _showPassword = !_showPassword;
              });
            },
          ),
        ),
      ),
    );
  }

  Widget _buildTitle() {
    return Container(
      alignment: Alignment.center,
      padding: EdgeInsets.all(10),
      child: Text(
        'Login',
        style: TextStyle(fontSize: 20, fontFamily: "Lato"),
      ),
    );
  }

  Widget _buildLoginButton() {
    return Padding(
      padding: const EdgeInsets.only(top: 15.0),
      child: Container(
        height: 50,
        padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
        child: ElevatedButton(
          child: _loading
              ? CircularProgressIndicator(
                  color: Colors.white,
                )
              : Text('Login'),
          onPressed: shouldEnableForm()
              ? () {
                  print(emailController.text);
                  print(passwordController.text);
                  _doLogin();
                }
              : null,
        ),
      ),
    );
  }

  Widget _buildForgotPasswordButton() {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: TextButton(
        onPressed: shouldEnableForm()
            ? () {
                //forgot password screen
                Navigator.pushReplacementNamed(context, "/forgot-password");
              }
            : null,
        style: TextButton.styleFrom(
          primary: Theme.of(context).primaryColor,
        ),
        child: Text('Forgot Password'),
      ),
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
