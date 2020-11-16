import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:showyourtrade/Model/SinglePersonModel.dart';
import 'package:showyourtrade/Model/sector_industry.dart';
import 'package:showyourtrade/Provider/PeopleSubCategoryListProvider.dart';
import 'package:showyourtrade/Size_Config/Config.dart';
import 'package:showyourtrade/apptheme/app_theme.dart';
class PeopleSubCatList extends StatefulWidget {
  static const routeName = '/PeopleSubCatList';
  // final SectorIndustryModel sectorindustry;
  // final int index;
//  PeopleSubCatList(this.sectorindustry,this.index);

  @override
  _PeopleSubCatListState createState() => _PeopleSubCatListState();
}

class _PeopleSubCatListState extends State<PeopleSubCatList> {
  List<SinglePerson> _peopleList = [];
  @override
  Widget build(BuildContext context) {
    final routeArgs = ModalRoute.of(context).settings.arguments as Map<String,dynamic>;
    final sectorindustry = routeArgs['list'];
    final index = routeArgs['id'];
    print(index);
  //print(sectorindustry.industry[index]);
    return Scaffold(
       appBar: AppBar(
    title: FittedBox(child: Text('${sectorindustry.industry[index]}')),
       ),
      backgroundColor: Colors.black,

      body: StreamBuilder(
        stream: Provider.of<PeopleSubCategoryListProvider>(context).fetchPersons(sectorindustry.industry[index]).asStream(),
        builder: (context, AsyncSnapshot snapshot){
          if(snapshot.connectionState == ConnectionState.done){
          _peopleList = snapshot.data;
          print('lenght ${_peopleList.length}');
          print('${sectorindustry.industry[index]}');
          if(_peopleList != null){
            return GridView.builder(
              itemCount: _peopleList.length,
              padding: const EdgeInsets.all(10.0),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 4.0,
                      crossAxisSpacing: 4.0,
                      childAspectRatio:0.5
                    ),
              itemBuilder: (ctx,index){

                      return ClipRRect(
                        borderRadius: BorderRadius.circular(15),
                        child: Card(
                          child: Container(
                            //margin: const EdgeInsets.only(top: 0.5),
                            decoration: BoxDecoration(
                              shape:BoxShape.rectangle,
                              borderRadius: BorderRadius.circular(15),
                              color: Colors.white,

                            ),

                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                    shape:BoxShape.rectangle,
                                borderRadius: BorderRadius.only(topLeft: Radius.circular(5), topRight: Radius.circular(5)),

                                    image: DecorationImage(
                                      fit: BoxFit.cover,
                                      image: _peopleList[index].img.contains('img_avatar')?
                                      NetworkImage('https://showyourtrade.com/${_peopleList[index].img}'):
                                      NetworkImage('https://showyourtrade.com/${_peopleList[index].img}')
                                    )
                                  ),
                                  height:Config.yMargin(context, 20),



                                ),
                                if(_peopleList[index].BusinnessName.isNotEmpty)    Padding(
                                 padding: const EdgeInsets.only(left: 10, right: 10),
                                 child: Text('${_peopleList[index].BusinnessName}',textAlign:TextAlign.start, style: TextStyle(
                                   color: Colors.black,
                                   fontFamily: 'OpenSans',
                                   fontSize: 17,
                                   fontWeight: FontWeight.w400,
                                   fontStyle: FontStyle.normal,
                                 ),),
                               ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 10, right: 10),
                                  child: Text('${_peopleList[index].firstname} ${_peopleList[index].lastname}', textAlign:TextAlign.start,style: TextStyle(
                                    color: Colors.black,
                                    fontFamily: 'OpenSans',
                                    fontSize: 17,
                                    fontWeight: FontWeight.bold,
                                    fontStyle: FontStyle.normal,
                                  ),),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 10, right: 10),
                                  child: Text('${_peopleList[index].Industry}', textAlign:TextAlign.start,style: TextStyle(
                                    color: Colors.grey,
                                    fontFamily: 'OpenSans',
                                    fontSize: 15,
                                    fontWeight: FontWeight.w400,
                                    fontStyle: FontStyle.normal,
                                  )),
                                ),
                                Flexible(child: Padding(
                                  padding: const EdgeInsets.only(left: 10, right: 10),
                                  child: Text('${_peopleList[index].City}, ${_peopleList[index].State}, ${_peopleList[index].Country}.',
                                    textAlign:TextAlign.start, style:TextStyle(
                                        color: Colors.black,
                                        fontFamily: 'OpenSans',
                                        fontSize: 15,
                                        fontWeight: FontWeight.w400,
                                        fontStyle: FontStyle.normal,
                                      )),
                                )),
                                SizedBox(height: 0.5,)

                              ],
                            ),
                          ),
                        ),
                      );
              },

            );
          }
          }
          return Container(
            height: Config.yMargin(context, 100),
            child: Center(
                child: CircularProgressIndicator(
                  valueColor: new AlwaysStoppedAnimation<Color>(Colors.white),
                )),
          );
        },
      ),
    );
  }
}
