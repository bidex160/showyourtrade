import 'dart:io';

import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

import 'package:showyourtrade/Model/index_post.dart';

class PostProvider with ChangeNotifier {
  Future<List<dynamic>> networkQuestTest() async {
    List<IndexPostModel> _list = [];
    // var url = 'https://www.showyourtrade.com/post';
    var para = {'u': 'Meks'};
    var uri = Uri.https('www.showyourtrade.com', '/post_page', para);
    var res =
    await http.get(uri, headers: {'Content-Type': 'application/json'});
    print('im here');
    if (res.statusCode == 200) {

      String stringre = res.body.toString();
      var jsonResponse = convert.jsonDecode(stringre) as Map<String, dynamic>;


      jsonResponse.forEach((id,element) {

        _list.add(IndexPostModel(
            element['0'],
            element['1'],
            element['2'],
            element['3'],
            element['4'],
            element['5'],
            element['6'],
            element['7'],
            element['8'],
            element['9'],
            element['10'],
            element['11'],
            element['12'],
            element['13'],
            true));
      });

      print('im here');
     // print(_list[0].account_name);
      return _list;
    } else {
      return _list;
    }
  }
}
