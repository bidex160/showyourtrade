import 'package:flutter/cupertino.dart';
import 'dart:convert' as convert;
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:showyourtrade/Model/industryModel.dart';

class SectorIndustry with ChangeNotifier{


  static Future<List<dynamic>> Industry() async{
    List<IndustryModel> _list = [];
    print('jsonResponse');
    var para = {'u':'Meks'};
    var uri = Uri.https('www.showyourtrade.com','/industry');
    var res  = await http.get(uri, headers: {'Content-Type':'application/json'});

    if(res.statusCode == 200){
      String stringre = res.body.toString();
      var parsedJson =convert.jsonDecode(stringre) as List;

      parsedJson.forEach((  element) {
        _list.add(
            IndustryModel(
                element['industry'],
                element['img']
            )
        );


      });
      print(_list.length);

      //  notifyListeners();
      return _list;
    }else{
      return _list;
    }




  }


}


