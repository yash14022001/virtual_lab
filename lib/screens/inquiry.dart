import 'package:flutter/material.dart';
import 'package:virtual_lab/components/appbar.dart';
import 'package:virtual_lab/components/bottom_navigation.dart';
import 'package:virtual_lab/components/swipe_navigation.dart';

class InquiryScreen extends StatefulWidget {
  const InquiryScreen({Key? key}) : super(key: key);

  @override
  _InquiryScreenState createState() => _InquiryScreenState();
}

class _InquiryScreenState extends State<InquiryScreen> {
  TextEditingController inquiryController = TextEditingController();
  bool _isSendingToServer = false;
  bool _succeedInquiry = false;
  String messageFromServer = "";

  @override
  void dispose() {
    // Clean up the controller when the widget is removed from the
    // widget tree.
    inquiryController.dispose();
    super.dispose();
  }

  bool shouldEnableForm() {
    return !_isSendingToServer;
  }

  Future<void> _doInquiry() async {
    setState(() {
      _isSendingToServer = true;
    });

    await Future.delayed(Duration(seconds: 3), () {
      setState(() {
        if (inquiryController.text.isNotEmpty) {
          _succeedInquiry = true;
          messageFromServer =
              "Your inquiry has been sent. It would be viewed soon!";
        } else {
          _succeedInquiry = false;
          messageFromServer =
              "There was some problem sending your inquiry. Please try again later!";
        }
        _isSendingToServer = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: HomeAppBar("Send us Inquiry"),
      drawer: HomeDrawer(context),
      body: Padding(
        padding: EdgeInsets.all(10),
        child: _succeedInquiry
            ? _showAlertDialog(
                "Successfully sent", messageFromServer, "Ok, take me to home",
                () {
                Navigator.popUntil(
                    context, (route) => route.settings.name == "/home");
              }, false)
            : messageFromServer != ""
                ? _showAlertDialog("Error occurred", messageFromServer, "Ok",
                    () {
                    setState(() {
                      messageFromServer = "";
                    });
                  }, true)
                : ListView(
                    children: <Widget>[
                      _buildInquiryTextField(),
                      _buildInquiryButton(),
                    ],
                  ),
      ),
      bottomNavigationBar: HomeBottomNavigationBar(context),
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

  Widget _buildInquiryTextField() {
    return Container(
      padding: EdgeInsets.all(10),
      child: TextField(
        controller: inquiryController,
        enabled: shouldEnableForm(),
        textInputAction: TextInputAction.done,
        maxLines: 8,
        decoration: InputDecoration(
          border: OutlineInputBorder(),
          labelText: 'Inquiry',
          hintText: 'Enter your inquiry',
        ),
      ),
    );
  }

  Widget _buildInquiryButton() {
    return Container(
      height: 50,
      child: ElevatedButton(
        onPressed: shouldEnableForm()
            ? () {
                _doInquiry();
              }
            : null,
        child: _isSendingToServer
            ? CircularProgressIndicator()
            : Text("Send Inquiry"),
      ),
    );
  }
}
