import 'package:flutter/material.dart';
import 'package:virtual_lab/components/appbar.dart';
import 'package:virtual_lab/components/bottom_navigation.dart';
import 'package:virtual_lab/components/swipe_navigation.dart';

class AboutScreen extends StatefulWidget {
  const AboutScreen({Key? key}) : super(key: key);

  @override
  _AboutScreenState createState() => _AboutScreenState();
}

class _AboutScreenState extends State<AboutScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: HomeAppBar("About us"),
      drawer: HomeDrawer(context),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: ListView(
          children: [
            Container(
              height: 20,
            ),
            Text(
              "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Eget mi proin sed libero enim sed faucibus. Viverra adipiscing at in tellus integer feugiat scelerisque varius morbi. Bibendum ut tristique et egestas quis ipsum suspendisse. Vel elit scelerisque mauris pellentesque pulvinar pellentesque habitant. In vitae turpis massa sed elementum tempus egestas. Lobortis elementum nibh tellus molestie nunc non. Purus in massa tempor nec feugiat. Congue nisi vitae suscipit tellus mauris a diam maecenas sed. Pellentesque habitant morbi tristique senectus et netus et malesuada fames. Tempus imperdiet nulla malesuada pellentesque. Amet consectetur adipiscing elit duis tristique sollicitudin. Arcu cursus vitae congue mauris rhoncus aenean vel. Pellentesque diam volutpat commodo sed egestas egestas. Massa id neque aliquam vestibulum morbi blandit cursus risus at. Eget magna fermentum iaculis eu. Nisi porta lorem mollis aliquam ut porttitor.",
              style: TextStyle(
                letterSpacing: 1,
              ),
              textAlign: TextAlign.justify,
            ),
            Container(
              height: 20,
            ),
            Text(
              "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Eget mi proin sed libero enim sed faucibus. Viverra adipiscing at in tellus integer feugiat scelerisque varius morbi. Bibendum ut tristique et egestas quis ipsum suspendisse. Vel elit scelerisque mauris pellentesque pulvinar pellentesque habitant. In vitae turpis massa sed elementum tempus egestas. Lobortis elementum nibh tellus molestie nunc non. Purus in massa tempor nec feugiat. Congue nisi vitae suscipit tellus mauris a diam maecenas sed. Pellentesque habitant morbi tristique senectus et netus et malesuada fames. Tempus imperdiet nulla malesuada pellentesque. Amet consectetur adipiscing elit duis tristique sollicitudin. Arcu cursus vitae congue mauris rhoncus aenean vel. Pellentesque diam volutpat commodo sed egestas egestas. Massa id neque aliquam vestibulum morbi blandit cursus risus at. Eget magna fermentum iaculis eu. Nisi porta lorem mollis aliquam ut porttitor.",
              style: TextStyle(
                letterSpacing: 1,
              ),
              textAlign: TextAlign.justify,
            ),
          ],
        ),
      ),
      bottomNavigationBar: HomeBottomNavigationBar(context),
    );
  }
}
