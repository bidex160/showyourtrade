

import 'package:flutter/foundation.dart';
import 'package:showyourtrade/Model/sub_category.dart';

class ProductsModel  with ChangeNotifier{
  String name;
  int subheadLength;
  List<String> subheadNmae;
  List<List<dynamic>> items;
  List<SubCategory> subcategory;

  ProductsModel(this.name,this.subheadLength, this.subcategory, this.subheadNmae, this.items);
}