import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:virtual_lab/components/CustomDropDown.dart';
import 'package:virtual_lab/components/appbar.dart';
import 'package:virtual_lab/components/bottom_navigation.dart';
import 'package:virtual_lab/components/swipe_navigation.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class PracticalScreen extends StatefulWidget {
  const PracticalScreen({Key? key}) : super(key: key);

  @override
  _PracticalScreenState createState() => _PracticalScreenState();
}

class _PracticalScreenState extends State<PracticalScreen> {
  late Map<String, dynamic> inputs = {};
  late Map<String, dynamic> outputs = {};
  late String practicalAim;

  late Map<String, dynamic> selectedInput = {};
  late Map<String, dynamic> finalOutputs = {};
  late Random random;

  String videoId = YoutubePlayer.convertUrlToId(
          "https://www.youtube.com/watch?v=QrnNEQAOLKw") ??
      "";

  bool isLoadingFromServer = false;

  Future<void> getPracticalData() async {
    setLoadingFromServer(true);
    await makePracticalDataGetRequest();
    setLoadingFromServer(false);
  }

  Future<void> makePracticalDataGetRequest() async {
    await Future.delayed(new Duration(seconds: 2), () {
      setState(() {
        inputs["Voltage"] = {
          "V1": [
            "10",
            "10abcdefjhijklmnopqrstuvwxyzabcdefghijklmnopqrstuvwxyxabcdefghijklmnopqrstuvwxyz",
            "20",
            "30"
          ],
          "V2": [
            "20",
            "40",
            "60",
            "Te",
            "11",
            "Tw",
            "13",
            "Fo",
            "15",
            "Si",
            "17",
            "Ei",
            "19",
            "Tw",
            "21",
            "22",
            "23",
            "24",
            "25",
            "26",
            "27",
            "28",
            "29",
            "30",
            "31",
            "32",
            "33",
            "34",
            "35",
            "36",
            "37",
            "38",
            "39",
            "41",
            "42",
            "43",
            "44",
            "45",
            "46",
            "47",
            "48",
            "49",
            "50",
            "51",
            "52",
            "53",
            "54",
            "55",
            "56",
            "57",
            "58",
            "59",
            "61",
            "62",
            "63",
            "64",
            "65",
            "66",
            "67",
            "68",
            "69",
            "70",
          ],
          "V3": ["30", "60", "90"],
        };
        inputs["Resistance"] = {
          "R1": ["5", "10", "15"],
          "R2": ["15", "20", "25"],
          "R3": ["5", "10", "15"],
          "R4": ["15", "20", "25"],
          "R5": ["5", "10", "15"],
          "R6": ["15", "20", "25"],
          "R7": ["5", "10", "15"],
          "R8": ["15", "20", "25"],
          "R9": ["5", "10", "15"],
          "R10": ["15", "20", "25"],
          "R11": ["5", "10", "15"],
          "R12": ["15", "20", "25"],
        };

        selectedInput["Voltage"] = {};
        selectedInput["Voltage"]["V1"] = "10";
        selectedInput["Voltage"]["V2"] = "20";
        selectedInput["Voltage"]["V3"] = "30";

        selectedInput["Resistance"] = {};
        selectedInput["Resistance"]["R1"] = "5";
        selectedInput["Resistance"]["R2"] = "15";
        selectedInput["Resistance"]["R3"] = "5";
        selectedInput["Resistance"]["R4"] = "15";
        selectedInput["Resistance"]["R5"] = "5";
        selectedInput["Resistance"]["R6"] = "15";
        selectedInput["Resistance"]["R7"] = "5";
        selectedInput["Resistance"]["R8"] = "15";
        selectedInput["Resistance"]["R9"] = "5";
        selectedInput["Resistance"]["R10"] = "15";
        selectedInput["Resistance"]["R11"] = "5";
        selectedInput["Resistance"]["R12"] = "15";

        outputs["Temperature"] = {
          "Temp1": ["60", "120", "180"],
          "Temp2": ["10", "140", "270"],
        };
        finalOutputs["Temperature"] = {
          "Temp1": "60",
          "Temp2": "10",
        };
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
    getPracticalData();
  }

  @override
  Widget build(BuildContext context) {
    random = new Random();
    practicalAim = (ModalRoute.of(context)!.settings.arguments as Map)['aim'];
    print(ModalRoute.of(context)!.settings.arguments);
    return Scaffold(
      appBar: HomeAppBar("Practical"),
      drawer: HomeDrawer(context),
      body: isLoadingFromServer
          ? Center(
              child: CircularProgressIndicator(),
            )
          : ListView(
              children: [
                _buildAim(),
                _buildYoutubeVideoPlayer(),
                _buildInputSection(),
                _buildOutputSection(),
              ],
            ),
      bottomNavigationBar: HomeBottomNavigationBar(context),
    );
  }

  Widget _buildPracticalHeading(String heading) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(
        heading,
        style: Theme.of(context).textTheme.headline5!.copyWith(
              color: Theme.of(context).primaryColorDark,
              decoration: TextDecoration.underline,
            ),
      ),
    );
  }

  Widget _buildAim() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildPracticalHeading("Practical Aim :"),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              practicalAim,
              style: Theme.of(context).textTheme.subtitle2,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInputSection() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildPracticalHeading("Inputs :"),
          ...inputs.keys.map((inputName) {
            return _buildInputType(inputName);
          }).toList(),
        ],
      ),
    );
  }

  Widget _buildOutputSection() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildPracticalHeading("Outputs :"),
          ...outputs.keys.map((inputName) {
            return _buildOutputType(inputName);
          }).toList(),
        ],
      ),
    );
  }

  Widget _buildOutputType(String outputType) {
    print(outputType);
    print(outputs[outputType]);
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: Theme.of(context).primaryColor,
        ),
      ),
      padding: EdgeInsets.all(5),
      margin: EdgeInsets.all(5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            outputType,
            style: Theme.of(context).textTheme.subtitle1!.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
          SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.all(8.0),
            // child: GridView.builder(
            //     shrinkWrap: true,
            //     physics: new NeverScrollableScrollPhysics(),
            //     gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
            //         maxCrossAxisExtent: 500,
            //         childAspectRatio: 4 / 1.5,
            //         crossAxisSpacing: 10,
            //         mainAxisSpacing: 10),
            //     itemCount: outputs[outputType].keys.length,
            //     itemBuilder: (BuildContext ctx, index) {
            //       return _buildOutputLabel(
            //           outputType, outputs[outputType].keys.toList()[index]);
            //     }),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                ...outputs[outputType]
                    .keys
                    .toList()
                    .map((outputName) =>
                        _buildOutputLabel(outputType, outputName))
                    .toList(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOutputLabel(String outputType, String outputName) {
    return Padding(
      padding: const EdgeInsets.all(2.0),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: [
          Expanded(
            child: Text(
              "$outputName : ",
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.right,
            ),
            flex: 4,
          ),
          SizedBox(
            width: 10,
          ),
          Expanded(
            flex: 6,
            child: Container(
              padding: EdgeInsets.all(5),
              decoration: BoxDecoration(
                color: Color.fromRGBO(100, 100, 100, 0.3),
              ),
              child: Text(
                finalOutputs[outputType][outputName].toString(),
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInputType(String inputType) {
    print(inputType);
    print(inputs[inputType]);
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: Theme.of(context).primaryColor,
        ),
      ),
      padding: EdgeInsets.all(5),
      margin: EdgeInsets.all(5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            inputType,
            style: Theme.of(context).textTheme.subtitle1!.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
          SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: GridView.builder(
                shrinkWrap: true,
                physics: new NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                    maxCrossAxisExtent: 200,
                    childAspectRatio: 4 / 1.5,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10),
                itemCount: inputs[inputType].keys.length,
                itemBuilder: (BuildContext ctx, index) {
                  return _buildInputDropdown(
                      inputType, inputs[inputType].keys.toList()[index]);
                }),
          ),
        ],
      ),
    );
  }

  Widget _buildInputDropdown(String inputType, String inputName) {
    return Padding(
      padding: const EdgeInsets.all(2.0),
      child: CustomDropDown<String>(
          getLabel: (item) => item.toString(),
          options: inputs[inputType][inputName],
          value: selectedInput[inputType][inputName],
          hintText: inputName,
          onChanged: (newValue) {
            setState(() {
              selectedInput[inputType][inputName] = newValue;
              outputs["Temperature"].keys.toList().forEach((outputName) {
                print(outputName);
                finalOutputs["Temperature"][outputName] =
                    random.nextInt(100).toString();
              });
            });
          }),
    );
  }

  Widget _buildYoutubeVideoPlayer() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildPracticalHeading("Youtube video :"),
          Container(
            padding: EdgeInsets.all(8),
            child: YoutubePlayer(
              controller: YoutubePlayerController(
                initialVideoId: videoId, //Add videoID.
                flags: YoutubePlayerFlags(
                  hideControls: false,
                  controlsVisibleAtStart: true,
                  autoPlay: false,
                  mute: false,
                ),
              ),
              showVideoProgressIndicator: true,
              progressIndicatorColor: Theme.of(context).primaryColor,
            ),
          ),
        ],
      ),
    );
  }
}
