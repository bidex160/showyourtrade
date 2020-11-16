import 'package:flutter/material.dart';

import 'package:html_editor/html_editor.dart';
import 'package:showyourtrade/Size_Config/Config.dart';
class VideoFilter extends StatefulWidget {
 final String path;
 VideoFilter(this.path);
  @override
  _VideoFilterState createState() => _VideoFilterState();
}

class _VideoFilterState extends State<VideoFilter> {
  GlobalKey<HtmlEditorState> keyEditor = GlobalKey();
  @override
  void initState() {

    super.initState();
  }

  String result = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      backgroundColor: Colors.black,
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              HtmlEditor(
                hint: "Your text here...",
                //value: "text content initial, if any",
                key: keyEditor,
                height: 400,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    FlatButton(
                      color: Colors.blueGrey,
                      onPressed: (){
                        setState(() {
                          keyEditor.currentState.setEmpty();
                        });
                      },
                      child: Text("Reset", style: TextStyle(color: Colors.white)),
                    ),
                    SizedBox(width: 16,),
                    FlatButton(
                      color: Colors.blue,
                      onPressed: () async {
                        final txt = await keyEditor.currentState.getText();
                        setState(() {
                          result = txt;
                        });
                      },
                      child: Text("Submit", style: TextStyle(color: Colors.white),),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(result),
              )
            ],
          ),
        ),
      ),


    );
  }
}
