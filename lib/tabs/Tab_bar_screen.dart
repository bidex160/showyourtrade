import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:showyourtrade/Drawer.dart';
import 'package:showyourtrade/stackscreen/PostScreen.dart';
import 'package:showyourtrade/Provider/PostProvider.dart';
import 'package:showyourtrade/Size_Config/Config.dart';
import 'package:showyourtrade/account/login.dart';
import 'package:showyourtrade/apptheme/app_theme.dart';
import 'People_Screen.dart';
import '../stackscreen/upload.dart';
import '../stackscreen/stories_Screen.dart';
import 'Products_Screen.dart';
import '../Search.dart';

class TabScreen extends StatefulWidget {

   static const routeName = '/Tabscreen';
  @override
  _TabScreenState createState() => _TabScreenState();
}

class _TabScreenState extends State<TabScreen> {

  int _selectnumber =0;

  final List<dynamic> _pages = [

    StoriesScreen(),
    PostScreen(),
    UploadScreen(),
    ProductsScreen(),
    PeopleScreen()
  //  PhotosScreen(),


  ];

  void _selectedPage(int index){
    print(index);
    setState(() {
      _selectnumber = index;

    });

  }
  @override
  void initState() {
  // PostProvider.networkQuestTest();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(statusBarColor: Colors.transparent));
    return DefaultTabController(

        length: 5, child: Scaffold(
      ///endDrawer: DrawerScreen(),

      body:Stack(
        children: [


          _pages[_selectnumber],
          new Container(
            alignment: Alignment.topCenter,
            padding: new EdgeInsets.only(
                top:Config.yMargin(context, 3),
                right: 10.0,
                left: 10.0),
            child: new Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(icon: Icon(Icons.account_circle_outlined,
                  size: 25,
                  color: Colors.white,),
                  onPressed: (){
                 Navigator.of(context).pushNamed(LoginScreen.routeName);
                  },
                ),
             Row(
               children: [
                 IconButton(icon: Icon(
                   Icons.search,
                   color: Colors.white,
                   // size: 25,
                 ), onPressed: null),
                 IconButton(icon: Icon(
                   Icons.notifications_none,
                   color: Colors.white,
                   // size: 25,
                 ), onPressed: null),
                 IconButton(icon: Icon(
                   Icons.mail_outline,
                   color: Colors.white,

                   // size: 25,

                 ), onPressed: null),
               ],
             )


              ],
            ),
          ),


        ],
      ),


      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.black,

        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(

            icon: Icon(Icons.amp_stories,
         size: 25,),
            title: Text('Shows'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.all_inclusive,
              size: 25,),
            title: Text('Posts'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add_box_rounded,
              size: 25,),
            title: Text('Upload'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.store,
              size: 25,
            ),
            title: Text('Products'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.people,
              size: 25,),
            title: Text('Services'),
          ),
        ],
        currentIndex: _selectnumber,
        selectedItemColor: Colors.blueAccent,
        unselectedItemColor: Colors.white,
        onTap:_selectedPage,
      ),
    )
    );
  }
}
