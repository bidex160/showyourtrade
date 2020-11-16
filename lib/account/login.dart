
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:showyourtrade/Size_Config/Config.dart';
import 'package:showyourtrade/tabs/Tab_bar_screen.dart';
import 'package:showyourtrade/account/sign_up.dart';
import 'package:http/http.dart' as http;
import 'package:showyourtrade/apptheme/app_theme.dart';
import 'package:showyourtrade/stackscreen/stories_Screen.dart';

class LoginScreen extends StatefulWidget {
  static const routeName = '/login';
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
String _error='';
var _hide = true;
final _key = GlobalKey<FormState>();
  TextEditingController _username= TextEditingController();
  TextEditingController _password= TextEditingController();
  void validator()async{
    final pref = await SharedPreferences.getInstance();
    pref.setString('username', 'Bidex160');
    if(_key.currentState.validate()){

       print("here");
      var para = {'e':'agerhubapp@gmail.com','p':'Student.2'};
      var url ='https://www.showyourtrade.com/login_app';
      var res  = await http.post(url,body: para);
      if(res.statusCode == 200){

        if(res.body.contains(_username.text.trim())){
          print(res.body);

         // pref.setString('username', '${_username.text.trim()}');
          setState(() {
            _error = res.body;
          });
          Navigator.of(context).pushReplacementNamed(TabScreen.routeName);
        }else{

       print(res.body);
        }
      }else{
        print('Not here');
      }

    }



  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appThemeDark.backgroundColor,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [

          Padding(
            padding: const EdgeInsets.only(top: 20, ),
            child: Text('Login', style: appThemeDark.textTheme.display1),
          ),

          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Form(
              key: _key,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children:<Widget>[
                  TextFormField(
                    style: appThemeDark.textTheme.display2,
                    controller: _username,

                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.all(5.0),
                      filled: true,
                      fillColor: Colors.white,
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white, width: 2.0),
                      ),

                      labelText: "E-mail/Username",
                       labelStyle: appThemeDark.textTheme.display2,
                    ),
                    validator: (value){
                      if(value.isEmpty){
                        return 'Please enter Email/Username';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: Config.yMargin(context, 2),),
                  TextFormField(

                    controller: _password,
                    obscureText: _hide,
                    style: appThemeDark.textTheme.display2,
                    decoration: InputDecoration(
                        contentPadding: const EdgeInsets.all(5.0),
                        filled: true,
                        fillColor: Colors.white,

                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white, width: 2.0),
                        ),

                        labelText: "Password",

                        labelStyle: appThemeDark.textTheme.display2,
                        suffixIcon: IconButton(
                          icon: Icon(
                              Icons.remove_red_eye,

                          ),
                          onPressed: (){
                            setState(() {
                              _hide = !_hide;
                            });
                          },
                        )

                    ),
                    validator: (value){
                      if(value.isEmpty){
                        return 'Please enter password';
                      }
                      return null;
                    },
                  ),

                  SizedBox(height: Config.yMargin(context, 0.5),),
                  Text('$_error', style: appThemeDark.textTheme.display1,),
                  SizedBox(height: Config.yMargin(context, 1.5),),
                 Container(
                   width: Config.xMargin(context, 100),
                   decoration: BoxDecoration(
                       shape:BoxShape.rectangle,
                       borderRadius: BorderRadius.circular(20),
                       border: Border.all(color: Colors.white),

                   ),
                   child: FlatButton(onPressed: (){
                     validator();
                   }, child:Text( 'Login', style: appThemeDark.textTheme.display1,)),
                 )

                ],
              ),
            ),
          ),

          Row(
            mainAxisAlignment: MainAxisAlignment.center,

            children: [
             Text('Dont Have Account?  ',style: appThemeDark.textTheme.display1,),
              InkWell(onTap: (){
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (ctx){
                      return CreateAccount();
                    }
                ));
              }, child: Text('Create Account', style: appThemeDark.textTheme.display1))
            ],
          ),


        ],
      ) ,

    );
  }
}
