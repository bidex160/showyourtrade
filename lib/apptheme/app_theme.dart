
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

ThemeData appThemeDark = ThemeData(

  primaryColor: Colors.black,
  accentColor: Color(0xff219653),
  primaryColorLight: Colors.white,
  primaryColorDark: Colors.black,
  backgroundColor: Colors.black,
  splashColor: Colors.purple,
  buttonColor: Colors.blue,


  textTheme: ThemeData.light().textTheme.copyWith(
    title: TextStyle(
        fontFamily: 'OpenSans',
        fontSize: 20.0,
        fontWeight: FontWeight.bold,
        color:Colors.white

    ),
button: TextStyle(),
//subhead subject
    subhead: TextStyle(
        fontFamily: 'OpenSans',
        fontSize: 18,
        fontWeight: FontWeight.w400,
        fontStyle: FontStyle.normal,
        color:Colors.white
      //fontWeight: FontWeight.bold,

    ),
//display e.g labeltext textfield
    display1: TextStyle(
        fontFamily: 'OpenSans',
        fontSize: 16,
        fontWeight: FontWeight.w500,
        color: Colors.white

    ),

    //display e.g textfield style
    display2: TextStyle(
        fontFamily: 'OpenSans',
        fontSize: 16,
        fontWeight: FontWeight.w400,
        fontStyle: FontStyle.normal,
        color:Colors.black
    ),
//button text
    display3: TextStyle(
        fontFamily: 'OpenSans',
        fontSize: 16,
        fontWeight: FontWeight.w500,
        fontStyle: FontStyle.italic,
        color: Colors.red

    ),

//subtitle paper
    subtitle: TextStyle(
        fontFamily: 'OpenSans',
        fontSize: 20,
        fontWeight: FontWeight.w400,
        fontStyle: FontStyle.normal,
        color:Colors.black
    ),



  ),


  appBarTheme:AppBarTheme(
      textTheme:  ThemeData.light().textTheme.copyWith(
        title: TextStyle(
            fontFamily: 'OpenSans',
            fontSize: 20,
            fontWeight: FontWeight.w400,
            color:Colors.white
          //fontStyle: FontStyle.italic
        ),

      )

  ),


);
