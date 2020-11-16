

class AwardModel {
  String id;
  String award;
  String organization;
  String date;

  AwardModel({this.id,this.award, this.organization,this.date});

  factory AwardModel.fromJson(Map<String, dynamic> json){
    var awardModel =  AwardModel(
      id: json['0'] as String,
      award: json['1'] as String,
      organization: json['2'] as String,
      date: json['3'] as String,

    );
    return awardModel;
  }

}