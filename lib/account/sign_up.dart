
import 'package:country_code_picker/country_code_picker.dart';
import 'package:country_code_picker/country_localizations.dart';
import 'package:flutter/material.dart';
import 'package:country_pickers/country.dart';
import 'package:country_pickers/country_pickers.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:showyourtrade/Size_Config/Config.dart';
import 'package:showyourtrade/account/sign_up2.dart';
import 'package:showyourtrade/apptheme/app_theme.dart';

class CreateAccount extends StatefulWidget {
  @override
  _CreateAccountState createState() => _CreateAccountState();
}

class _CreateAccountState extends State<CreateAccount> {

  TextEditingController _username= TextEditingController();

  TextEditingController _email= TextEditingController();
  TextEditingController _password= TextEditingController();
  TextEditingController _phone= TextEditingController();
  var _loading = false;

  List<String> _Status= ['Individual','Business(Products)','Organization(Services)'];
  String _selectedStatus = "Individual";
  Country _selectedDialogCountry =
  CountryPickerUtils.getCountryByPhoneCode('90');
  final _key = GlobalKey<FormState>();
  var userConfirmed = false;

  var _errorName ="";
  var _errorGeneral= "";

  void validator()async{
    final pref = await SharedPreferences.getInstance();
    if(_key.currentState.validate() && userConfirmed){
      setState(() {
        _loading = true;
      });
      Navigator.of(context).push(MaterialPageRoute(
          builder: (ctx){
            return CreateAccount2();
          }
      ));

     //  var url ='https://www.showyourtrade.com/signup_app';
     // var para = {'u':'${_username.text.trim()}', 'ph':'${_phone.text.trim()}', 's':'i',
     //        'e':'${_email.text.trim()}', 'p':'${_password.text.trim()}'};
     // var regis  = await http.post(url,body: para);
     //  if(regis.statusCode == 200){
     //        print(regis.body);
     //        if(regis.body.contains('signup_success')){
     //
     //          setState(() {
     //            _loading =false;
     //          });
     //          pref.setString('username', '${_username.text.trim()}');
     //          pref.setString('email', '${_email.text.trim()}');
     //          pref.setString('username', '${_phone.text.trim()}');
     //          pref.setString('businessName', '$_selectedStatus');
     //          Navigator.of(context).push(MaterialPageRoute(
     //              builder: (ctx){
     //                return CreateAccount2();
     //              }
     //          ));
     //          print(regis.body);
     //        }else{
     //
     //          setState(() {
     //            _errorGeneral= regis.body;
     //            _loading =false;
     //          });
     //        }
     //
     //
     //
     //      }else{
     //        setState(() {
     //          _loading =false;
     //        });
     //      print('networkFailure');
     //      }








    }



  }
  
  @override
  void initState() {
  _username.addListener(_printLatestValue);
    super.initState();
  }
  _printLatestValue() async {
    var usercheck = {'usernamecheck': '${_username.text.trim()}'};

    var url = 'https://www.showyourtrade.com/signup_app';
    var res = await http.post(url, body: usercheck);

      if (res.statusCode == 200) {
        if (res.body.contains('OK')) {
          setState(() {
            userConfirmed = true;
            _errorName = 'Username is Available';
          });
          print(res.body);
        } else {

          setState(() {

            _errorName = 'Username Already Taken';
          });
          print('Enter Valid Username');
        }
      } else {
        setState(() {
          _loading = false;
        });

  }
    print("Second text field: ${_username.text}");
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: appThemeDark.backgroundColor,
        resizeToAvoidBottomInset: true,
        appBar: AppBar(
          title: Text('Create Account'),
        ),
        body: SingleChildScrollView(
          child: Container(
            height: Config.yMargin(context, 100),
            child: Column(
               mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment:CrossAxisAlignment.center,
              children: [
                Text('Create Account Here', style: TextStyle(
                    fontSize: 25
                ),),
                Padding(
                  padding: const EdgeInsets.only(top: 20, ),
                  child: Text('Personal Details', style: appThemeDark.textTheme.subhead,),
                ),

                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Form(
                    key: _key,
                    child: Column(

                      children:<Widget>[

                        Container(
                          decoration: BoxDecoration(
                              shape:BoxShape.rectangle,
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(color: Colors.black),
                              color: Colors.white
                          ),
                          height: Config.yMargin(context, 7),
                          child: TextFormField(
                            controller: _phone,
                            style: appThemeDark.textTheme.display2,
                            keyboardType: TextInputType.phone,
                                inputFormatters: <TextInputFormatter>[
                                  WhitelistingTextInputFormatter.digitsOnly
                                ],
                            decoration: InputDecoration(
                             prefixIcon: SizedBox(
                               width: Config.xMargin(context, 30),
                               // height: Config.yMargin(context,60),
                               child: Padding(
                                 padding: const EdgeInsets.all(8.0),
                                 child: CountryCodePicker(
                                   backgroundColor: Colors.black,
                                   onChanged: print,
                                   hideMainText: false,
                                   showFlagMain: true,
                                   showFlag: true,
                                   initialSelection: 'TF',
                                   hideSearch: true,
                                   showCountryOnly: false,
                                   showOnlyCountryWhenClosed: false,
                                   alignLeft: true,

                                   onInit: (code) =>
                                       print("on init ${code.name} ${code.dialCode} ${code.name}"),
                                 ),
                               ),
                             ) ,
                              labelText: "Phone",
                              contentPadding: const EdgeInsets.all(5.0),
                              filled: true,
                              fillColor: Colors.white,
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.white, width: 2.0),

                              ),
                              focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.transparent),
                              ),



                            ),

                            validator: (value){
                              if(value.isEmpty){
                                return 'Please Enter Phone';
                              }
                              return null;
                            },
                          ),
                        ),
                        SizedBox(height: Config.yMargin(context, 2),),
                        TextFormField(
                          controller: _email,
                          style: appThemeDark.textTheme.display2,
                          decoration: InputDecoration(
                            labelText: "Email",
                            contentPadding: const EdgeInsets.all(5.0),
                            filled: true,
                            fillColor: Colors.white,
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.white, width: 2.0),
                            ),

                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.transparent),
                            ),

                       errorBorder:  UnderlineInputBorder(
                         borderSide: BorderSide(color: Colors.transparent),

                       ),

                            focusedErrorBorder: UnderlineInputBorder(

                              borderSide: BorderSide(color: Colors.transparent),
                            ),



                          ),
                          validator: (value){
                            if(value.isEmpty){
                              return 'Please enter valid email';
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: Config.yMargin(context, 2),),
                        TextFormField(
                          controller: _username,
                          style: appThemeDark.textTheme.display2,
                          decoration: InputDecoration(
                            labelText: "Username",
                            contentPadding: const EdgeInsets.all(5.0),
                            filled: true,
                            fillColor: Colors.white,
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.white, width: 2.0),
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.transparent),
                            ),



                          ),
                          validator: (value){
                            if(value.isEmpty){
                              return 'Please enter Username';
                            }
                            return null;
                          },
                        ),
                         if(_errorName.isNotEmpty)Container(
                          child: Text('$_errorName',style: appThemeDark.textTheme.subhead),
                        ),
                        SizedBox(height: Config.yMargin(context, 2),),


                        Container(
                          padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                          decoration: BoxDecoration(
                              shape:BoxShape.rectangle,
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(color: Colors.white),
                              color: Colors.white
                          ),
                          child: DropdownButton<String>(
                            hint: Text("Select Status..", style: appThemeDark.textTheme.display2,),
                            value: _selectedStatus,
                            isExpanded: true,
                            icon: Icon(Icons.arrow_downward),
                            iconSize: 20.0, // can be changed, default: 24.0
                            iconEnabledColor: Colors.black,
                            underline: Container(),

                            items: _Status.map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child:Text(value, style: appThemeDark.textTheme.display2,),
                              );

                            }).toList(),

                            onChanged: (value){
                              print(value);
                              setState(() {
                                _selectedStatus= value;

                              });

                              print(_selectedStatus);


                            },

                          ),
                        ),
                        SizedBox(height: Config.yMargin(context, 2),),

                        TextFormField(
                           controller: _password,
                            style: appThemeDark.textTheme.display2,
                          decoration: InputDecoration(
                            labelText: "Password",
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




                          ),
                          validator: (value){
                            if(value.isEmpty){
                              return 'Please enter password';
                            }
                            return null;
                          },
                        ),

                      ],
                    ),
                  ),
                ),
                if(_errorGeneral.isNotEmpty)Container(
                  child: Text('$_errorGeneral',style: appThemeDark.textTheme.subhead),
                ),
                SizedBox(height: Config.yMargin(context, 4),),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,

                  children: [
                   Padding(
                     padding: const EdgeInsets.only(right: 20),
                     child: Container(
                       width: Config.xMargin(context,40),
                         decoration: BoxDecoration(
                           shape:BoxShape.rectangle,
                           borderRadius: BorderRadius.circular(20),
                           border: Border.all(color: Colors.white),

                         ),
                         child: FlatButton(onPressed: null, child: Text('Cancel',style: appThemeDark.textTheme.display1,))),
                   ),
                    Container(
                      width: Config.xMargin(context,40),
                      decoration: BoxDecoration(
                        shape:BoxShape.rectangle,
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: Colors.white),

                      ),
                      child: _loading?Center(child: CircularProgressIndicator()):FlatButton(onPressed: (){
                        validator();

                      }, child: Text('Continue',style: appThemeDark.textTheme.display1,)),
                    )
                  ],
                ),

              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Already have an account?  ', style: appThemeDark.textTheme.display1,),
                    InkWell(onTap: null, child: Text('Login',style: appThemeDark.textTheme.display1,))
                  ],
                ),
              ),

              ],
            ),
          ),
        ) ,

      // ),
    );
  }
}
