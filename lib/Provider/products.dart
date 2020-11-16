import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'dart:convert' as convert;
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:showyourtrade/Model/products_model.dart';
import 'package:showyourtrade/Model/sub_category.dart';

class ProductProvider with ChangeNotifier {
 Future<List<dynamic>> fetchProducts() async {
   List<ProductsModel> _list = [];
    var uri = Uri.https('www.showyourtrade.com', '/products_app');
    var res =
    await http.get(uri, headers: {'Content-Type': 'application/json'});

    if (res.statusCode == 200) {
      String stringre = res.body.toString();
      var parsedJson = jsonDecode(stringre) as Map<String, dynamic>;
      print(parsedJson.length);
      parsedJson.forEach((id, element) {
        List<String> _subheadname  = [];

        List<List<String>> all =[];

       List<SubCategory> _subhead=[] ;
     //  print(element['0']);
        var p2 = element['1'] as Map<String, dynamic>;
        p2.forEach((key, value) {
       _subheadname.add(value['0']);

       var p3 = value['1'] as Map<String, dynamic>;

       List<String> _items = [];
         p3.forEach((key, value) {
        _items.add(value['0']);


         });
        all.add(_items);
  //   print(_items.length);

        });


        _subhead.add(SubCategory(_subheadname, all));

        // print('sub ${_subheadname.length}');
      _list.add(ProductsModel(element['0'], _subheadname.length,_subhead, _subheadname,all));

      });
      // print(parsedJson);


      // print(_list[0].name);
    //  print('lenght');
    // print(_list[1].subheadNmae[0]);
   //   print(_list[0].subcategory[0].name[1]);
    //print(_list[0].subcategory[0].items[0]);
  // notifyListeners();

     return _list;

    } else {
      return _list;
    }
  }
}
