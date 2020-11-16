import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:showyourtrade/Model/industryModel.dart';
import 'package:showyourtrade/Provider/sector_industry.dart';
import 'package:showyourtrade/Size_Config/Config.dart';
import 'package:showyourtrade/account/sign_up3.dart';
import 'package:showyourtrade/apptheme/app_theme.dart';

class CreateAccount2 extends StatefulWidget {
  @override
  _CreateAccount2State createState() => _CreateAccount2State();
}

class _CreateAccount2State extends State<CreateAccount2> {
  TextEditingController _firstname= TextEditingController();
  TextEditingController _lastname= TextEditingController();
  TextEditingController _bussinessN= TextEditingController();
  TextEditingController _Dob= TextEditingController();
  TextEditingController _gender= TextEditingController();


  List<String> _Status= ['Agriculture','Business Services','Computer and Electronics', 'Computer Services',
    'Defence', 'Education','Energy and Utilities','Fashion and Makeovers','Financial Services',
    'Government','Health Pharmeceuticals Biotech','Hospitality Travel Recreation','Ideological and Single Issue',
    'Lawyer and Legal Services','Management Services','Computer and Electronics','Manufacturing',
    'Media and Entertainment','Mining and Materials', 'Non-Profit','Professional Services',
    'Real Estate and Constructions','Software and Internet','Retail','TeleCommunication','Transportation and Storage',
    'Wholesale and Distribution'];
  List<String> _Gender =['Male','Female', 'Other'];
  String _selectedgender = "Male";
  String Bn='';
  TextEditingController _controller = TextEditingController();
  DateTime _selectedDate;
  List<IndustryModel> industryList = [];
  List<IndustryModel> _search = [];
  @override
  void initState() {
    _controller.addListener( _printLatestValue) ;
    _checkbusiness();
    super.initState();
  }
  void _checkbusiness() async{
    final pref = await SharedPreferences.getInstance();
    setState(() {
      Bn = pref.getString('businessName');
      print(Bn);
    });

  }
  void _presentDate(BuildContext context){
    showDatePicker(
        context: context, initialDate: DateTime(1900), firstDate: DateTime(1900), lastDate: DateTime.now()).then((value) {
          if(value==null || value  == DateTime.now()){
            return 'Enter Valid Date';
          }
          _selectedDate = value;
    });
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

  void   _showIndustry(BuildContext context){


    var _init = true;
    int a=0,b=0,c=0,d=0,e=0,f=0,g=0,h=0,i=0, j=0,k=0,l=0,m=0,n=0,
        o=0,p=0,q=0,r=0,s=0,t=0,u=0,v=0,w=0,x=0,y=0,z=0;

    showModalBottomSheet(

        isScrollControlled: true,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(25.0),
        ),
        context: context,
        builder: (BuildContext bc) {
          return Container(
            decoration: BoxDecoration(
                shape:BoxShape.rectangle,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: Colors.white),
                color: Colors.white
            ),
            height: Config.yMargin(context, 70),
            child: Scaffold(
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

              resizeToAvoidBottomInset: true,

              body: Container(
                // color: Colors.black,
                height: Config.yMargin(context,90),
                child: Stack(

                  children: [
                    new  Container(
                        alignment: Alignment.topCenter,
                        padding: new EdgeInsets.only(
                            top: 10,
                            right: 10.0,
                            left: 10.0),
                        child: Text('{indexPostModel.comment} comments',style: appThemeDark.textTheme.display2,)),


                    new  Container(
                      alignment: Alignment.topCenter,
                      padding: new EdgeInsets.only(
                          top: 35,
                          right: 10.0,
                          left: 10.0),
                      child: Divider(color: Colors.black45,),

                    ),


                    new  Container(
                        alignment: Alignment.topRight,
                        padding: new EdgeInsets.only(
                            top: 1,

                            right: 10.0),
                        // child: IconButton(icon: Icon(
                        //   Icons.close,
                        //   size: 25,
                        //   color: Colors.red,
                        //
                        // ),
                        //   onPressed: (){
                        //     Navigator.of(context).pop();
                        //   },)
                    ),


                    new  Container(
                      height: Config.yMargin(context, 50),
                      alignment: Alignment.center,
                      margin: new EdgeInsets.only(
                          top: Config.yMargin(context, 6),
                          bottom: Config.yMargin(context, 10),
                          left: 10.0,
                          right: 10.0),
                      // color: Colors.red,
                      child:  StreamBuilder(
                        stream: SectorIndustry.Industry().asStream(),
                        builder: (ctx, snapshot){
                          if(snapshot.connectionState == ConnectionState.waiting){
                            return Center(
                              child: CircularProgressIndicator(
                                valueColor: new AlwaysStoppedAnimation<Color>(Colors.white),
                              ),
                            );
                          }else {

                            industryList = snapshot.data;
                            return ListView.builder(
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


                                      title: Container(

                                          child: Text( _search.length > 0 ?_search[index].industry : industryList[index].industry,style: appThemeDark.textTheme.display2,)),
                                      // trailing: Container(
                                      //
                                      //
                                      //     child: Container(child: FittedBox(child: Text( _search.length > 0 ?_search[index][0] : industryList[index][0].toUpperCase(),style: appThemeDark.textTheme.display2,)))),

                                    ));
                              },


                            );
                          }



                        },
                      ),

                    ),


                  ],
                ),
              ),
            ),
          );
        }
    );

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appThemeDark.backgroundColor,

      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text('Create Account'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('Create Account Here', style: TextStyle(
              fontSize: 25
          ),),

          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Form(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children:<Widget>[


                if(Bn != 'Individual')  TextFormField(
                  style: appThemeDark.textTheme.display2,
                  controller: _bussinessN,
                  autofocus: true,
                  decoration: InputDecoration(
                    labelStyle: appThemeDark.textTheme.display2,
                    contentPadding: const EdgeInsets.all(5.0),
                    filled: true,
                    fillColor: Colors.white,
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white, width: 2.0),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.transparent),
                    ),


                    labelText: "BusinessName",

                  ),
                  validator: (value){
                    if(value.isEmpty){
                      return 'Please enter BusinessName';
                    }
                    return null;
                  },
                ),
                  SizedBox(height: Config.yMargin(context, 2),),

                  TextFormField(
                    style: appThemeDark.textTheme.display2,
                    controller: _firstname,
                    autofocus: true,
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.all(5.0),
                      filled: true,
                      fillColor: Colors.white,
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white, width: 2.0),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.transparent),
                      ),


                      labelText: "FirstName",
                      labelStyle: appThemeDark.textTheme.display2,
                    ),
                    validator: (value){
                      if(value.isEmpty){
                        return 'Please enter FirstName';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: Config.yMargin(context, 2),),
                  TextFormField(
                    style: appThemeDark.textTheme.display2,
                    controller: _lastname,
                    autofocus: true,
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.all(5.0),
                      filled: true,
                      fillColor: Colors.white,
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white, width: 2.0),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.transparent),
                      ),



                      labelText: "LastName",
                      labelStyle: appThemeDark.textTheme.display2,
                    ),
                    validator: (value){
                      if(value.isEmpty){
                        return 'Please enter FirstName';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: Config.yMargin(context, 2),),

                  Container(

                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Select Sector', style: appThemeDark.textTheme.display2,),
                        Icon(
                          Icons.arrow_drop_down_circle
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: Config.yMargin(context, 2),),

                 InkWell(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Select Industry', style: appThemeDark.textTheme.display2,),
                        Icon(
                            Icons.arrow_drop_down_circle
                        ),
                      ],
                    ),
                   onTap: (){
                      _showIndustry(context);
                   },

                  ),
                  SizedBox(height: Config.yMargin(context, 2),),
                  
                  Container(
                    child: Row(
                      children: [
                        Text(_selectedDate == null ? 'No Date Chosen': DateFormat.yMd().format(_selectedDate), style: appThemeDark.textTheme.display2,),
                        FlatButton(onPressed: (){
                          _presentDate(context);
                        }, child: Text('Choose Date', style: appThemeDark.textTheme.display2,))
                      ],
                    ),
                  ),

                  Container(
                    padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                    decoration: BoxDecoration(
                        shape:BoxShape.rectangle,
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: Colors.white),
                        color: Colors.white
                    ),
                    child: DropdownButton<String>(
                      hint: Text("Select Gender..", style: appThemeDark.textTheme.display2,),
                      value: _selectedgender,
                      isExpanded: true,
                      icon: Icon(Icons.arrow_downward),
                      iconSize: 20.0, // can be changed, default: 24.0
                      iconEnabledColor: Colors.black,
                      underline: Container(),

                      items: _Gender.map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child:Text(value, style: appThemeDark.textTheme.display2,),
                        );

                      }).toList(),

                      onChanged: (value){
                        print(value);
                        setState(() {
                          _selectedgender= value;

                        });

                        print(_selectedgender);


                      },

                    ),
                  ),


                ],
              ),
            ),
          ),

          Row(
            mainAxisAlignment: MainAxisAlignment.center,

            children: [
              Padding(
                padding: const EdgeInsets.only(right: 20),
                child: RaisedButton(onPressed: null, child: Text('Go back')),
              ),
              RaisedButton(onPressed: (){
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (ctx){
                      return CreateAccount3();
                    }
                ));
              }, child: Text('Continue'))
            ],
          ),

          Padding(
            padding: const EdgeInsets.only(top: 20),
            child: Text('Already have an account?'),
          ),
          Container(
              padding: const EdgeInsets.all(8.0),
              width: double.infinity,
              child: RaisedButton(onPressed: null, child: Text('Login')))
        ],
      ) ,

    );
  }
}
