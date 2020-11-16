import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:showyourtrade/Model/sector_industry.dart';
import 'package:showyourtrade/PeopleCategoryWidget/peopleList.dart';
import 'package:showyourtrade/Size_Config/Config.dart';
import 'package:showyourtrade/apptheme/app_theme.dart';

class PeopleCategoryList extends StatefulWidget {
  @override
  _PeopleCategoryListState createState() => _PeopleCategoryListState();
}

class _PeopleCategoryListState extends State<PeopleCategoryList> {
  @override
  Widget build(BuildContext context) {
    final  _list = Provider.of<SectorIndustryModel>(context);
    return Container(
        height: Config.yMargin(context, 30),
        margin: const EdgeInsets.only(left: 20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('${_list.sector}',style: appThemeDark.textTheme.subhead,),
            Container(
              height: Config.yMargin(context, 25),
              //margin: const EdgeInsets.all(8.0),
              width: double.infinity,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: _list.industry.length,
                itemBuilder: (ctx, index2){
                  return InkWell(
                    child: Container(
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
                            Container(

                              decoration: BoxDecoration(
                                shape:BoxShape.rectangle,
                                borderRadius: BorderRadius.circular(5),
                                border: Border.all(color: Colors.white),
                                image: DecorationImage(
                                    image:  AssetImage('images/coin1.jpg'),
                                    fit: BoxFit.cover

                                ),
                              ),
                              height: Config.yMargin(context, 18),

                            ),
                             Expanded(
                               child: Container(
                                 margin: const EdgeInsets.only(left: 7,right: 7, bottom: 8),
                                 child: Text('${_list.industry[index2]}',textAlign:TextAlign.start,style: appThemeDark.textTheme.display2,
                                   overflow: TextOverflow.fade,
                                 ),
                               ),
                             ),
                          ],
                        )
                    ),
                    onTap: (){
                      Navigator.of(context).pushNamed(PeopleSubCatList.routeName,arguments:{'id':index2,'list':_list} );

                    },
                  );
                },
              ),
            )
          ],
        )
    );
  }
}
