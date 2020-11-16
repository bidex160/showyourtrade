import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:showyourtrade/Model/index_post.dart';
import 'package:showyourtrade/Model/post_model.dart';
import 'package:showyourtrade/Size_Config/Config.dart';
import 'package:showyourtrade/showprofile/profilescreen.dart';

import '../Provider/PostProvider.dart';

class PostScreen extends StatefulWidget {
  static const routeName = '/post';

  @override
  _PostScreenState createState() => _PostScreenState();
}

class _PostScreenState extends State<PostScreen> {
  var loading = false;
  var _init = true;
  var userName = '';
  bool flag = true;
  String _firsthalf = '';
  String _secondhalf = '';
  List<IndexPostModel> indexPost = [];

  @override
  void didChangeDependencies() {
    if (_init) {
      setState(() {
        loading = true;
      });
      Provider.of<PostProvider>(context).networkQuestTest().then((value) async {
        indexPost = value;
        print('value');

        print('value');

        setState(() {
          loading = false;
        });
        final pref = await SharedPreferences.getInstance();
        userName = pref.getString('username');

        print(indexPost.length);
      });
    }
    _init = false;
    super.didChangeDependencies();
  }

  @override
  void initState() {
    // indexPost = PostProvider.networkQuestTest();
    super.initState();
  }

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

  bool checkText(String text, int index) {
    if (text.length > 30) {
      _firsthalf = text.substring(0, 30);
      _secondhalf = text.substring(30, text.length);
      return true;
    } else {
      _firsthalf = text;
      _secondhalf = '';
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(statusBarColor: Colors.transparent));

    return Scaffold(
      backgroundColor: Colors.black,
      body: indexPost.length > 0
          ? Padding(
            padding: const EdgeInsets.only(top: 45),
            child: ListView.builder(
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
                itemCount: indexPost.length,
                itemBuilder: (BuildContext context, int index) => Container(
                  // height: Config.yMargin(context, 80),
                  //  width: Config.xMargin(context, 100),
                  margin:
                      const EdgeInsets.symmetric(horizontal: 0.0, vertical: 10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(15),
                        topRight: Radius.circular(15),
                        bottomLeft: Radius.circular(15),
                        bottomRight: Radius.circular(15)),
                  ),
                  child: Column(
                    children: [
                      Container(
                        // height: Config.yMargin(context, 35),

                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Container(
                                  child: CircleAvatar(
                                    radius: 20,
                                    backgroundColor: Colors.white,
                                    backgroundImage: indexPost[index].avatar !=
                                            null
                                        ? NetworkImage(
                                            'https://showyourtrade.com/user/${indexPost[index].account_name}/${indexPost[index].avatar}')
                                        : null
                                  ),
                                  margin:
                                      const EdgeInsets.only(right: 8, left: 8),
                                  //  width: Config.xMargin(context, 15),
                                ),
                                Text(
                                  '${indexPost[index].account_name}',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                  ),
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.only(left: 8, right: 8),
                                  child: CircleAvatar(
                                    backgroundColor: Colors.white,
                                    radius: 2,
                                  ),
                                ),
                                FittedBox(
                                  child: Text(
                                    'follow',
                                    style: TextStyle(
                                        fontSize: 16,
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.only(left: 8, right: 8),
                                  child: CircleAvatar(
                                    backgroundColor: Colors.white,
                                    radius: 2,
                                  ),
                                ),
                                _datePosted(indexPost[index].postdate, index)
                              ],
                            ),
                            if(indexPost[index].statusphoto.isEmpty)
                              SizedBox(height: 7,),
                            Container(
                              width: Config.xMargin(context, 100),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    width: Config.xMargin(context, 100),
                                    child: Text(
                                      '${indexPost[index].data}',
                                      textAlign: TextAlign.justify,
                                      style: TextStyle(
                                        fontSize: 16,
                                        color: Colors.white,
                                      ),
                                    ),
                                    margin: const EdgeInsets.only(
                                        left: 8, right: 8, top: 8),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                      if(indexPost[index].statusphoto.isNotEmpty)       Container(
                        height: Config.yMargin(context, 40),
                        width: Config.xMargin(context, 100),
                        margin: const EdgeInsets.only(top: 8, bottom: 8),
                        decoration: BoxDecoration(
                            // shape: BoxShape.rectangle,
                            image: DecorationImage(
                                fit: BoxFit.cover,

                                //    image:AssetImage('${posts[index].url}') ,
                                image: indexPost[index].osid ==
                                        indexPost[index].id
                                    ? NetworkImage(
                                        'https://showyourtrade.com/user/${indexPost[index].account_name}/status/${indexPost[index].statusphoto}')
                                    : null)),
                      ),

                      if(indexPost[index].statusphoto.isEmpty)
                        SizedBox(height: 7,),
                      Container(
                        // height: Config.yMargin(context, 5),
                        child: new Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          //crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              height: Config.yMargin(context, 8),
                              //  color: Colors.white,
                              child: Column(
                                //crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Container(
                                    height: Config.yMargin(context, 4),
                                    child: IconButton(
                                        icon: Icon(
                                          Icons.favorite_outline_rounded,
                                          color: Colors.white,
                                          size: 20,
                                        ),
                                        onPressed: null),
                                  ),
                                  Container(
                                    padding: const EdgeInsets.only(top: 5),
                                    height: Config.yMargin(context, 3),
                                    child: FittedBox(
                                      child: Text(
                                        '${indexPost[index].likes}',
                                        style: TextStyle(
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              //    width: Config.xMargin(context, 6),
                              height: Config.yMargin(context, 8),
                              //  color: Colors.white,
                              child: Column(
                                //crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Container(
                                    height: Config.yMargin(context, 4),
                                    child: IconButton(
                                        icon: Icon(
                                          Icons.repeat_outlined,
                                          color: Colors.white,
                                          size: 20,
                                        ),
                                        onPressed: null),
                                  ),
                                  Container(
                                    height: Config.yMargin(context, 3),
                                    padding: const EdgeInsets.only(top: 5),
                                    child: FittedBox(
                                      child: Text(
                                        '10',
                                        style: TextStyle(
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              //    width: Config.xMargin(context, 6),
                              height: Config.yMargin(context, 8),
                              //  color: Colors.white,
                              child: Column(
                                //crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Container(
                                    height: Config.yMargin(context, 4),
                                    child: IconButton(
                                        icon: Icon(
                                          Icons.mode_comment_outlined,
                                          color: Colors.white,
                                          size: 20,
                                        ),
                                        onPressed: null),
                                  ),
                                  Container(
                                    height: Config.yMargin(context, 3),
                                    padding: const EdgeInsets.only(top: 5),
                                    child: FittedBox(
                                      child: Text(
                                        '${indexPost[index].comment}',
                                        style: TextStyle(
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              //    width: Config.xMargin(context, 6),
                              height: Config.yMargin(context, 8),
                              //  color: Colors.white,
                              child: Column(
                                //crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Container(
                                    height: Config.yMargin(context, 4),
                                    child: IconButton(
                                        icon: Icon(
                                          Icons.share,
                                          color: Colors.white,
                                          size: 20,
                                        ),
                                        onPressed: null),
                                  ),
                                  Container(
                                    height: Config.yMargin(context, 3),
                                    padding: const EdgeInsets.only(top: 5),
                                    child: FittedBox(
                                      child: Text(
                                        '10',
                                        style: TextStyle(
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Divider(
                        color: Colors.white,
                      )
                    ],
                  ),
                ),
              ),
          )
          : Container(
              height: Config.yMargin(context, 100),
              child: Center(
                  child: CircularProgressIndicator(
                valueColor: new AlwaysStoppedAnimation<Color>(Colors.white),
              )),
            ),
    );
  }
}
