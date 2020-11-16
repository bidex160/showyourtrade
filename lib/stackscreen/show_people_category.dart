
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:showyourtrade/Model/sector_industry.dart';
import 'package:showyourtrade/PeopleCategoryWidget/PeopleCategoryList.dart';
import 'package:showyourtrade/Provider/peopleprovider.dart';
import 'package:showyourtrade/Size_Config/Config.dart';
import 'package:showyourtrade/apptheme/app_theme.dart';

class ShowPeopleCategory extends StatefulWidget {
  static const routeName = '/ShowPeopleCategory';
  @override
  _ShowPeopleCategoryState createState() => _ShowPeopleCategoryState();
}

class _ShowPeopleCategoryState extends State<ShowPeopleCategory> {
  List<SectorIndustryModel> _list = [];
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: Colors.black,
      body: Padding(
        padding: const EdgeInsets.only(top:80.0),
        child: StreamBuilder(
            stream:
           Provider.of<PeopleProvider>(context).fetchPeople().asStream(),

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
              print('hherrr');
              print(_list.length);

              return ListView.builder(

                itemCount: _list.length,

                itemBuilder: (ctx, index){

                  return ChangeNotifierProvider.value(
                    value: _list[index],
                    child: PeopleCategoryList(),
                  );
                },
              );
            }


        ),
      ),
    );
  }
}
