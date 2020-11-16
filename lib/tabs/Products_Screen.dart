import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:showyourtrade/Model/post_model.dart';
import 'package:showyourtrade/Provider/products.dart';
import 'package:showyourtrade/Size_Config/Config.dart';
import 'package:showyourtrade/apptheme/app_theme.dart';
import 'package:showyourtrade/stackscreen/show_productRad.dart';
import 'package:showyourtrade/stackscreen/show_product_category.dart';

import '../Model/index_post.dart';
import '../Provider/PostProvider.dart';

class ProductsScreen extends StatefulWidget {
  static const routeName = '/product';

  @override
  _ProductsScreenState createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen> {

 // @override
  // void didChangeDependencies() {
  //   if (_init) {
  //     setState(() {
  //       loading = true;
  //     });
  //   ProductProvider.fetchProducts();
  //   }
  //   _init = false;
  //   super.didChangeDependencies();
  // }

  int _selectnumber =0;

  final List<dynamic> _pages = [

    ShowProductCatogory(),
    ShowProductRand(),


  ];

  void _selectedPage(int index){
    print(index);
    setState(() {
      _selectnumber = index;

    });

  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(

        children: [
          _pages[_selectnumber],

          new Container(
            alignment: Alignment.topCenter,
            padding: new EdgeInsets.only(
                top:Config.yMargin(context, 10),
                right: 10.0,
                bottom: 20,
                left: 10.0),
            child: new Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [

                InkWell(child: Text('By Category',style: appThemeDark.textTheme.subhead,),
                  onTap: (){
                    _selectedPage(0);
                  },

                ),
                SizedBox(width: 7,),
                Text('|',style: appThemeDark.textTheme.subhead,),
                SizedBox(width: 7,),
                InkWell(child: Text('By Products',style: appThemeDark.textTheme.subhead,),

                  onTap: (){
                    _selectedPage(1);
                  },),


              ],
            ),
          ),

        ],
      ),
    );
  }
}
