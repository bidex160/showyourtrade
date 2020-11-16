import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:showyourtrade/Provider/peopleprovider.dart';
import 'package:showyourtrade/Size_Config/Config.dart';
import 'package:showyourtrade/apptheme/app_theme.dart';
import 'package:showyourtrade/stackscreen/show_people_category.dart';
import 'package:showyourtrade/stackscreen/showpeoplerand.dart';

import '../Model/sector_industry.dart';
class PeopleScreen extends StatefulWidget {

  static const routeName = '/people';

  @override
  _PeopleScreenState createState() => _PeopleScreenState();
}

class _PeopleScreenState extends State<PeopleScreen> {

  @override
  void initState() {
   // PeopleProvider.fetchPeople();
    super.initState();
  }
  int _selectnumber =0;

  final List<dynamic> _pages = [

   ShowPeopleCategory(),
    ShowPeopleRad()


  ];

  void _selectedPage(int index){
    print(index);
    setState(() {
      _selectnumber = index;

    });

  }

  Widget build(BuildContext context) {
    return  DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: Colors.black,
        body: Stack(
          children: [
         _pages[_selectnumber],
            new Container(
              alignment: Alignment.topCenter,
              padding: new EdgeInsets.only(
                  top:Config.yMargin(context, 10),
                  right: 10.0,
                  bottom: 20,
                  left: 10.0),
              child: new Row(
              mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [

                  InkWell(child: Text('By Category',style: appThemeDark.textTheme.subhead,),
                    onTap: (){
                      _selectedPage(0);
                    },

                  ),
                  SizedBox(width: 7,),
                  Text('|',style: appThemeDark.textTheme.subhead,),
                  SizedBox(width: 7,),
                  InkWell(child: Text('By Following',style: appThemeDark.textTheme.subhead,),

                  onTap: (){
                    _selectedPage(1);
                  },),


                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
