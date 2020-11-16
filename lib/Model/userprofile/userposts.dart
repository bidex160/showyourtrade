import 'package:flutter/cupertino.dart';

class UserPosts with ChangeNotifier {

  String id;
  String id2;
  String storename;
  String storename2;
  String unknown;
  String type;
  String data;
  String status;
  String dataPosted;
  String avatar;
 int ten;
  int eleven;
  String twelve;

  UserPosts({this.id, this.id2, this.storename,this.storename2,this.unknown,
  this.type,this.data, this.status, this.dataPosted, this.avatar,this.ten, this.eleven,this.twelve});
  //
  factory  UserPosts.fromJson(Map<String, dynamic> json){
    var profile1 = UserPosts(
      id: json['0'] as String,
      id2: json['1'] as String,
      storename: json['2'] as String,
      storename2: json['3'] as String,
      unknown: json['4'] as String,
     type: json['5'] as String,
      data: json['6'] as String,
      status: json['7'] as String,
      dataPosted: json['8']as String,
      avatar: json['9'] as String,
      ten:  json['10']??0,
      eleven: json['11'] ?? 0,
      twelve: json['12']as String,
      
    );
    return profile1;
  }
}