
import 'package:flutter/cupertino.dart';
// part 'userprofile.g.dart';
// @JsonSerializable()
class UserProfile with ChangeNotifier{
  String id;
  String username;
  String name1;
  String name2;
  String name3;
  String category;
  String storeName;
  String email;
  String num;
  String gender;
  String Country;
  String State;
  String LG;
  String City;
  String img;
  String dateJoined;
  String dateJoined2;
  String last;
  int following;
  int followers;
  int products;
  int shows;
  int posts;



  UserProfile({this.id, this.username, this.name1, this.name2,this.name3,
               this.category, this.storeName,this.email, this.num,this.gender,
               this.Country, this.State,
              this.LG, this.City, this.img, this.dateJoined, this.dateJoined2, this.last,this.following,
    this.followers,this.products, this.shows,this.posts});

  factory  UserProfile.fromJson(Map<String, dynamic> json) {
    var userProfile = UserProfile(
      id: json['0'] as String,
      username: json['1'] as String,
      name1: json['2'] as String,
      name2: json['3'] as String,
      name3: json['4'] as String,
      category: json['5'] as String,
      storeName: json['6'] as String,
      email: json['7'] as String,
      num: json['8'] as String,
      gender: json['9'] as String,
      Country: json['10'] as String,
      State: json['11'] as String,
      LG: json['12'] as String,
      City: json['13'] as String,
      img: json['14'] as String,
      dateJoined: json['15'] as String,
      dateJoined2: json['16'] as String,
      last: json['17'] as String,
      following: int.parse(json['18']) ?? 0,
      followers:int.parse(json['19']) ??0,
      products: int.parse(json['20']) ??0,
      shows: int.parse(json['21'])??0,
      posts:int.parse(json['22'])??0,

    );
    return userProfile;
  }
}