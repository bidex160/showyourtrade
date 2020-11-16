import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:showyourtrade/videoeditorscreen.dart';
import 'package:video_player/video_player.dart';
import 'package:html_editor/html_editor.dart';
import 'package:text_editor/text_editor.dart';
import 'package:image_editor_pro/image_editor_pro.dart';
import 'package:video_trimmer/video_trimmer.dart';
import '../Size_Config/Config.dart';
import 'package:video_trimmer/video_trimmer.dart';

import 'package:path_provider/path_provider.dart' as syspath;
import 'package:path/path.dart' as path;

import 'package:http/http.dart' as http;

import 'package:image_picker/image_picker.dart';

import '../apptheme/app_theme.dart';

class UploadScreen extends StatefulWidget {
  static const routeName = '/photos';

  @override
  _UploadScreenState createState() => _UploadScreenState();
}

class _UploadScreenState extends State<UploadScreen> {



  final fonts = [
    'OpenSans',
    'Billabong',
    'GrandHotel',
    'Oswald',
    'Quicksand',
  ];
  TextStyle _textStyle = TextStyle(
    fontSize: 50,
    color: Colors.white,
    fontFamily: 'Billabong',
  );
  String _text = 'Sample Text';
  TextAlign _textAlign = TextAlign.center;
  VideoPlayerController videoPlayerController;
  File pickedImage;

  int _selectnumber = 0;
  GlobalKey<HtmlEditorState> _keyEditor = GlobalKey();

   Trimmer _trimmer = Trimmer();


  // void _uploadImage() async {
  //   if (picked != null) {
  //     print("here");
  //     //String base64Image = base64Encode(picked.readAsBytesSync());
  //     String fileName = picked.path.split('/').last;
  //     //  var para = {'action':'status_post','data':'Just Testing though', 'type':'a','u':'bidex160', 'user':'bidex160','photoId':'$base64Image'};
  //     print("here");
  //     print(fileName);
  //     var para = {
  //       'u': 'bidex160',
  //       'status_photo': '$picked',
  //       'name': '$fileName'
  //     };
  //     var url = 'https://www.showyourtrade.com/php_parsers/bidemiImage.php';
  //     var res = await http.post(url, body: para);
  //     if (res.statusCode == 200) {
  //       print(res.body);
  //       print(fileName);
  //
  //       //  final pref = await SharedPreferences.getInstance();
  //       // pref.setString('username', '${_username.text.trim()}');
  //
  //       // Navigator.of(context).pushReplacementNamed(TabScreen.routeName);
  //     } else {
  //       print(res.body);
  //     }
  //   } else {
  //     return;
  //   }
  // }

  @override
  void initState() {
    setState(() {

    });

    super.initState();
  }

  Future<void> _videoGallery() async {
    File video = await ImagePicker.pickVideo(
      source: ImageSource.gallery,
    );
    setState(() {
      pickedImage = null;
     // pickedVideo = video;

    });

    if (video != null) {
      await _trimmer.loadVideo(videoFile: video);

        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) {
          return VideoEditorScreen(_trimmer);
        }));


    }

    // videoPlayerController = VideoPlayerController.file(pickedVideo)
    //   ..initialize().then((value) {
    //     setState(() {});
    //     videoPlayerController.play();
    //   });
    // final appdir = await syspath.getApplicationDocumentsDirectory();
    // final filename  = path.basename(appdir.path);
    // final saveImage = await imagefile.copy('${appdir.path}/$filename');
    //  print(pickedImage);
  }

  Future<void> getimageditor() {
    final geteditimage =
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return ImageEditorPro(
        appBarColor: Colors.blue,
        bottomBarColor: Colors.blue,
      );
    })).then((geteditimage) {
      if (geteditimage != null) {
        setState(() {
          pickedImage = geteditimage;


        });


      }


    }).catchError((er) {
      print(er);
    });
  }
  void uploadit() async{
   var  filenane = pickedImage.path.split('/').last;
   // var dio = Dio();
   // print(filenane);
   // FormData formData = FormData.fromMap({
   //   "file": await MultipartFile.fromFile("${pickedImage.path}",filename: "$filenane")
   // });
 //  var para = {'status_photo':'$_file','name':'$filenane'};
   // var urp ='https://showyourtrade.com/php_parsers/status_system.php';
  // var url ='https://showyourtrade.com/php_parsers/bidemiImage.php';
   print('yesssssssssssssssssssssssssss');
   //var res = await dio.post(url,data: formData);
    var para = {'status_photo':'${base64Encode(pickedImage.readAsBytesSync())}','name':'$filenane'};
    // var url ='https://www.showyourtrade.com/upload_video.php';
   var url ='https://showyourtrade.com/php_parsers/bidemiImage.php';
   var res2  = await http.post(url,body: para);
    if(res2.statusCode ==200){
      print(pickedImage.path);
      print('ccc');
//      print(res.data);
      print(res2.body);
      print('cc');

    }else{
      print('nor communicating');
    }
  }

  File _image;
  @override
  void didChangeDependencies() async {
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
    appBar: AppBar(
      actions: [
        Container(
            height: Config.yMargin(context, 3),
            child: FlatButton(

                child: Text(
                  'Next',
                  style: appThemeDark.textTheme.subhead,
                ))),


      ],
    ),
      body: Stack(
        children: [

          //picked imagee
          if (pickedImage != null)
            new Container(
              padding: new EdgeInsets.only(
                  bottom: Config.yMargin(context, 5),
                  top: 10,
                  right: 0.0,
                  left: 0.0),
              decoration: BoxDecoration(
                  shape: BoxShape.rectangle,
                  image: DecorationImage(
                      fit: BoxFit.contain,
                      image:
                          pickedImage != null ? FileImage(pickedImage) : null)),
            ),





        //button
          if ( pickedImage != null)
            new Container(
                //    height: Config.yMargin(context, 5),
                alignment: Alignment.bottomCenter,
                padding: new EdgeInsets.only(
                    top: Config.yMargin(context, 70), right: 15.0, left: 10.0),
                child: Container(
                    width: Config.xMargin(context, 100),
                    decoration: BoxDecoration(
                      shape: BoxShape.rectangle,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: Colors.white),
                    ),
                    height: Config.yMargin(context, 5),
                    child: FlatButton(
                        onPressed: () {
                       uploadit();
                        },
                        child: Text(
                          'Next',
                          style: appThemeDark.textTheme.subhead,
                        )))),



          //side bar navigation
          new Container(
            alignment: Alignment.topRight,
            padding: new EdgeInsets.only(
                top: Config.yMargin(context, 15), right: 15.0, left: 10.0),
            child: Container(
              height: Config.yMargin(context, 20),
              child: new Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [

                  Container(
                    width: Config.xMargin(context, 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        IconButton(
                            icon: Icon(
                              Icons.camera,
                              color: Colors.white,
                              size: 25,
                            ),
                            onPressed: () {
                              getimageditor();

                            }),
                        FittedBox(
                            child: Text('Photo',
                                textAlign: TextAlign.center,
                                style: appThemeDark.textTheme.display1)),
                      ],
                    ),
                  ),
                  Container(
                    width: Config.xMargin(context, 10),
                    child: FittedBox(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          IconButton(
                              icon: Icon(
                                Icons.videocam,
                                color: Colors.white,
                                size: 25,
                              ),
                              onPressed: () => _videoGallery()),
                          FittedBox(
                            child: Text('Video',
                                style: appThemeDark.textTheme.display1),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),

    );
  }
}
