import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:showyourtrade/Model/industryModel.dart';
import 'package:showyourtrade/Provider/sector_industry.dart';
import 'package:showyourtrade/Size_Config/Config.dart';
import 'package:showyourtrade/apptheme/app_theme.dart';

class CreateAccount3 extends StatefulWidget {
  @override
  _CreateAccount3State createState() => _CreateAccount3State();
}

class _CreateAccount3State extends State<CreateAccount3> {
List<IndustryModel> industryList = [];
List<IndustryModel> _search = [];
TextEditingController _controller = TextEditingController();
var _init = true;
int a=0,b=0,c=0,d=0,e=0,f=0,g=0,h=0,i=0, j=0,k=0,l=0,m=0,n=0,
    o=0,p=0,q=0,r=0,s=0,t=0,u=0,v=0,w=0,x=0,y=0,z=0;
 @override
  void didChangeDependencies() {
   if(_init){
    print('im here');
     SectorIndustry.Industry().then((value) {
       setState(() {
         industryList = value;

          industryList.forEach((element) {

              if( element.industry.toLowerCase().startsWith('a',0) ){
                a ++;
                print(element);
              }
              if( element.industry.toLowerCase().startsWith('b',0)){
              b++;

            }
              if( element.industry.toLowerCase().startsWith('c',0)){
                c++;

              }
              if( element.industry.toLowerCase().startsWith('d',0)){
                d++;

              }
              if( element.industry.toLowerCase().startsWith('e',0)){
                e++;

              }
              if( element.industry.toLowerCase().startsWith('f',0)){
                f++;

              }
              if( element.industry.toLowerCase().startsWith('g',0)){
                g++;

              }
              if( element.industry.toLowerCase().startsWith('h',0)){
                h++;

              }
              if( element.industry.toLowerCase().startsWith('i',0)){
                i++;

              }
              if( element.industry.toLowerCase().startsWith('j',0)){
                j++;

              }
              if( element.industry.toLowerCase().startsWith('k',0)){
                k++;

              }
              if( element.industry.toLowerCase().startsWith('l',0)){
                l++;

              }
              if( element.industry.toLowerCase().startsWith('m',0)){
                m++;

              }
              if( element.industry.toLowerCase().startsWith('n',0)){
                n++;

              }
              if( element.industry.toLowerCase().startsWith('o',0)){
                o++;

              }
              if( element.industry.toLowerCase().startsWith('p',0)){
                p++;

              }
              if( element.industry.toLowerCase().startsWith('q',0)){
                q++;

              }
              if( element.industry.toLowerCase().startsWith('r',0)){
                r++;

              }
              if( element.industry.toLowerCase().startsWith('s',0)){
                s++;

              }
              if( element.industry.toLowerCase().startsWith('t',0)){
                t++;

              }
              if( element.industry.toLowerCase().startsWith('u',0)){
                u++;

              }
              if( element.industry.toLowerCase().startsWith('v',0)){
                v++;

              }
              if( element.industry.toLowerCase().startsWith('w',0)){
                w++;

              }
              if( element.industry.toLowerCase().startsWith('x',0)){
                x++;

              }
              if( element.industry.toLowerCase().startsWith('y',0)){
                y++;

              }
              if( element.industry.toLowerCase().startsWith('z',0)){
                z++;

              }

           // print(b);



          });

         print(a);
       });

     });
   }
   setState(() {
     _init = false;
   });
    super.didChangeDependencies();
  }

  @override
  void initState() {
    _controller.addListener( _printLatestValue) ;
    super.initState();
  }
_printLatestValue() async {

setState(() {
  _search.clear();
});
   industryList.forEach((element) {
     if(element.industry.startsWith(_controller.text)){
       setState(() {
         _search.add(element);
       });

       print(element);

     }
   });



}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
            automaticallyImplyLeading: false,
        title: Container(
          width:Config.xMargin(context, 70),
         height: Config.yMargin(context, 5),
          child: TextFormField(
            controller:_controller ,
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.all(8.0),
           hintText: 'Enter Sector here',
            suffixIcon: Icon(
              Icons.search,
              color: Colors.white,
            ),
              enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: const BorderSide(
                    color: Colors.white,


                  )

              ),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.transparent),
              ),


              hintStyle: appThemeDark.textTheme.display1,
              labelText: "LastName",
              labelStyle: appThemeDark.textTheme.display2,
            ),
          ),
        ),
        actions: [

         IconButton(

         icon: Icon(
           Icons.add_circle_outline,
           color: Colors.white,
         ),

          ),
          IconButton(

            icon: Icon(
              Icons.more_vert,
              color: Colors.white,
            ),

          )
        ],
      ),

      body:industryList.length> 0 ? Container(
        height: Config.yMargin(context, 100),
        child: ListView.builder(
          itemCount: _search.length > 0 ?_search.length : industryList.length+26 ,
          //itemExtent: 10000,


          itemBuilder: (context, int index){
            if(index == 0 && a>0){
              return ListTile(
                leading:  CircleAvatar(
                  child: Text('A',style: appThemeDark.textTheme.subhead,)),


                );
            }
            if(index == 21 && b >0){
              return Container(
                margin: const EdgeInsets.only(top: 8),
                child: ListTile(
                  leading:  CircleAvatar(
                      child: Text('B',style: appThemeDark.textTheme.subhead,)),


                ),
              );
            }
            if(index == 32 && c >0){
              return Container(
                margin: const EdgeInsets.only(top: 8),
                child: ListTile(
                  leading:  CircleAvatar(
                      child: Text('C',style: appThemeDark.textTheme.subhead,)),


                ),
              );
            }
            if(index == 69 && d>0){
              return Container(
                margin: const EdgeInsets.only(top: 8),
                child: ListTile(
                  leading:  CircleAvatar(
                      child: Text('D',style: appThemeDark.textTheme.subhead,)),


                ),
              );
            }
            if(index == 85 && e >0){
              return Container(
                margin: const EdgeInsets.only(top: 8),
                child: ListTile(
                  leading:  CircleAvatar(
                      child: Text('E',style: appThemeDark.textTheme.subhead,)),


                ),
              );
            }
            if(index == 98  && f >0){
              return Container(
                margin: const EdgeInsets.only(top: 8),
                child: ListTile(
                  leading:  CircleAvatar(
                      child: Text('F',style: appThemeDark.textTheme.subhead,)),


                ),
              );
            }
            if(index == 123  && g >0){
              return Container(
                margin: const EdgeInsets.only(top: 8),
                child: ListTile(
                  leading:  CircleAvatar(
                      child: Text('G',style: appThemeDark.textTheme.subhead,)),


                ),
              );
            }
            if(index == 138  && h >0){
              return Container(
                margin: const EdgeInsets.only(top: 8),
                child: ListTile(
                  leading:  CircleAvatar(
                      child: Text('H',style: appThemeDark.textTheme.subhead,)),


                ),
              );
            }
            if(index == 152  && i >0){
              return Container(
                margin: const EdgeInsets.only(top: 8),
                child: ListTile(
                  leading:  CircleAvatar(
                      child: Text('I',style: appThemeDark.textTheme.subhead,)),


                ),
              );
            }
            if(index == 158 && j >0){
              return Text('J',style: appThemeDark.textTheme.display2,);
            }
            if(index == 160  && k >0){
              return Container(
                margin: const EdgeInsets.only(top: 8),
                child: ListTile(
                  leading:  CircleAvatar(
                      child: Text('L',style: appThemeDark.textTheme.subhead,)),


                ),
              );
            }
            if(index == 169  && l >0){
              return Container(
                margin: const EdgeInsets.only(top: 8),
                child: ListTile(
                  leading:  CircleAvatar(
                      child: Text('M',style: appThemeDark.textTheme.subhead,)),


                ),
              );
            }
            if(index == 198 && n >0){
              return Container(
                margin: const EdgeInsets.only(top: 8),
                child: ListTile(
                  leading:  CircleAvatar(
                      child: Text('N',style: appThemeDark.textTheme.subhead,)),


                ),
              );
            }
            if(index == 207  && o >0){
              return Container(
                margin: const EdgeInsets.only(top: 8),
                child: ListTile(
                  leading:  CircleAvatar(
                      child: Text('O',style: appThemeDark.textTheme.subhead,)),


                ),
              );
            }
            if(index == 239  && p >0){
              return Container(
                  margin: const EdgeInsets.only(top: 8),

                child: ListTile(
                  leading:  CircleAvatar(
                      child: Text('P',style: appThemeDark.textTheme.subhead,)),


                ),
              );
            }
            if(index == 271  && q >0){
              return Container(
                margin: const EdgeInsets.only(top: 8),
                child: ListTile(
                  leading:  CircleAvatar(
                      child: Text('Q',style: appThemeDark.textTheme.subhead,)),


                ),
              );
            }
            if(index == 273 && r >0){
              return Container(
                margin: const EdgeInsets.only(top: 8),
                child: ListTile(
                  leading:  CircleAvatar(
                      child: Text('R',style: appThemeDark.textTheme.subhead,)),


                ),
              );
            }
            if(index == 282 && s >0){
              return Container(
                margin: const EdgeInsets.only(top: 8),
                child: ListTile(
                  leading:  CircleAvatar(
                      child: Text('S',style: appThemeDark.textTheme.subhead,)),


                ),
              );
            }
            if(index == 308 && t >0){
              return Container(
                margin: const EdgeInsets.only(top: 8),
                child: ListTile(
                  leading:  CircleAvatar(
                      child: Text('T',style: appThemeDark.textTheme.subhead,)),


                ),
              );
            }
            if(index == 327 && u >0){
              return Container(
                margin: const EdgeInsets.only(top: 8),
                child: ListTile(
                  leading:  CircleAvatar(
                      child: Text('U',style: appThemeDark.textTheme.subhead,)),


                ),
              );
            }
            if(index == 329  && v >0){
              return ListTile(
                leading:  CircleAvatar(
                    child: Text('V',style: appThemeDark.textTheme.subhead,)),


              );
            }
            return Container(
              padding: const EdgeInsets.only(bottom: 3),
           //   height: Config.yMargin(context, 5),
                width: Config.xMargin(context, 100),
                child: ListTile(
                  //  leading:  CircleAvatar(
                  //    child: Icon(
                  //     Icons.store
                  // ),
                  //  ),

         leading: Container(
           width: Config.xMargin(context, 10),
           child: Html(
             data:"""
        <div>
           ${industryList[index].img}
        </div>
      """,
           ),
         ),

                    title: Container(

                        child: Text( _search.length > 0 ?_search[index].industry : industryList[index].industry,style: appThemeDark.textTheme.display2,)),
                  // trailing: Container(
                  //
                  //
                  //     child: Container(child: FittedBox(child: Text( _search.length > 0 ?_search[index][0] : industryList[index][0].toUpperCase(),style: appThemeDark.textTheme.display2,)))),

                ));
          },


        ),
      ):Container(
        height: Config.yMargin(context, 100),
          child: Center(child: CircularProgressIndicator())),

    );
  }
}
