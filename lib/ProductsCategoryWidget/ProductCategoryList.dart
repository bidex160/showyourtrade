import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:showyourtrade/Model/products_model.dart';
import 'package:showyourtrade/Size_Config/Config.dart';
import 'package:showyourtrade/apptheme/app_theme.dart';
import 'package:showyourtrade/ProductsCategoryWidget/ProductsfromCatt_list.dart';
class ProductCategoryList extends StatefulWidget {
  @override
  _ProductCategoryListState createState() => _ProductCategoryListState();
}

class _ProductCategoryListState extends State<ProductCategoryList> {
  @override
  Widget build(BuildContext context) {
    final  product = Provider.of<ProductsModel>(context);
    return  Container(
        height: Config.yMargin(context, 30),
        margin: const EdgeInsets.only(left: 20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('${product.name}',style: appThemeDark.textTheme.subhead,),
            Container(
              height: Config.yMargin(context, 25),
              width: double.infinity,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: product.subheadLength,
                itemBuilder: (ctx, index2){

                  return  Container(
                      width: Config.xMargin(context, 35),
                      margin: const EdgeInsets.only(right:8.0, top: 8.0),

                      decoration: BoxDecoration(
                        shape:BoxShape.rectangle,
                        borderRadius: BorderRadius.circular(5),
                        border: Border.all(color: Colors.white),
                        color: Colors.white
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          InkWell(
                            child: Container(
                              height: Config.yMargin(context, 18),
                              decoration: BoxDecoration(
                                shape:BoxShape.rectangle,
                                borderRadius: BorderRadius.circular(5),
                                border: Border.all(color: Colors.white),

                                image: DecorationImage(
                                    image:  AssetImage('images/coin1.jpg'),
                                    fit: BoxFit.cover

                                ),
                              ),

                            ),
                            onTap: (){
                              // print(_list[index].subheadLength);
                              //print(_list[index].items[1].length);
                              //   print('my posit $index2');
                              // print('my posit ${_list[index].items[index2].length}');
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (_){
                                    return ProductFromCategory(product, index2);
                                  }
                              ));
                            },
                          ),
                             Expanded(



                                 
                                child:Text(' ${product.subheadNmae[index2]}',style: appThemeDark.textTheme.display2,),

                             )

                        ],
                      )
                  );
                },
              ),
            )
          ],
        )
    );
  }
}
