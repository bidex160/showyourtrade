
import 'package:flutter/material.dart';
import '../Size_Config/Config.dart';
import '../Model/userprofile/userposts.dart';
import '../apptheme/app_theme.dart';

class UsersPostScreen extends StatefulWidget {
  static const routeName = '/UsersPostScreen';
  @override
  _UsersPostScreenState createState() => _UsersPostScreenState();
}

class _UsersPostScreenState extends State<UsersPostScreen> {
  Widget _datePosted(String date, int index) {
    final postedDate = DateTime.parse(date);
    //final da = DateTime(postedDate);
    final _current = DateTime.now();
    return FittedBox(
      child: Text(
        ' ${_current.difference(postedDate).inDays > 30 ? '${_current.difference(postedDate).inDays ~/ 30} months ago' : ' ${_current.difference(postedDate).inDays} days ago'}  ',
        style: TextStyle(
          color: Colors.white,
        ),
      ),
    );
  }
  @override
  Widget build(BuildContext context) {
    final modalArg = ModalRoute.of(context).settings.arguments as Map<String,  List<UserPosts>>;
    final postList = modalArg['list'];
    return Scaffold(
      backgroundColor: appThemeDark.backgroundColor,
      body: Padding(
        padding: const EdgeInsets.only(top: 45),
       child: Center(
         child: Text('${postList.length}', style: TextStyle(
           color: Colors.white
         ),),
       ),
      )
    );
  }
}
