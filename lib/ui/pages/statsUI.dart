import 'package:flip_card/flip_card.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:loginv1/constants/theme.dart';
import 'package:loginv1/ui/widgets/reusable_card.dart';


class StatsUI extends StatefulWidget {
  const StatsUI({Key? key}) : super(key: key);

  @override
  _StatsUIState createState() => _StatsUIState();
}

class _StatsUIState extends State<StatsUI> {
  int _currentIndexNumber = 0;
  double _initial = 0.1;

  @override
  Widget build(BuildContext context) {
    String value = (_initial * 10).toStringAsFixed(0);
    return Scaffold(
        backgroundColor: Colors.grey.shade100,
        appBar: AppBar(
            centerTitle: true,
            title: Text("stats".tr, style: TextStyle(fontSize: 30)),
            backgroundColor: primaryClr,
            toolbarHeight: 80,
            elevation: 5,
            shadowColor: primaryClr,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20))),
        body: Center(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
              Text("statsEvent".tr, style: otherTextStyle),
              SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: LinearProgressIndicator(
                  backgroundColor: secClr,
                  valueColor: AlwaysStoppedAnimation(primaryClr),
                  minHeight: 1,
                  value: 5,
                ),
              ),
              SizedBox(height: 25),
              SizedBox(
                  width: 500,
                  height: 500,
                ),
              Text("pressStats".tr, style: otherTextStyle),
              SizedBox(height: 20),
              Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
              
               
                  ])
            ])));
  }

}
