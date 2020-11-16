import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'dart:convert' as convert;
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:showyourtrade/Model/sector_industry.dart';

class PeopleProvider with ChangeNotifier {
   Future<List<dynamic>> fetchPeople() async {
    List<SectorIndustryModel> _list = [];

    var uri = Uri.https('www.showyourtrade.com', '/people_app');
    var res =
        await http.get(uri, headers: {'Content-Type': 'application/json'});

    if (res.statusCode == 200) {
      String stringre = res.body.toString();
    var parsedJson = jsonDecode(stringre) as Map<String, dynamic>;
     print(parsedJson.length);
      parsedJson.forEach((id, element) {
        List<dynamic> _subhead  = [];
          var i = element['1'] as Map<String, dynamic>;
          i.forEach((key, value) {
          _subhead.add(value['0']);
          print(value);
          });

        _list.add(SectorIndustryModel(element['0'], _subhead));


      });
       print(_list.length);

      //  notifyListeners();
     return _list;
    } else {
        return _list;
    }
  }
}
