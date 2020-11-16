

import 'package:flutter/cupertino.dart';

class SinglePerson with ChangeNotifier{
  String username;
  String firstname;
  String lastname;
  String Sector;
  String Industry;
  String BusinnessName;
  String City;
  String LG;
  String State;
  String Country;
  String img;
  SinglePerson(this.username,this.firstname,this.lastname,this.Sector,this.Industry, this.BusinnessName,this.City, this.LG, this.State,this.Country, this.img);

}