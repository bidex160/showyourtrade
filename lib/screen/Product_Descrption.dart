import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:showyourtrade/Model/Single_productModel.dart';
import 'package:showyourtrade/Size_Config/Config.dart';
import 'package:showyourtrade/apptheme/app_theme.dart';
class ProductDetails extends StatefulWidget {
      static const routeName = '/ProductDetails';
  // final SingleProduct singleProduct;
  // ProductDetails(this.singleProduct);
  @override
  _ProductDetailsState createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  @override
  Widget build(BuildContext context) {
    final routeArgs =  ModalRoute.of(context).settings.arguments as Map<String,SingleProduct>;
    final single = routeArgs['product'];

    return Scaffold(
      appBar: AppBar(
        title: FittedBox(
          child: Text('${single.ProductName}'),
        ),
      ),
      backgroundColor: appThemeDark.backgroundColor,
      body: SingleChildScrollView(

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
             width: Config.xMargin(context, 100),
              height: Config.yMargin(context, 30),
              decoration: BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: NetworkImage('https://showyourtrade.com/user/${single.store}/products/${single.img}')
                )
              ),
            ),
            Text('${single.ProductName}',style: appThemeDark.textTheme.subhead,),
          ],
        ),
      ),
    );
  }
}
