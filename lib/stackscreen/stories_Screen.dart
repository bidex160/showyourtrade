import 'package:flutter/cupertino.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:showyourtrade/Model/index_post.dart';
import 'package:showyourtrade/Model/post_model.dart';
import 'package:showyourtrade/Size_Config/Config.dart';
import 'package:showyourtrade/apptheme/app_theme.dart';
import 'package:showyourtrade/showprofile/profilescreen.dart';
import 'package:showyourtrade/widgets/show_list.dart';
import 'package:tiktoklikescroller/tiktoklikescroller.dart';
import '../Provider/PostProvider.dart';

class StoriesScreen extends StatefulWidget {
  static const routeName = '/stories';

  @override
  _StoriesScreenState createState() => _StoriesScreenState();
}

class _StoriesScreenState extends State<StoriesScreen> {
  var loading = false;
  var _init = true;
  var userName = '';
  bool flag = true;
  String _firsthalf = '';
  String _secondhalf = '';
  List<IndexPostModel> indexPost = [];
  IndexPostModel _current;

  bool checkText(String text, int index) {
    if (text.length > 30) {
      // _firsthalf = text.substring(0,50);
      // _secondhalf = text.substring(50, text.length);
      return true;
    } else {
      _firsthalf = text;
      _secondhalf = '';
      return false;
    }
  }

  void showPicker(BuildContext context) {
    showModalBottomSheet(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(25.0),
        ),
        context: context,
        builder: (BuildContext bc) {
          return SafeArea(
            child: Container(
              // color: Colors.black,
              height: Config.yMargin(context, 80),
              child: Stack(
                children: [
                  new Container(
                      alignment: Alignment.topCenter,
                      padding:
                          new EdgeInsets.only(top: 10, right: 10.0, left: 10.0),
                      child: Text(
                        '499 commmets',
                        style: appThemeDark.textTheme.display2,
                      )),
                  new Container(
                    alignment: Alignment.topCenter,
                    padding:
                        new EdgeInsets.only(top: 35, right: 10.0, left: 10.0),
                    child: Divider(
                      color: Colors.black45,
                    ),
                  ),
                  new Container(
                      alignment: Alignment.topRight,
                      padding: new EdgeInsets.only(top: 1, right: 10.0),
                      child: IconButton(
                        icon: Icon(
                          Icons.close,
                          size: 25,
                          color: Colors.red,
                        ),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      )),
                  new Container(
                    height: Config.yMargin(context, 50),
                    alignment: Alignment.center,
                    margin: new EdgeInsets.only(
                        top: Config.yMargin(context, 6),
                        bottom: Config.yMargin(context, 10),
                        right: 5.0),
                    // color: Colors.red,
                    child: SingleChildScrollView(),
                  ),
                  new Container(
                      alignment: Alignment.bottomCenter,
                      padding: new EdgeInsets.only(
                          bottom: Config.yMargin(context, 2),
                          right: 10.0,
                          left: 10.0),
                      child: Container(
                        height: Config.yMargin(context, 6),
                        child: TextFormField(
                          decoration: InputDecoration(
                              hintText: 'Comment..',
                              border: new OutlineInputBorder(
                                borderRadius: new BorderRadius.circular(20.0),
                              ),
                              suffixIcon: IconButton(
                                icon: Icon(Icons.send),
                              )),
                        ),
                      )),
                ],
              ),
            ),
          );
        });
  }


  @override
  void initState() {
    // indexPost = PostProvider.networkQuestTest();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: StreamBuilder(
          stream:
              Provider.of<PostProvider>(context,listen: false).networkQuestTest().asStream(),
          builder: (context, AsyncSnapshot snapshot) {
            //   print(snapshot.data);

            if (snapshot.connectionState == ConnectionState.waiting) {
              return Container(
                height: Config.yMargin(context, 100),
                child: Center(
                    child: CircularProgressIndicator(
                  valueColor: new AlwaysStoppedAnimation<Color>(Colors.white),
                )),
              );
            }

            indexPost = snapshot.data;
            print(snapshot.data[0].account_name);
            print('tehn');
            return TikTokStyleFullPageScroller(
              contentSize:indexPost.length,
              swipeThreshold: 0.2,
              // ^ the fraction of the screen needed to scroll
              swipeVelocityThreshold: 2000,
              // ^ the velocity threshold for smaller scrolls
              animationDuration: const Duration(milliseconds: 300),
              // ^ how long the animation will take
              builder: (BuildContext context, int index) {

                return ChangeNotifierProvider.value(

                    value: indexPost[index],
                    // create: (c)=>indexPost[index],
                    child: ShowListItems());
              },
            );
          }),
    );
  }
}
