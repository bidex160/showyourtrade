
import 'package:flutter/cupertino.dart';
import 'package:showyourtrade/Model/SinglePersonModel.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

class PeopleSubCategoryListProvider with ChangeNotifier{

  Future<List<SinglePerson>> fetchPersons(String name) async {
    List<SinglePerson> single = [];
    print('im here');
    print(name);
    var parameters = {'s':'$name'};
    var uri = Uri.https('www.showyourtrade.com','/onChangePeople.php',parameters);
    final response = await http.get(uri, headers: {'Content-Type': 'application/json'});
    print('yess');
    if(response.statusCode == 200){
      print('ok');
      String stringre = response.body.toString();
      final jsonResponse = convert.jsonDecode(stringre) as Map<String, dynamic>;
      jsonResponse.forEach((key, value) {
        single.add(SinglePerson(
          value['0'],
          value['1'],
          value['2'],
          value['3'],
          value['4'],
          value['5'],
          value['6'],
          value['7'],
          value['8'],
          value['9'],
          value['10'],



        ));
      });
      print(stringre);
      return single;
    }else{

      print('npooo');
    }





  }



}