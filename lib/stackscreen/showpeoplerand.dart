
import 'package:flutter/material.dart';
import 'package:showyourtrade/Size_Config/Config.dart';
import 'package:showyourtrade/apptheme/app_theme.dart';
class ShowPeopleRad extends StatefulWidget {
  static const routeName = '/peopleRand';
  @override
  _ShowPeopleRadState createState() => _ShowPeopleRadState();
}

class _ShowPeopleRadState extends State<ShowPeopleRad> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Container(
        height: Config.yMargin(context, 100),
        child: Center(child: Text('No people yet', style: appThemeDark.textTheme.subhead,), ),
      ),
    );
  }
}
