
import 'package:flutter/material.dart';
import 'package:showyourtrade/Model/Single_productModel.dart';
import 'package:showyourtrade/Model/products_model.dart';
import 'package:showyourtrade/Size_Config/Config.dart';
import 'package:showyourtrade/apptheme/app_theme.dart';
import 'package:http/http.dart'as http;
import 'dart:convert'  as convert;
class ShowUserProducts extends StatefulWidget {
  final ProductsModel productsModel;
  final username;
  final int index;
  ShowUserProducts(this.productsModel, this.username, this.index);
  @override
  _ShowUserProductsState createState() => _ShowUserProductsState();
}

class _ShowUserProductsState extends State<ShowUserProducts> {
  List<SingleProduct> _list = [];
  Stream<List<SingleProduct>> fetchProdutcs(String name) async* {
    List<SingleProduct> single = [];

    print(name);
   print(widget.username);
    var parameters = {'u':'${widget.username}', 'p':'$name'};
    var uri = Uri.https('www.showyourtrade.com','/onChangeProduct_user.php',parameters);
    final response = await http.get(uri, headers: {'Content-Type': 'application/json'});
    print('yess');
    if(response.statusCode == 200){
      print('im here');
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
  Widget build(BuildContext context) {
    print(widget.username);
    print( widget.productsModel.items[widget.index].length);

    return ListView.builder(
      itemCount: widget.productsModel.items[widget.index].length,
      itemBuilder: (context, int index){
        return Container(
          height: Config.yMargin(context, 40),
          margin: const EdgeInsets.only(left: 20.0, top: 20),
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              Text('${widget.productsModel.items[widget.index][index]}',style: appThemeDark.textTheme.display2,),
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
                        print(snapshot.data);
                        if(_list != null){
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
                                       //   Navigator.of(context).pushReplacementNamed(ProductDetails.routeName, arguments: {'product':_list[index2]});

                                        },
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                        );}
                        return Text('No Items');
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

    );
  }
}

