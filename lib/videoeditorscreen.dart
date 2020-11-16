import 'dart:convert';
import 'dart:io';
import 'package:showyourtrade/videofilter.dart';
import 'package:video_trimmer/video_trimmer.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
//import 'package:dio/dio.dart';
import 'package:path/path.dart';
import 'Size_Config/Config.dart';
import 'apptheme/app_theme.dart';

class VideoEditorScreen extends StatefulWidget {
  final Trimmer _trimmer;
  VideoEditorScreen(this._trimmer);
  @override
  _VideoEditorScreenState createState() => _VideoEditorScreenState();
}

class _VideoEditorScreenState extends State<VideoEditorScreen> {

  double _startValue = 0.0;
  double _endValue = 0.0;

  bool _isPlaying = false;
  bool _progressVisibility = false;
  File _file;
  var filenane;
  Future<String> _saveVideo() async {

    setState(() {
      _progressVisibility = true;
    });

    String _value;

    await widget._trimmer
        .saveTrimmedVideo(startValue: _startValue, endValue: _endValue)
        .then((value) {
      setState(() {
        _progressVisibility = false;
        _value = value;
        _file = File(_value);

        filenane = _value.split('/').last;
      });

    });

    var uri = Uri.parse("https://showyourtrade.com/video_upload.php");
    var request = new MultipartRequest("POST", uri);

    var multipartFile = await MultipartFile.fromPath('status_photo', _file.path);
    request.files.add(multipartFile);
    StreamedResponse response = await request.send();
    response.stream.transform(utf8.decoder).listen((value) {
      print(value);
    });

    if(response.statusCode == 200){
     print('ccc');
     print(response.stream);
     print('cc');

    }else{
      print('nor communicating');
    }

    //   Navigator.of(context).push(MaterialPageRoute(
   //   builder: (ctx)=>VideoFilter(_value)
  // ));
    return _value;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
     appBar: AppBar(
       title: Text('Video Trimmer'),
        actions: [
          Container(
              height: Config.yMargin(context, 3),
              child: FlatButton(
                  onPressed: _progressVisibility
                      ? null
                      : () async {
                    _saveVideo().then((outputPath) {
                      print('OUTPUT PATH: $outputPath');
                      // final snackBar = SnackBar(content: Text('Video Saved successfully'));
                      // Scaffold.of(context).showSnackBar(snackBar);
                    });
                  },
                  child: Text(
                    'Next',
                    style: appThemeDark.textTheme.subhead,
                  ))),


        ],
     ),
      body: Builder(
        builder: (context) => Container(
          padding: EdgeInsets.only(bottom: 30.0),
          color: Colors.black,
          child: Stack(
           // mainAxisAlignment: MainAxisAlignment.center,
          //  mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              Visibility(
                visible: _progressVisibility,
                child: LinearProgressIndicator(
                  backgroundColor: Colors.red,
                ),
              ),
         new     Container(

                child: VideoViewer(),
              ),

        new   Container(
          alignment: Alignment.bottomCenter,
          padding: new EdgeInsets.only(
              bottom: Config.yMargin(context, 5),
              top: 10,
              right: 0.0,
              left: 0.0),
              child: TrimEditor(
                viewerHeight: 50.0,
                viewerWidth: MediaQuery.of(context).size.width,
                onChangeStart: (value) {
                  _startValue = value;
                },
                onChangeEnd: (value) {
                  _endValue = value;
                },
                onChangePlaybackState: (value) {
                  setState(() {
                    _isPlaying = value;
                  });
                },
              ),
            ),
        new Container(
           child: Center(
             child: new     FlatButton(
                    child: _isPlaying
                        ? Icon(
                      Icons.pause,
                      size: 80.0,
                      color: Colors.white,
                    )
                        : Icon(
                      Icons.play_arrow,
                      size: 80.0,
                      color: Colors.white,
                    ),
                    onPressed: () async {
                      bool playbackState =
                      await widget._trimmer.videPlaybackControl(
                        startValue: _startValue,
                        endValue: _endValue,
                      );
                      setState(() {
                        _isPlaying = playbackState;
                      });
                    },
                  ),
           ),
         ),

            ],
          ),
        ),
      ),

    );
  }
}
