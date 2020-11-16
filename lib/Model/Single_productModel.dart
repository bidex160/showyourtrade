
import 'package:flutter/cupertino.dart';

class SingleProduct with ChangeNotifier{
  String id;
  String store;
  String Category;
  String SubCategory;
  String type;
  String ProductName;
  String img;
  String Price;
  String description;
  SingleProduct(this.id, this.store, this.Category, this.SubCategory, this.type, this.ProductName, this.img, this.Price);

}