import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:showyourtrade/Model/comment_model.dart';
import 'dart:convert' as convert;
class IndexPostModel with ChangeNotifier{
  String id;
  String osid;
  String account_name;
  String author;
  String shared_author;
  String type;
  String data;
  String statusphoto;
  String postdate;
  String account_type;
  String avatar;
  int likes;
  int comment;
  String likerName;
  bool flag;


  IndexPostModel(this.id, this.osid, this.account_name, this.author, this.shared_author,
    this.type, this.data, this.statusphoto, this.postdate,this.account_type, this.avatar,this.likes, this.comment,this.likerName, this.flag);

  void retweetM(){
    notifyListeners();

  }
  void likeM()async{

    var para = {'u':'bidex160','uAcc':'$account_name','id':'$id'};
    likes = likes+1;
    likerName = 'bidex160';
    print(likes);
    notifyListeners();
    var uri = Uri.https('www.showyourtrade.com','/like.php', para);
    var r =  await http.get(uri);
    print(r.statusCode);
    print(r.body);


  }
  void unlikeM()async{

    var para = {'u':'bidex160','uAcc':'$account_name','id':'$id'};
    likes = likes-1;
    print(likes);
    likerName = null;
    notifyListeners();
    var uri = Uri.https('www.showyourtrade.com','/like.php', para);
    var r =  await http.get(uri);
    print(r.statusCode);
    print(r.body);


  }


  Future<List<dynamic>> commentM() async {
    List<CommentModel> _list = [];
    var para = {'id':'$id'};

   // notifyListeners();
    var uri = Uri.https('www.showyourtrade.com','/post_page.php', para);
    var r =  await http.get(uri,headers: {'Content-Type':'application/json'});
    if(r.statusCode == 200){
      String stringre = r.body.toString();
      var parsedJson = convert.jsonDecode(stringre) as List;

      parsedJson.forEach((element) {
        _list.add(
          CommentModel(element['id'], element['author'], element['data'], element['postdate'])
        );
      });
       print(r.statusCode);
      // print(r.body);
      // print(id);
      return _list;
    }else{
      return _list;
    }

  }

  void checkText(){
   flag = !flag;
   notifyListeners();


  }
}