import 'package:flutter/material.dart';
import 'package:showyourtrade/Size_Config/Config.dart';

class SearchScreen extends StatelessWidget {
  static const routeName = '/search';
  @override
  Widget build(BuildContext context) {
    return Center(
      child: ListView.builder(
        itemCount: 6,
        itemBuilder: (ctx, index){
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
                width: Config.xMargin(context,5),
                color:Colors.green
            ),
          );
        },
      ),
    );
  }
}
