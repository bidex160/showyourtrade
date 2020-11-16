import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:showyourtrade/Model/Single_productModel.dart';
import 'package:showyourtrade/Model/products_model.dart';
import 'package:showyourtrade/Provider/PostProvider.dart';
import 'package:showyourtrade/Provider/products.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;
import 'package:showyourtrade/Size_Config/Config.dart';
import 'package:showyourtrade/apptheme/app_theme.dart';
import 'package:showyourtrade/screen/Product_Descrption.dart';


class ProductFromCategory extends StatefulWidget {
  final ProductsModel productsModel;
  final int index;
  ProductFromCategory(this.productsModel,this.index);
  @override
  _ProductFromCategoryState createState() => _ProductFromCategoryState();
}

class _ProductFromCategoryState extends State<ProductFromCategory> {
  List<SingleProduct> _list = [];
  List<List<SingleProduct>> _list2 = [];
  StreamController<List<SingleProduct>> streamController ;


  Stream<List<SingleProduct>> fetchProdutcs(String name) async* {
    List<SingleProduct> single = [];
  print('im here');
  print(name);
    var parameters = {'p':'$name'};
    var uri = Uri.https('www.showyourtrade.com','/onChangeProduct.php',parameters);
    final response = await http.get(uri, headers: {'Content-Type': 'application/json'});
    print('yess');
    if(response.statusCode == 200){
      print('ok');
      String stringre = response.body.toString();
      final jsonResponse = convert.jsonDecode(stringre) as Map<String, dynamic>;
      jsonResponse.forEach((key, value) {
        single.add(SingleProduct(
          value['0'],
          value['1'],
          value['2'],
          value['3'],
          value['4'],
          value['5'],
          value['6'],
          value['7'],


        ));
      });
      print(stringre);
     yield single;
    }else{

      print('npooo');
    }





  }

  @override
  void dispose() {
    streamController.close();
    super.dispose();
  }
  @override
  void initState() {
    streamController  = StreamController.broadcast();
    streamController.stream.listen((event) {
      _list2.add(event);
    });

   //load(streamController);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
 //   final  CategoryList = Provider.of<ProductsModel>(context,listen: false);

    return Scaffold(
      backgroundColor: appThemeDark.backgroundColor,
      appBar: AppBar(
        title: FittedBox(child: Text('${widget.productsModel.subheadNmae[widget.index]}')),

      ),
      body: ListView.builder(
        itemCount: widget.productsModel.items[widget.index].length,
        itemBuilder: (context, int index){
          return Container(
            height: Config.yMargin(context, 40),
            margin: const EdgeInsets.only(left: 20.0),
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                Text('${widget.productsModel.items[widget.index][index]}',style: appThemeDark.textTheme.subhead,),
                Container(
                  height: Config.yMargin(context, 35),
                  margin: const EdgeInsets.only(top:8.0),
                  width: double.infinity,
                  child: StreamBuilder(
                      stream:  fetchProdutcs(widget.productsModel.items[widget.index][index]),
                   // stream: load(streamController,widget.productsModel.items[widget.index][index]),
                      builder:(context, AsyncSnapshot snapshot ){
                        if(snapshot.connectionState == ConnectionState.done) {
                          _list = snapshot.data;
                          return ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: _list.length,
                            itemBuilder: (ctx, index2) {
                              return Padding(
                                padding: const EdgeInsets.only(right: 8.0),
                                child: Card(
                                  child: Container(

                                    width: Config.xMargin(context, 40),
                                    height: Config.yMargin(context, 40),

                                    child: Column(
                                     crossAxisAlignment: CrossAxisAlignment.start,
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Container(
                                          height: Config.yMargin(context, 20),
                                          child: _list[index2].img != null ?Image.network(
                                            'https://showyourtrade.com/user/${_list[index2].store}/products/${_list[index2].img}',
                                            fit: BoxFit.cover,

                                          ):null,

                                        ),

                                        Padding(
                                          padding: const EdgeInsets.only(left: 10, right: 10),

                                          child: Text( '${_list[index2].ProductName}', style: TextStyle(
                                            color: Colors.black,
                                            fontFamily: 'OpenSans',
                                            fontSize: 17,
                                            fontWeight: FontWeight.w400,
                                            fontStyle: FontStyle.normal,
                                          ),overflow: TextOverflow.ellipsis,),
                                        ),

                                          //backgroundColor: Colors.transparent,

                                          Padding(
                                            padding: const EdgeInsets.only(left: 10, right: 10),
                                            child: FittedBox(child: Text('${_list[index2].Price}',style:  appThemeDark.textTheme.display2,)),
                                          ),



                                        InkWell(
                                          child: Container(
                                            height: Config.yMargin(context, 5),
                                            decoration: BoxDecoration(
                                              shape:BoxShape.rectangle,

                                              border: Border.all(color: Colors.black26),
                                            ),
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                                              children: [
                                                Text('View Details',style:  appThemeDark.textTheme.display2,),
                                                Icon(
                                                  Icons.remove_red_eye
                                                )
                                              ],
                                            ),
                                          ),
                                          onTap: (){
                                            print('${_list[index2].store}');
                                          Navigator.of(context).pushReplacementNamed(ProductDetails.routeName, arguments: {'product':_list[index2]});

                                          },
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            },
                          );
                        }


                        return Container(
                          height: Config.yMargin(context, 100),
                          child: Center(
                              child: CircularProgressIndicator(
                                valueColor: new AlwaysStoppedAnimation<Color>(Colors.white),
                              )),
                        );
                      }

                  ),
                )
              ],
            ),

          );
        },

      ),
    );
  }
}
