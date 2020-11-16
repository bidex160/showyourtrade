import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:showyourtrade/Model/products_model.dart';
import 'package:showyourtrade/ProductsCategoryWidget/ProductCategoryList.dart';
import 'package:showyourtrade/Provider/PostProvider.dart';
import 'package:showyourtrade/Provider/products.dart';
import 'package:showyourtrade/Size_Config/Config.dart';
import 'package:showyourtrade/apptheme/app_theme.dart';
import 'package:showyourtrade/ProductsCategoryWidget/ProductsfromCatt_list.dart';

class ShowProductCatogory extends StatefulWidget {
  static const routeName = '/ShowProductCatogory';
  @override
  _ShowProductCatogoryState createState() => _ShowProductCatogoryState();
}

class _ShowProductCatogoryState extends State<ShowProductCatogory> {
  List<ProductsModel> _list = [];
  int catLenght =0 ;
 @override
  void didChangeDependencies() {
   Provider.of<ProductProvider>(context).fetchProducts().then((value) {

   });

    super.didChangeDependencies();
  }
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: Colors.black,
      body: Container(
        padding: const EdgeInsets.only(top:80.0),
        child: StreamBuilder(
            stream:
            Provider.of<ProductProvider>(context, listen: false).fetchProducts().asStream(),

            builder: (context, AsyncSnapshot snapshot) {
              //   print(snapshot.data);

              if (snapshot.connectionState == ConnectionState.waiting) {
                return Container(
                  height: Config.yMargin(context, 100),
                  child: Center(
                      child: CircularProgressIndicator(
                        valueColor: new AlwaysStoppedAnimation<Color>(Colors.white),
                      )),
                );
              }
              _list = snapshot.data;

              return ListView.builder(

                itemCount:_list.length,

                itemBuilder: (ctx, index){
              //   catLenght =   _list[index].subcategory

                  return ChangeNotifierProvider.value(
                    value: _list[index],
                    child:ProductCategoryList(),
                  );
                },
              );
            }


        ),
      ),
    );
  }
}
